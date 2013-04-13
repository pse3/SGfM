require 'spec_helper'

describe ActorController do
  it 'creates an actor' #todo this fails
    #Actor.should_receive(:create).with({:actor => {:actor_type => "hospital", :information =>{:city => "Thun", :canton => "Bern"}, :scope => {:city=>"private", :canton=>"private"}, :actor_type_key => "hospital"}, :commit => "Create", :locale=>"en"})
    #post 'create', {:actor => {:actor_type => "hospital", :information =>{:city => "Thun", :canton => "Bern"}, :scope => {:city=>"private", :canton=>"private"}, :actor_type_key => "hospital"}, :commit => "Create", :locale=>"en"}

  it 'adds informations from params'
  it 'adds relations from params'
  it 'returns info types for an actor type'
  it 'updates an actor'
end

