# Primitive class for single select information field types.
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
end