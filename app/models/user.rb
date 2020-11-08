class User < ApplicationRecord
  has_many :votersession
  validates :name, presence: true 
  validates :email, format: { with: /\A.*@.*\.com\z/ }
end
