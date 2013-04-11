class AjaxController < ApplicationController

  def add_relationship_form
    render_partial('actor/add_relationship_form', {  :all_actors => Actor.all  })
  end

  def add_information_type_form
    render_partial('actor_type/add_information_type_form', {:information_types => InformationType.all})
  end

  def information_type_data_form
    information_field_type = InformationFieldType.find_by key: params[:information_field_type]
    information_type = nil
    information_type = InformationType.find_by id: params[:information_type_id] if params[:information_type_id]
    render :partial => InformationTypeHelper.get_partial(information_field_type), :locals => {:information_type => information_type}
  end

  def information_type_option_form
    render_partial 'information_type/data/option', {:remove_button => true}
  end

  private
  def render_partial(file, locals = {})
    #TODO remove random
    locals[:field_number] = Random.new.rand(100...1000000)
    render(:partial => file, :locals => locals)
  end
end