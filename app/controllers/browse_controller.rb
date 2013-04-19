class BrowseController < ApplicationController
  include ScopesHelper

  def list

    query = params[:query]
    actors = Actor.full_text_search(query, match: :all)


    @actors_hash = Hash.new{|h, k| h[k] = []}
    actors.each do |actor|
      @actors_hash[actor.actor_type].push(actor)
    end

    @all_actors = Actor.all

    render('browse/list')

  end

  def show

    @actor = Actor.find(params[:id])
    @viewer = current_account || :guest
    @informations = scope_array(@actor.informations, @viewer)

    @options = Hash.new

    @informations.each do |info|
        @options[info.information_type_decorator.key.to_sym] = info.value_to_s
    end
    @maps_query = 'http://maps.google.com/maps?q='
    @maps_query+=  @options[:street] + '+' unless @options[:street].nil?
    @maps_query+=  @options[:street_number] + '+' unless @options[:street_number].nil?
    @maps_query+=  @options[:zip_code] + '+' unless @options[:zip_code].nil?

    render('browse/show')

  end



end