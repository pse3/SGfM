require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the LoginsHelper. For example:
#
# describe LoginsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe LoginsHelper do
  it 'should return true for user and false for admin' do
    Login.any_instance.stubs(:account_type).returns('User')
    LoginsHelper.is_user?(Login.first).should be_true
    LoginsHelper.is_admin?(Login.first).should be_false
  end
end
