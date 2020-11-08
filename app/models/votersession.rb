class Votersession < ApplicationRecord
  belongs_to :user, optional: true
  acts_as_voter
end
