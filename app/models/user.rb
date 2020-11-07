class User < ApplicationRecord
  has_many :votersession
  acts_as_voter
end
