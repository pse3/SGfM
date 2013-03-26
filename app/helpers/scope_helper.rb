module ScopeHelper

  # sorts out invisible elements of an array
  def scope_array(array, viewer)
    result = []
    array.each do |element|
      result.push element if element.visible?(viewer)
    end
    result
  end
end
