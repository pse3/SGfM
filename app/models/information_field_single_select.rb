class InformationFieldSingleSelect < InformationFieldType

  def value(value)
    value.to_s
  end

  def value=(value)
    value[0]
  end

  def form(form_helper, key, options = {})
    puts '---------------'
    puts options
    puts form_helper
    puts '---------------'
    form_helper.select(key, options[:data], :required => options[:required])
  end

end