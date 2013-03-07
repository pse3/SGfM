class Admin
  include Mongoid::Document
  has_one :login, :as => :account
end
