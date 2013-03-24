class ScopesController < ApplicationController
	before_filter :authenticate_login!, :authenticate_admin!
	def new
	end

	def create
		if params[:scope][:_type] == 'BlacklistScope'
			scope = BlacklistScope.new
		else
			scope = WhitelistScope.new
		end
		scope.key = params[:scope][:key]
		scope.name_translations = params[:scope][:name]
		params[:scope][:list].delete_at(0)
		scope.list = params[:scope][:list]
		if scope.save
			flash[:success]= t('scopes.create.success')
			redirect_to scopes_path
		else
			flash[:error]= t('scopes.create.error')
			redirect_to scopes_create_path
		end
	end

	def edit
		@scope = Scope.find(params[:id])
	end

	def update
		scope = Scope.find(params[:id])
		scope.name_translations = params[:edited_scope][:name]
		params[:edited_scope][:list].delete_at(0) #There's an empty value.. (Don't know why, seems to be the multiselect.)
		scope.list = params[:edited_scope][:list]
		if scope.save
			flash[:success]= t('scopes.update.success')
			redirect_to scopes_path
		else
			flash[:error]= t('scopes.update.error')
			redirect_to scopes_edit_path(scope)
		end
	end

	def destroy
		scope = Scope.find(params[:id])
		if scope.destroy
			flash[:success] = t('scopes.destroy.success')
			redirect_to scopes_path
		else
			flash[:error] = t('scopes.destroy.error')
			redirect_to scopes_path
		end
	end

	def list
		@scopes = Scope.all
	end
end
