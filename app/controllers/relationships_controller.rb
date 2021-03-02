class RelationshipsController < ApplicationController
    
    def follow
        follow = Relationship.where(follower_id: current_user.id)
        p '-------------'
        p follow

        @users = User.where(id: follow.pluck(:follow_id))
        p '-------------'
        p @users
    end
    
    def follower
        follow = Relationship.where(follow_id: current_user.id)
        p '-------------'
        p follow

        @users = User.where(id: follow.pluck(:follower_id))
        p '-------------'
        p @users
    end
    
    def create
        user = User.find(params[:user_id])
        follow = user.follow.new(follow_id: user.id, follower_id: current_user.id)
        follow.save
        redirect_to request.referer
        
    end
    
    def destroy
        user = User.find(params[:user_id])
        follow = user.follow.find_by(follow_id: user.id, follower_id: current_user.id)
        follow.destroy
        redirect_to request.referer
    end
    
end
