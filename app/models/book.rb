class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

	# ---検索機能---
	def self.search(search,word)
	    if search == "forward_match"
	      @books = Book.where("title LIKE?","#{word}%")
	    elsif search == "backward_match"
	      @books = Book.where("title LIKE?","%#{word}")
	    elsif search == "perfect_match"
	      @books = Book.where(title: "#{word}")
	    elsif search == "partial_match"
	      @books = Book.where("title LIKE?","%#{word}%")
	    else
	      @books = Book.none
	    end
  	end
  	# ---検索機能---

	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true
	validates :title, length: {maximum: 200}
	validates :body, length: {maximum: 200}
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
