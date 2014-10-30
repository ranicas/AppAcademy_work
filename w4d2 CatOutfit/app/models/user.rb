class User < ActiveRecord::Base
  attr_reader :password
  
  validates :user_name, :password_digest, :session_token, presence: true
  validates :session_token, :user_name, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :set_session_token
  before_save :make_username_upcase
  
  has_many :cats
  has_many :cat_rental_requests
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name.upcase)
    if !user.nil? && user.is_password?(password)
      user
    else
      nil
    end
  end
  
  def reset_session_token!
    self.session_token =  SecureRandom::urlsafe_base64(16)
    self.save!
    self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  
  private
  
  # def password_not_nil
  # #   if self.password.nil? || self.password.empty?
  # #     errors[:password] << "cannot be blank!"
  # #   end
  # # end
  #
  def set_session_token
    self.session_token ||=  SecureRandom::urlsafe_base64(16)
  end
  
  def make_username_upcase
    self.user_name = self.user_name.upcase
  end
    
end
