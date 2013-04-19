class BrowseController < ApplicationController
  include ScopesHelper

  def list

    actors = Actor.all

    @actors_hash = Hash.new{|h, k| h[k] = []}
    actors.each do |actor|
      @actors_hash[actor.actor_type].push(actor)
    end

    @all_actors = Actor.all

    render('browse/list')

  end

  def show

    @actor = Actor.find(params[:id])
    @guest = :guest
    @informations = scope_array(@actor.informations, @guest)

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