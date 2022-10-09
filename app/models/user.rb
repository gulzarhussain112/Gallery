class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true
  has_many :taggings
  has_many :tag,through: :taggings
  before_create { |user| user.name = user.name.capitalize}
  has_many :albums, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:user, :moderator, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def destroy
    update_attributes(deactivated: true) unless deactivated
  end

  def active_for_authentication?
    super && !deactivated
  end

  def set_default_role
    self.role ||= :user
  end
end
