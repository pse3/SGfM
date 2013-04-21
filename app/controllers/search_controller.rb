class SearchController < ApplicationController
  include ScopesHelper

  def list

    query = params[:query]

    if query.nil?
      @actors_hash = Hash.new
      flash.now[:notice] = t('search.list.enter_query')
    elsif query.size < 3
      @actors_hash = Hash.new
      flash.now[:error] = t('search.list.too_short')
    else
      actors = Actor.full_text_search(query, match: :all)
      amount = 0
      @actors_hash = Hash.new{|h, k| h[k] = []}
      actors.each do |actor|
        @actors_hash[actor.actor_type].push(actor)
        amount += 1
      end
      if amount > 0
        flash.now[:notice] = t('search.list.found', :amount => amount)
      else
        flash.now[:error] =  t('search.list.no_results')
      end
    end

  end

  def show

    @actor = Actor.find(params[:id])

    unless current_login.nil?
      if login_owns_actor(current_login, @actor) or current_login.is_admin?
        redirect_to(show_actor_path)
      end
    end

    @viewer = current_account || :guest
    @informations = scope_array(@actor.informations, @viewer)

    @options = Hash.new

    @informations.each do |info|
        @options[info.information_type_decorator.key.to_sym] = info.value_to_s unless info.value_to_s == ''
    end

    @maps_query = 'http://maps.google.com/maps?q='
    @maps_query+=  @options[:street] + '+' unless @options[:street].nil?
    @maps_query+=  @options[:street_number] + '+' unless @options[:street_number].nil?
    @maps_query+=  @options[:zip_code] + '+' unless @options[:zip_code].nil?

  end



end