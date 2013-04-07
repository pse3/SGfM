module InformationTypeHelper

  def information_types
    @information_types = InformationType.all
  end

end