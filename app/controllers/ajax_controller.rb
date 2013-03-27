class AjaxController < ApplicationController

  def add_relationship_form
    render_partial('actor/add_relationship_form', {  :all_actors => Actor.all  })
  end

  def add_information_type_form
    render_partial('actor_type/add_informatoin_type_form')
  end


  private
  def render_partial(file, locals = {})
    locals[:field_number] = Random.new.rand(1...100000)
    render(:partial => file, :locals => locals)
  end
end