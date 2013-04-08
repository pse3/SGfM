class InformationFieldMultipleSelect < InformationFieldType

  def get_value(value)
    value
  end

  def set_value(value)
    # Bug in Rails transmits a blank selection with multiple select, need to get rid of it first
    data = Array.new
    value.each do |element|
      data.push(element) unless element.empty? or element.strip == ''
    end
    data
  end

  def to_s(value)
    value.map{ |element| element.to_s }.join(' | ')
  end

  def form(form_helper, key, options = { :data => [], :required => false, :value => '' })
    form_helper.select(key, options[:data], {:promt => 'select'},
                      { :required => options[:required],
                        :selected  => options[:value],
                        :multiple => true })
  end

end