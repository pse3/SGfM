class InformationFieldDate < InformationFieldType

  def value(value)
    value.strftime('%a %d %b %Y')
  end

  def value=(value)
    Date.parse(value)
  end

  def form(form_helper, key, options = {})
  end

end