module InformationTypeHelper
  def list_information_types
    @information_types = InformationType.all
  end


end