module ScopesHelper
	def list_account_types
		['Self'] + Login.all_account_types
	end

	def list_scope_types
		Scope.all_types
	end
end