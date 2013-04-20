# The Login model represents an abstract login. This is a container
# for devise specific data. It is connected to an account which can either be
# a User or an Admin.
# Author::    Kenneth Radunz  (kenneth.radunz@gmail.com)
class Login

  include Mongoid::Document

  # Include default devise modules. Others available are:
  # :token_authenticatable, ,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  #validations
  validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of :email

  #define how to construct a new Login
  attr_accessible :email, :password, :password_confirmation

  #has an connected account
  belongs_to :account, :polymorphic => true


  def is_user?
    self.account_type == 'User'
  end

  def is_admin?
    self.account_type == 'Admin'
	end

	# Returns all account types in a list
	def self.account_types
		Login.all.distinct("account_type")
	end

end
