module TweetsHelper

	def get_tagged(tweet)
		msg_array = tweet.message.split

	    msg_array.each_with_index do |word, index|
	      if word[0] == '#'
	        if Tag.pluck(:phrase).include?(word)
	          tag = Tag.find_by(phrase: word)
	        else
	          tag = Tag.create(phrase: word)
	        end

	      tweet_tag = TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
	      msg_array[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}<a>"
	      end

	    end

	    tweet.update(message: msg_array.join(" "))
	    return tweet
   	end

end
