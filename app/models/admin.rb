# See class Login for documentation.
class Admin

  include Mongoid::Document

  has_one :login, :as => :account

  def user_type
    self.login.account_type
	end

	def actors
		Actor.all
	end

end
