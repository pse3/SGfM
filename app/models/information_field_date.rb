# Concrete class for date InformationFieldType objects. Not yet implemented.
class InformationFieldDate < InformationFieldType

  def get_value(value)
   value
  end

  def set_value(value)
    Date.parse(value)
  end

  def to_s(value)
    value.strftime('%a %d %b %Y')
  end

  def form(form_helper, key, options = {})
    raise NotImplementedError
  end

end