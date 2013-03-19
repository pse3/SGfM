class AjaxController < ApplicationController

  def add_relationship_form
    render(:partial => 'actor/add_relationship_form', :locals => {})
  end

end