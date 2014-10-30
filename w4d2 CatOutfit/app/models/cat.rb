class Cat < ActiveRecord::Base
  COLORS = ["calico", "black", "white", "tuxedo", "leopard", "tabby"]
  validates :birth_date, :color, :name, :sex, :user_id, presence: true
  validate :timeliness
  validate :color_valid
  validate :gender
  
  belongs_to :user 
  has_many :cat_rental_requests, dependent: :destroy
  

  def age
    Date.today.year - self.birth_date.year
  end
  
  
  def timeliness
    if !self.birth_date.nil? && self.birth_date < Date.today
      true
    else
      errors[:birth_date] << "can't be in the future"
    end
  end
  
  def color_valid
    COLORS.include?(self.color)
  end
  
  def gender
    ["M", "F"].include?(self.sex)
  end
  
end
