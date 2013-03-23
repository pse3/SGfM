class InformationFieldText < InformationFieldType

  def value(value)
    value.to_s
  end

  def value=(value)
    value
  end

  def form(form_helper, key, options = {})
    form_helper.text_field(key, :placeholder => options[:placeholder], :required => options[:required])
  end

end