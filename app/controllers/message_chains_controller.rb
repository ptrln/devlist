class MessageChainsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @chains = MessageChain.find_all_for(current_user)
    @thumbs = {}
    @chains.each do |chain| #need better way of getting user thumbnails
      if chain.user1 == current_user.screen_name
        user = User.find_by_screen_name(chain.user2)
      else
        user = User.find_by_screen_name(chain.user1)
      end
      @thumbs[user.screen_name] = user.photo.nil? ? nil : user.photo.url
    end
  end

  def show
    chains = MessageChain.includes(:messages).find(params[:id])
    render :json => chains.to_json(include: [:messages])
  end

  def create
    to_user = User.find_by_screen_name(params[:to])
    if to_user && params[:body].length > 0
      chain = MessageChain.find_or_create_for(to_user, current_user)
      msg = Message.new({
        body: params[:body],
        from_id: current_user.id,
        to_id: to_user.id,
        is_read: false,
        chain_id: chain.id
        })
      if msg.save
        render :json => msg
      else
        render :json => msg.errors, status: 422
      end
    else
      render :json => {status: "ok"}
    end
  end

  def read
    chains = MessageChain.find(params[:id])
    if (chains.user1 == current_user.screen_name)
      chains.user1_last_read
      from_id = User.find_by_screen_name(chains.user2).id
    elsif (chains.user2 == current_user.screen_name)
      chains.user2_last_read
      from_id = User.find_by_screen_name(chains.user1).id
    end
    chains.save!
    count =  Message.update_all({:is_read => true}, {:to_id => current_user.id, :from_id => from_id, :is_read => false})
    render :json => {status: "ok", changed: count}
  end
end