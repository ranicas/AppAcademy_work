class Cat < ActiveRecord::Base
  COLORS = ["calico", "black", "white", "tuxedo", "leopard", "tabby"]
  validates :birth_date, :color, :name, :sex, presence: true
  validate :timeliness
  validate :color_valid
  validate :gender
  

  def age
    Date.today.year - self.birth_date.year
  end
  
  
  def timeliness
    self.birth_date < Date.today
  end
  
  def color_valid
    COLORS.include?(self.color)
  end
  
  def gender
    ["M", "F"].include?(self.sex)
  end
  
end
