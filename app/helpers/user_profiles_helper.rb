module UserProfilesHelper

  def num_unread_messages
    @num_unread_messages ||= Message.where("to_id = ? AND is_read = ?", current_user.id, false).count
  end

end
