class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	
	def self.looks(matching_option, word_for_search)
		if matching_option == "same_word"
			@book = Book.where(title: word_for_search)
		elsif matching_option == "front_match"
			@book = Book.where("title LIKE ?", "#{word_for_search}%")
		elsif matching_option == "tail_match"
			@book = Book.where("title LIKE ?", "%#{word_for_search}")
		else
			@book = Book.where("title LIKE ?", "%#{word_for_search}%")
		end
	end
end
