module ScopesHelper

	def list_account_types
		['Self'] + Login.account_types
	end

	def list_scope_types
		Scope.all_types
  end

  # sorts out invisible elements of an array
  def scope_array(array, viewer)
    result = []
    array.each do |element|
      result.push element if element.visible?(viewer)
    end
    result
  end

end