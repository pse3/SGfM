class InformationTypeDecorator
  include Mongoid::Document

  field :required, type: Boolean
  field :searchable, type: Boolean
  field :index, type: Integer

  embedded_in :actor_type, class_name: 'ActorType'
  belongs_to :information_type, class_name: 'InformationType', inverse_of: nil

  def self.create(info_type, actor_type, index, required, searchable)
    info_type_dec = self.new
    info_type_dec.information_type = info_type
    info_type_dec.actor_type = actor_type
    info_type_dec.index = index
    info_type_dec.required = required
    info_type_dec.searchable = searchable
    info_type_dec
  end

  def method_missing(method, *args)
    args.empty? ? information_type.send(method) : information_type.send(method, args)
  end

  def self.find_by_key(key)
    where(:information_type => InformationType.find_by_key(key.to_sym)).first
  end

end

