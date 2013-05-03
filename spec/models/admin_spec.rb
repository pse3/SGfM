require 'spec_helper'

describe Admin do
  before do
    #create login
    @login = Login.new

    #create admin
    @admin = Admin.new
    @admin.login = @login
  end

  describe '#admin' do
    it 'knows its user type' do
      expect(@admin.user_type).to eq('Admin')
    end
  end

end