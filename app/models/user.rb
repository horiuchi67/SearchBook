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
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

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
