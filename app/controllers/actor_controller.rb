class ActorController < ApplicationController

  before_filter :authenticate_login!

  # Creates a Actor with chosen name and type
  def create
    user = current_login.account
    @actor = Actor.new
    @actor_type = ActorType.find_by_key(params[:actor][:actor_type_key].to_sym)
    @actor.actor_type = @actor_type

    @actor_type.information_type.each do |info_type|
      info = Information.new()
      info.value = params[:actor][info_type.key]
      info.information_type = InformationType.find_by_key(info_type.key)
			info.scope = Scope.where(key: params[:actor][:scope][info_type.key].to_sym).first
      info.actor = @actor
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
			info.scope = Scope.where(key: params[:actor][:scope][key.to_sym]).first
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
  end

end