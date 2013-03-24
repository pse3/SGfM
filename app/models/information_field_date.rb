class InformationFieldDate < InformationFieldType

  def get_value(value)
    value.strftime('%a %d %b %Y')
  end

  def set_value(value)
    Date.parse(value)
  end

  def form(form_helper, key, options = {})
    #todo not yet done
  end

end