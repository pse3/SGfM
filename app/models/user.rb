# See class Login for documentation.
class User

    include Mongoid::Document

    has_one :login, :as => :account                                       #referenced
    has_many :actors, class_name: 'Actor', inverse_of: :owner             #referenced

		validates_presence_of :login

	def user_type
		self.login.account_type
  end

  def password_required?
    super if confirmed?
  end

  def password_match?
    elf.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

end
