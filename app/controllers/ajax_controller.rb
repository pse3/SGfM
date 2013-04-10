class AjaxController < ApplicationController

  def add_relationship_form
    render_partial('actor/add_relationship_form', {  :all_actors => Actor.all  })
  end

  def add_information_type_form
    render_partial('actor_type/add_information_type_form', {:information_types => InformationType.all})
  end

  def information_type_data_form
    information_type = InformationType.find_by id: params[:information_field_type]
    render :partial => InformationTypeHelper.get_partial(information_type)
  end

  private
  def render_partial(file, locals = {})
    locals[:field_number] = Random.new.rand(1...100000)
    render(:partial => file, :locals => locals)
  end
end