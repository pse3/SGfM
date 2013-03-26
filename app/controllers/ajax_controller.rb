class AjaxController < ApplicationController

  def add_relationship_form
    render(:partial => 'actor/add_relationship_form', :locals => {  :all_actors => Actor.all,
                                                                    :field_number => Random.new.rand(1...100000) })
  end

end