module ScopesHelper
	def list_account_types
		Login.all_account_types
	end
end