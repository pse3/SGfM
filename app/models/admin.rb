class Admin
  include Mongoid::Document
  has_one :login, :as => :account

	def user_type
		:admin
	end
end
