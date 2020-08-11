class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
  	validates :title, presence:true, length: {minimum: 2,maximum: 20}
	validates :body, presence:true, length: {maximum: 200}
	def self.search(method,word)
                if method == "forward_match"
                        @posts = Book.where("title LIKE?","#{word}%")
                elsif method == "backward_match"
                        @posts = Book.where("title LIKE?","%#{word}")
                elsif method == "perfect_match"
                        @posts = Book.where(title: "#{word}")
                elsif method == "partial_match"
                        @posts = Book.where("title LIKE?","%#{word}%")
                else
                        @posts = Book.all
                end
    end
end
