class List < ApplicationRecord
  belongs_to :user

  has_many :categories, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :user_id }
end
