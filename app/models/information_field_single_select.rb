class InformationFieldSingleSelect < InformationFieldType

  def value(value)
    value.to_s
  end

  def value=(value)
    value
  end

  def form(form_helper, key, options = { :data => [], :required => false, :value => '' })
    form_helper.select(key, options[:data],
                       :required => options[:required],
                       :selected  => options[:value] )
  end

end