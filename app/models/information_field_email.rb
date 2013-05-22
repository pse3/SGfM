# Concrete class for email InformationFieldType objects. Not yet implemented.
class InformationFieldEmail < InformationFieldType

  def get_value(value)
    value
  end

  def set_value(value)
    value
  end

  def to_s(value)
    value.to_s
  end

  def form(form_helper, key, options = {})
    raise NotImplementedError
  end

end