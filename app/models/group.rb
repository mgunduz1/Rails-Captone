class Group < ApplicationRecord
    has_many :transactions, dependent: :destroy

    validates :name, presence: true, length: {maximum: 25}
    validates_uniqueness_of :avatar, :name

end
