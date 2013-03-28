class ActorController < ApplicationController
	include ScopesHelper

  before_filter :authenticate_login!
  before_filter :ensure_user_owns_actor!, :only => [:edit, :update]

  # Creates a Actor with chosen name and type
  def create
    user = current_login.account
    @actor = Actor.new
    @actor_type = ActorType.find_by_key(params[:actor][:actor_type_key].to_sym)
    @actor.actor_type = @actor_type

    #TODO validate that each required information is present
    if params[:actor][:information]
      params[:actor][:information].each_key do |key|
        info_type_decorator = @actor_type.decorator_by_key(key.to_sym)
        information = Information.new
        information.information_type_decorator = info_type_decorator
        information.value=(params[:actor][:information][info_type_decorator.key])
        unless info_type_decorator.scope
          information.scope = Scope.find_by(key: params[:actor][:scope][info_type_decorator.key].to_sym)
        end
        information.actor = @actor
      end
    end

    if params[:relationship]
      references = params[:relationship][:reference]
      types = params[:relationship][:relationship_type]
      comments = params[:relationship][:comment]
      types.each_with_index do |relationship_type,i|
        relation = Relationship.new
        relation.relationship_type = RelationshipType.find_by_key(relationship_type.to_sym)
        relation.actor = @actor
        relation.comment = comments[i]
        relation.reference = references[i]
        relation.save
      end
    end

		user.actors.push(@actor)
		@actor.save
		user.save

		if @actor.valid?
			flash[:success] = t('actor.create.success')
			redirect_to actors_path
		end
	end

	# Gets all actors of the current logged in user hashed by their actor type
	# If the current user is a admin, show all
	def list
		if current_login.is_admin?
			actors = Actor.all
		else
			actors = current_login.account.actors
		end

		@actors_hash = Hash.new{|h, k| h[k] = []}
		actors.each do |actor|
			@actors_hash[actor.actor_type].push(actor)
		end

		@actors_hash
	end

	def edit
		@actor = Actor.find(params[:id])
	end

	# Doesn't do anything
	def new
	end

	def update
		@actor = Actor.find(params[:id])

		params[:actor][:information].each do |key,value|
			info = @actor.find_information_by_key(key.to_sym)
			info.value = value
			unless params[:actor][:scope][key.to_sym].nil?
				info.scope = Scope.find_by(key: params[:actor][:scope][key.to_sym])
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

	# Find actor with given id
	def show
		@actor = Actor.find(params[:id])
		@informations = scope_array(@actor.informations, current_account)
	end

end
