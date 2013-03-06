class Admin
  include Mongoid::Document
  #has a login :D
  has_one :login, as: :loginable
end
