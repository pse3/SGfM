class ScopesController < ApplicationController
	before_filter :authenticate_login!, :authenticate_admin!
	def new
	end

	def create

	end

	def list
		@scopes = Scope.all
	end
end
