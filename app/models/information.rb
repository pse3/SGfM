# An Information is where exactly one piece of core data is stored. An Information references its InformationType through an InformationTypeDecorator.
# Information objects are embedded in the Actor they belong to. All the Information objects of an Actor together represent the core data of the Actor.
# Information includes Scoped, therefore Information objects have a Scope. by default this is inherited from its InformationType.
class Information

  include Mongoid::Document
  include Scoped

  field :value_of_this_information
  field :created_at, :type => DateTime
  field :changed_at, :type => DateTime

  belongs_to :creator, :class_name => 'User', :inverse_of => nil                                          #referenced / one-way                                                                                                                                                                                                                                                #embedded
  belongs_to :information_type_decorator, :class_name => 'InformationTypeDecorator', :inverse_of => nil   #referenced / one-way
  embedded_in :actor, :class_name => 'Actor'                                                              #embedded

  inherit_scope_from :information_type_decorator

	validates_presence_of :value_of_this_information, :if => :required?
	validates_presence_of :scope

  def initialize
    super
    self.created_at = DateTime.now
  end

  def value
    self.information_type_decorator.information_field_type.get_value(self.value_of_this_information)
  end

  def value=(value)
    self.value_of_this_information = self.information_type_decorator.information_field_type.set_value(value)
  end

  def value_to_s
    self.information_type_decorator.information_field_type.to_s(self.value_of_this_information)
  end

  # Returns the InformationType of this Information without the InformationTypeDecorator.
  def information_type
     self.information_type_decorator.information_type
  end

  def searchable?
    self.information_type_decorator.searchable
  end

  def required?
    self.information_type_decorator.required
  end

end