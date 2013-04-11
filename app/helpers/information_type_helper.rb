module InformationTypeHelper

  def information_types
    @information_types = InformationType.all
  end

  def information_field_types
    InformationFieldType.all
  end

  @view_mapping = {
      InformationFieldText => 'information_type/data/no_options',
      InformationFieldEmail => 'information_type/data/no_options',
      InformationFieldDate => 'information_type/data/no_options',
      InformationFieldSingleSelect => 'information_type/data/initial_option',
      InformationFieldMultipleSelect => 'information_type/data/localized_options'
  }

  @parse_mapping = {
      InformationFieldText => lambda { |data| },
      InformationFieldEmail => lambda { |data| },
      InformationFieldDate => lambda { |data| },
      InformationFieldSingleSelect => lambda { |data| },
      InformationFieldMultipleSelect => lambda { |data| }
  }

  def self.get_partial(information_field_type)
    @view_mapping[information_field_type.class] || 'information_type/data/no_options'
  end

  def self.parse_data(data, information_field_type)
    @parse_mapping[information_field_type.class].call(data)
  end
end