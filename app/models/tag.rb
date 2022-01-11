class Tag < ApplicationRecord
    before_create { |tag| tag.name = tag.name.downcase}
    has_many :taggings
    has_many :albums,through: :taggings
    validates :name, presence: true, length: { minimum: 2 }
end
