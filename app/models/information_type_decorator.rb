class InformationTypeDecorator

  include Mongoid::Document
  include Scoped

  field :required, :type => Boolean
  field :searchable, :type => Boolean
  field :index, :type => Integer

  belongs_to :actor_type, :class_name => 'ActorType'
  belongs_to :information_type, :class_name => 'InformationType', :inverse_of => nil


	validates_presence_of :actor_type, :information_type #, :index

  # Creates a new InformationTypeDecorator object with arguments
  # @param info_type InformationType that need decorating
  # @param actor_type ActorType that the decorator belongs to
  # @param required Boolean true if informations of type info_type are required, false if optional
  # @param searchable Boolean true if informations of type info_type are searchable, false if not
  def self.create(info_type, actor_type, required, searchable)
    info_type_dec = self.new
    info_type_dec.information_type = info_type
    info_type_dec.required = required
    info_type_dec.searchable = searchable
    info_type_dec.actor_type = actor_type
    info_type_dec.save
    info_type_dec
  end

  # Directs all missing methods forward to the InformationType which is the object that's being decorated
  def method_missing(method, *args)
    args.empty? ? information_type.send(method) : information_type.send(method, args)
  end

end

