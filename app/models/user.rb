class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :follower, source: :follower_id
  has_many :follow, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :follows, through: :follow, source: :follow_id
  
  attachment :profile_image, destroy: false
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  def self.looks(matching_option, word_for_search)
    if matching_option == "same_word"
    	@user = User.where(name: word_for_search)
    elsif matching_option == "front_match"
    	@user = User.where("name LIKE ?", "#{word_for_search}%")
    elsif matching_option == "tail_match"
    	@user = User.where("name LIKE ?", "%#{word_for_search}")
    else
    	@user = User.where("name LIKE ?", "%#{word_for_search}%")
    end
  end
  
  include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  
end
