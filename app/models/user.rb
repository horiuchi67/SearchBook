class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  attachment :profile_image
  validates :name, presence: true, length: {minimum: 2,maximum: 20}
  validates :introduction, length: {maximum: 50}
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
  #登録時にメールアドレスを不要とする
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
