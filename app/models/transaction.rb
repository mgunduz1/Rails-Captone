class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  validates :name, presence: true, length: { maximum: 40 }
  validates :amount, presence: true, length: { maximum: 4 }

  scope :external, -> { where(group_id: nil) }
  scope :grouped, -> { where.not(group_id: nil) }
end
