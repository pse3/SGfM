class ActorController < ApplicationController

  before_filter :authenticate_login!

  # Creates a Actor with chosen name and type
  def create
    user = current_login.account
    @actor = Actor.new
    @actor.actor_type = ActorType.find_by_key(params[:actor][:actor_type_key].to_sym)
    @actor_type = ActorType.find_by_key(params[:actor][:actor_type_key].to_sym)

    user.actors.push @actor
    current_actor = @actor

    for info_type in @actor_type.information_type do
      info = Information.new()
      info.value = params[:actor][info_type.key]
      info.information_type = InformationType.find_by_key(info_type.key)
      info.actor = current_actor
    end

    current_actor.save
    user.save
		if(current_actor.valid?)
			flash[:success]= t('actor.create.success')
			redirect_to actors_path
		end

  end

  # Gets all actors of the current logged in user
  # If there are none, return an empty array
  def list
    if current_login.is_admin?
      @actors = Actor.all
    else
      @actors = current_login.account.actors
    end

    if @actors.nil?
      return Array.new
    else
      return @actor
    end
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
    end
    @actor.save
    redirect_to actors_path
  end

	def information_types_for_actor_type
    key = params[:actor_type_key]
    actor_type = ActorType.find_by_key(key)
		information_types =  actor_type.information_type
    render :partial => 'actor/new_actor_information_types', :locals => {:actor_type_key => key,
                                                                        :actor_type => actor_type,
																																				:information_types => information_types}
	end

  # Find actor with given id
  def show
    @actor = Actor.find(params[:id])
  end

end