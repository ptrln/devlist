module FollowableHelper

  def followable(thing)
    unless thing.follower_ids.include?(current_user.id)
      thing.follows.create(follower_id: current_user.id)
    end
  end

  def unfollowable(thing)
    Follow.destroy(thing, current_user.id)
  end
     
end