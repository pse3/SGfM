class User

    include Mongoid::Document

    has_one :login, :as => :account

    embeds_many :actors, class_name: 'Actor', inverse_of: :owner             #embedded
    has_many :created, class_name: 'Information', inverse_of: :creator #referenced

end
