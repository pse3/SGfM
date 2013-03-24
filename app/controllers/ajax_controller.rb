class AjaxController < ApplicationController

  def add_relationship_form
    render(:partial => 'actor/add_relationship_form', :locals => {  :all_actors => Actor.all,
                                                                    :field_number => params[:field_number].to_i }) # field number could be a random number from controller
  end

end