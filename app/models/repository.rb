class Repository < ActiveRecord::Base
  belongs_to :user

  validates :name, :user_id, presence: true
end
