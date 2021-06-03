class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  scope :external, -> { where(:group_id => nil)}
  scope :grouped, -> { where.not(:group_id => nil)}


end
