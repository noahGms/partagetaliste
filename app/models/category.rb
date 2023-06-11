class Category < ApplicationRecord
  belongs_to :list

  validates :name, presence: true, uniqueness: { scope: :list_id }
end
