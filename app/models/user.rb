class User
  include Mongoid::Document
  #has also a login
  has_one :login, as: :loginable
end
