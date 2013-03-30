class InformationTypeDecorator

  include Mongoid::Document
  include Scoped

  field :required, :type => Boolean
  field :searchable, :type => Boolean
  field :index, :type => Integer

  belongs_to :actor_type, :class_name => 'ActorType'
  belongs_to :information_type, :class_name => 'InformationType', :inverse_of => nil


  def self.create(info_type, actor_type, required, searchable)
    info_type_dec = self.new
    info_type_dec.information_type = info_type
    info_type_dec.required = required
    info_type_dec.searchable = searchable
    info_type_dec.actor_type = actor_type
    info_type_dec.save
    info_type_dec
  end

  # todo that looks nice, what does it do?
  def method_missing(method, *args)
    args.empty? ? information_type.send(method) : information_type.send(method, args)
  end

  def self.find_by_information_type(info_type)
    ActorType.find_by(key: key)
  end

end

