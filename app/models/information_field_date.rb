class InformationFieldDate < InformationFieldType

  def value(value)
    value.strftime('%a %d %b %Y')
  end

  def value=(value)
    Date.parse(value)
  end

end