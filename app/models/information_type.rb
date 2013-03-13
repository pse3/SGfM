class InformationType

  include Mongoid::Document

  field :name, :type => String
  field :key, :type => Symbol

  #no mappings needed!

end