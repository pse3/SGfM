class User

    include Mongoid::Document

    has_one :login, :as => :account

    has_many :actors, class_name: 'Actor', inverse_of: :owner             #referenced

end
