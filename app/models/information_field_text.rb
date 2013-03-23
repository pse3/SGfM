class InformationFieldText < InformationFieldType

  def value(value)
    value.to_s
  end

  def value=(value)
    value
  end

end