module InformationTypeHelper

  def information_types
    @information_types = InformationType.all
  end

  def information_field_types
    InformationFieldType.all
  end
end