class InformationFieldText < InformationFieldType

  def get_value(value)
    value.to_s
  end

  def set_value(value)
    value
  end

  def form(form_helper, key, options = { })
    form_helper.text_field(key,
                           :placeholder => options[:placeholder],
                           :required => options[:required],
                           :value => options[:value])
  end

end