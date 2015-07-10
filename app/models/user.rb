class User < ActiveRecord::Base
  has_many :repositories

  validates :username, :email, presence: true
end
