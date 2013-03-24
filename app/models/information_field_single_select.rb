class InformationFieldSingleSelect < InformationFieldType

  def get_value(value)
    value.to_s
  end

  def set_value(value)
    value
  end

  def form(form_helper, key, options = { :data => [], :required => false, :value => '' })
    form_helper.select(key, options[:data],
                       :required => options[:required],
                       :selected  => options[:value] )
  end

end