class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image
  validates :name, presence: true, length: {minimum: 2,maximum: 20}
  validates :introduction, length: {maximum: 50}
  validates :email, presence:true,length: {minimum: 3,maximum: 30}
  validates :postal_code, format: {with: /\A[0-9]{7}\z/}
  validates :address_city, presence: true,length: {minimum: 1,maximum: 30}
  validates :address_street, presence: true,length: {minimum: 1,maximum: 40}
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  before_validation :set_address
  include JpPrefecture
  jp_prefecture :prefecture_code
  def set_address
    self.address=prefecture_name+address_city+address_street
  end
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  def self.search(method,word)
                if method == "forward_match"
                        @posts = User.where("name LIKE?","#{word}%")
                elsif method == "backward_match"
                        @posts = User.where("name LIKE?","%#{word}")
                elsif method == "perfect_match"
                        @posts = User.where(name: "#{word}")
                elsif method == "partial_match"
                        @posts = User.where("name LIKE?","%#{word}%")
                else
                        @posts = User.all
                end
    end

  #登録時にメールアドレスを不要とする
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
