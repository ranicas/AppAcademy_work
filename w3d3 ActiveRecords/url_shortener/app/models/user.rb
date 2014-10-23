class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true
  
  has_many(
    :short_url,
    class_name: 'ShortenedUrl',
    foreign_key: :submitter_id,
    primary_key: :id
  )
  
  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :visited_urls,
    Proc.new { distinct }, 
    through: :visits,
    source: :shortened_url
  )
end