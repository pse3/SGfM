module LoginsHelper
  def self.is_user?(login)
    login.account_type == 'User'
  end

  def self.is_admin?(login)
    login.account_type == 'Admin'
  end
end
