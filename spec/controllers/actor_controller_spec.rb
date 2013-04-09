require 'spec_helper'

describe ActorController do

  it 'creates an actor' do
    post 'create', {:login => {:email => 'test@myTest.ch', :password => 'test1234', :password_confirmation => 'test1234'}}
  end
  it 'adds informations from params'
  it 'adds relations from params'
  it 'returns info types for an actor type'
  it 'updates an actor'
end

