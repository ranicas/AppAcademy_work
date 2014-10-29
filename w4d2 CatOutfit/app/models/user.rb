class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :session_token, uniqueness: true
  after_initialize :set_session_token
  before_save :make_username_upcase
  
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
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  
  private
  
  def set_session_token
    self.session_token ||=  SecureRandom::urlsafe_base64(16)
  end
  
  def make_username_upcase
    self.user_name = self.user_name.upcase
  end
    
end
