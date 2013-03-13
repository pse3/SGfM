class InformationTypeHelper

  def list_information_types
    @information_types = InformationType.each
  end

end