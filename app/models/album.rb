class Album < ApplicationRecord
  validates :title, presence: true,length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 6 }
  validates :cover_picture, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
 
  validates :images, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  
  before_create { |album| album.title = album.title.capitalize}
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags,through: :taggings
  has_one_attached :cover_picture
  has_many_attached :images

  scope :published, -> {
      where(:publish => true)
  }
  
  scope :unpublished, -> {
    where(:publish => false)
  }

  def tags_method=(names)
    self.tags = names.split(',').map do |name|
        Tag.where(name: name).first_or_create!
    end
  end

  def tags_method
      tags.map(&:name).join(",")
  end
end
