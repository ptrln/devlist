class Message < ActiveRecord::Base
  attr_accessible :body, :chain_id, :from_id, :to_id, :is_read

  belongs_to :chain, class_name: "MessageChain"
  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"

  alias_method :sender, :from
  alias_method :receiver, :to

  def read
    is_read
  end
end