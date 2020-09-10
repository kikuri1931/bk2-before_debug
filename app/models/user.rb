class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 after_create :send_welcome_mail
  def send_welcome_mail
    ThanksMailer.send_signup_email(self).deliver
  end


  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  # ---フォロー機能---
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
 # ---フォロー機能---

 # ---検索機能---
  def self.search(search,word)
    if search == "forward_match"
      @users = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @users = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @users = User.where(name: "#{word}")
    elsif search == "partial_match"
      @users = User.where("name LIKE?","%#{word}%")
    else
      @users = User.none
    end
  end
 # ---検索機能---

 # ---住所検索機能---
  include JpPrefecture
  jp_prefecture :prefecture_code  

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
 # ---住所検索機能---

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street, presence: true
end
