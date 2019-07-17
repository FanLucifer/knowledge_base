class User < ApplicationRecord
  validates :username, presence: true
  validates :tel, uniqueness: true
end
