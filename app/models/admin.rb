class Admin

  include Mongoid::Document

  has_one :login, :as => :account

  has_many :actors, class_name: 'Actor', inverse_of: :owner             #referenced

  def user_type
    self.login.account_type
  end

end
