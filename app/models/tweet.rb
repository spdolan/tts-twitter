class Tweet < ApplicationRecord
	belongs_to :user

	has_many :tweet_tags
	has_many :tags, through: :tweet_tags

	before_validation :link_check, on: :create

	validates :message, presence: true
	validates :message, length: {maximum: 140, too_long: "Max of 140 characters!"}

	after_validation :apply_link, on: :create
	
private

	def link_check
		if self.message.include? "https://"
			msg_array = self.message.split
			index = msg_array.map {|word| word.include? "https://" }.index(true)
			self.link = msg_array[index]

			if msg_array[index].length > 20
				msg_array[index] = "#{msg_array[index][0..18]}..."
			end

			self.message = msg_array.join(" ")
			
		end
	end

	def apply_link
		msg_array = self.message.split
		index = msg_array.map {|word| word.include? "https://" }.index(true)

		if index
			url = msg_array[index]
			msg_array[index] = "<a href=#{self.link}>#{url}</a>"

		end

		self.message = msg_array.join(" ")
	end
end
