class HomeController < ApplicationController
  def index
    @logins = Login.all
  end
end
