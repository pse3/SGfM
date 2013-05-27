# Controller for objects of class Actor.
# Mediates inputs and converts them to commands for the model-class and the view.
class ActorController < ApplicationController
	include ScopesHelper

  before_filter :authenticate_login!, :except => [:show, :search]
  before_filter  :owns_actor_or_is_admin!, :only => [:edit, :update]

  # Creates an Actor of chosen ActorType and with params as Information objects.
  def create
    user = current_account
    actor = Actor.new
    actor_type = ActorType.find_by_key(params[:actor][:actor_type].to_sym)
    actor.actor_type = actor_type

    if params[:actor][:information]
      params[:actor][:information].each_key do |key|
        info_type_decorator = actor_type.decorator_by_key(key.to_sym)
        information = Information.new
        information.information_type_decorator = info_type_decorator
        information.value=(params[:actor][:information][info_type_decorator.key])
        unless info_type_decorator.scope
          information.scope = Scope.find_by(key: params[:actor][:scope][info_type_decorator.key].to_sym)
        end
        information.actor = actor
      end
    end

    if params[:relationships]
      params[:relationships].each_key do |key|
        relationship_type = RelationshipType.find_by key: key
        params[:relationships][key].each_key do |key2|
          reference = Actor.find_by id: params[:relationships][key][key2][:reference]
          relationship = Relationship.new
          relationship.relationship_type = relationship_type
          relationship.actor = actor
          relationship.reference = reference
          relationship.comment = params[:relationships][key][key2][:comment]
          relationship.scope = Scope.find_by(key: params[:relationships][key][key2][:scope].to_sym)
          relationship.save
        end
      end
    end

		user.actors.push(actor)
		actor.save
		user.save

		if actor.valid?
			flash[:success] = t('actor.create.success')
			redirect_to actors_path
		else
			flash[:error] = t('actor.create.failure')
			redirect_to actors_create_path
		end
	end

	# Gets all Actor objects of the current logged in User hashed by their ActorType.
	# If the current Login is an Admin, show all Actor objects.
	def list
		if current_login.is_admin?
			actors = Actor.all
		else
			actors = current_account.actors
    end

    if actors.size == 0
      redirect_to create_actor_path
    elsif actors.size == 1
      @actor = actors.first
      @informations = scope_array(@actor.informations, current_account)
      @relationships = scope_array(@actor.relationships, current_account)
      render('actor/internal_show')
    else
      @actors_hash = Hash.new{|h, k| h[k] = []}
      actors.each do |actor|
        @actors_hash[actor.actor_type].push(actor)
      end
      if current_login.is_admin?
        render('actor/admin_list')
      else
        render('actor/user_list')
      end
    end
  end

	def edit
		@actor = Actor.find(params[:id])
	end

	def new
    unless current_login.is_user?
      flash[:error] = t('actor.new.admin_can_not_create_actors')
      redirect_to actors_path
    end
	end

	def update
		@actor = Actor.find(params[:id])

		params[:actor][:information].each do |key,value|
			info = @actor.find_information_by_key(key.to_sym)
			info_type_decorator = @actor.actor_type.decorator_by_key(key.to_sym)

			if info.nil?
				info = Information.new
				info.information_type_decorator = info_type_decorator
				info.actor = @actor
			end

			info.value = value
			unless info_type_decorator.scope
				info.scope = Scope.find_by(key: params[:actor][:scope][info_type_decorator.key].to_sym)
			end
		end
		@actor.save

		flash[:success] = t('actor.update.success')
		redirect_to actors_path
	end

	def information_types_for_actor_type
		key = params[:actor_type_key]
		actor_type = ActorType.find_by_key(key)
		information_types = actor_type.information_type_decorators
		render(:partial => 'actor/new_actor_information_types', :locals => {:actor_type_key => key,
																																				:actor_type => actor_type,
																																				:information_types => information_types})
  end

  # Search for Actor objects that match the search query and display them.
  def search
    query = params[:query]

    if query.nil?
      @actors_hash = Hash.new
    elsif query.size < 3
      @actors_hash = Hash.new
      flash.now[:error] = t('actor.list.too_short')
    else
      actors = Actor.full_text_search(query, match: :all)
      amount = 0
      @actors_hash = Hash.new{|h, k| h[k] = []}
      actors.each do |actor|
        @actors_hash[actor.actor_type].push(actor)
        amount += 1
      end
      if amount > 0
        flash.now[:notice] = t('actor.list.found', :amount => amount)
      else
        flash.now[:error] =  t('actor.list.no_results')
      end
    end

  end

	def show
    @actor = Actor.find(params[:id])
    if login_owns_actor(current_login, @actor) or is_admin(current_login)
      @informations = scope_array(@actor.informations, current_account)
			@relationships = scope_array(@actor.relationships, current_account)
      render('actor/internal_show')
    else
      @viewer = current_account || :guest
      @informations = scope_array(@actor.informations, @viewer)
			@relationships = scope_array(@actor.relationships, @viewer)
			render('actor/external_show')
    end

  end

  def destroy
    actor = Actor.find(params[:id])

    relationships = Relationship.where(:reference => actor.id)
    relationships.each do |relationship|
      relationship.destroy
    end
    actor.destroy

    flash[:success] = t('actor.destroy.success')
    redirect_to(actors_path)
  end

end
