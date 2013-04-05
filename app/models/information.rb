class Information

  include Mongoid::Document
  include Scoped

  # todo needed to name this different otherwise its not clear what self.value is aiming for, do you know how to solve that?
  field :shit_value
  field :created_at, :type => DateTime
  field :changed_at, :type => DateTime

  belongs_to :creator, :class_name => 'User', :inverse_of => nil                                          #referenced / one way relationship                                                                                                                                                                                                                                                 #embedded
  belongs_to :information_type_decorator, :class_name => 'InformationTypeDecorator', :inverse_of => nil   #referenced / one way relationship
  embedded_in :actor, :class_name => 'Actor'                                                              #embedded

  inherit_scope_from :information_type_decorator


  def initialize
    super
    self.created_at = DateTime.now
  end

  def value
    self.information_type_decorator.information_field_type.get_value(self.shit_value)
  end

  def value=(value)
    self.shit_value = self.information_type_decorator.information_field_type.set_value(value)
  end

  def value_to_s
    self.information_type_decorator.information_field_type.to_s(self.shit_value)
  end

  # Returns the information type of this information without the decorator
  def information_type
     self.information_type_decorator.information_type
  end

  def searchable?
    self.information_type_decorator.searchable
  end

  def required?
    self.information_type_decorator.required
  end

  def index
    self.information_type_decorator.index
  end

  def public?
    self.scope.key == "public" # TODO use here string or scope?
  end

end