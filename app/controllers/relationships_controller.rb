class RelationshipsController < ApplicationController
	def create
    	user = User.find(params[:user_id])
    	following = current_user.follow(user)
    	if current_user.following?(user)
	    	following.save  	
	    end
	    redirect_back(fallback_location: books_path)
    end
  

  	def destroy
	    user = User.find(params[:user_id])
	    following = current_user.unfollow(user)
	    if current_user.following?(user)
	    	following.destroy
	    end
	    redirect_back(fallback_location: books_path)
    end   
end
