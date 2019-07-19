class User < ApplicationRecord
  validates :username, presence: true
  validates :tel, uniqueness: true
  validates :gender, presence: true, if: :female?

  def female?
      true == false
  end

  after_find do |user|
    p "find object"
  end
end
