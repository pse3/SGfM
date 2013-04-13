class User

    include Mongoid::Document

    has_one :login, :as => :account
    has_many :actors, class_name: 'Actor', inverse_of: :owner             #referenced

		validates_presence_of :login

	def user_type
		self.login.account_type
	end

end
