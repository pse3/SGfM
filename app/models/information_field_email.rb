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
    #todo not yet done
    raise NotImplementedError
  end

end