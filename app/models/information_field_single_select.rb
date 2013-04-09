class InformationFieldSingleSelect < InformationFieldType

  def get_value(value)
    value
  end

  def set_value(value)
    value
  end

  def to_s(value)
    value.to_s
  end

  def form(form_helper, key, options = { :data => [], :required => false, :value => '' })
    form_helper.select(key, options[:data], :required => options[:required], :selected  => options[:value] )
  end

  def parse_data(data)
    result ={}
    data.each do |key, value|
      result[key] = value.split(%r{,\s*})
    end
    result
  end
end