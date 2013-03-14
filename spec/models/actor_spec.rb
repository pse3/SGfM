require 'spec_helper'

describe Actor do
  before { @actor = Actor.new }
  subject { @actor }

  it {should be_an_instance_of Actor}

  it {should respond_to(:owner)}
  it {should respond_to(:informations)}
  it {should respond_to(:actor_type)}


end
