class LoginsController < ApplicationController
  before_filter :authenticate_login!

  def show
  end
end
