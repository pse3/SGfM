require 'test_helper'

class ActorTest  < ActiveSupport::TestCase

  def test_creation
    actor = Actor.new
    actor.name = "Patrick Suter"
    assert_equal(actor.name, "Patrick Suter")
  end

end