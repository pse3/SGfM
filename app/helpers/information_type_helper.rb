module InformationTypeHelper

  def information_types
    @information_types = InformationType.all
  end

  def information_field_types
    InformationFieldType.all
  end

  @mapping = {
      InformationFieldText => 'information_type/data/no_options',
      InformationFieldEmail => 'information_type/data/no_options',
      InformationFieldSingleSelect => 'information_type/data/localized_options',
      InformationFieldMultipleSelect => 'information_type/data/localized_options'
  }

  def self.get_partial(information_type)
    @mapping[information_type.class] || 'information_type/data/no_options'
  end
end