class User
  include Mongoid::Document

  field :test, :type => String, :default => 'this is a test value'

  has_one :login, :as => :account
end
