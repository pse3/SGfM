class ActorController < ApplicationController

  before_filter :authenticate_login!
  before_filter :ensure_user_owns_actor!, :only => [:edit, :update]

  # Creates a Actor with chosen name and type
  def create
    user = current_login.account
    @actor = Actor.new
    @actor_type = ActorType.find_by_key(params[:actor][:actor_type_key].to_sym)
    @actor.actor_type = @actor_type

		unless params[:actor][:information].nil?
      params[:actor][:information].each do |key,value|
        info_type = InformationType.find_by_key(key.to_sym)
        information = Information.new
        information.value = value
        information.information_type = info_type
				unless info_type.has_predefined_scope?
					information.scope = Scope.find_by(key: params[:actor][:scope][info_type.key].to_sym)
				else
					information.scope = info_type.predefined_scope
				end
				@actor.informations.push information
      end
    end

    #TODO validate that each required information is present

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
			info.scope = Scope.find_by(key: params[:actor][:scope][key.to_sym])
    end
    @actor.save

    flash[:success] = t('actor.update.success')
    redirect_to actors_path
  end

	def information_types_for_actor_type
    key = params[:actor_type_key]
    actor_type = ActorType.find_by_key(key)
		information_types =  actor_type.information_type
    render(:partial => 'actor/new_actor_information_types', :locals => {:actor_type_key => key,
                                                                        :actor_type => actor_type,
																																				:information_types => information_types})
	end

  # Find actor with given id
  def show
    @actor = Actor.find(params[:id])
    @informations = ScopesHelper.scope_array(@actor.informations, current_account)
  end

end