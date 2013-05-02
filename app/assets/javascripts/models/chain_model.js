MSG.Models.Message = Backbone.RelationalModel.extend({
  url: "/messages"
});

MSG.Models.Chain = Backbone.RelationalModel.extend({
  urlRoot: "/messages",
  relations: [{
    type: Backbone.HasMany,
    key: 'messages',
    relatedModel: MSG.Models.Message,
    collectionType: MSG.Collections.Messages
  }],
  other: function() {
    if (window.current_user) {
      if (window.current_user.screen_name === this.get('user1'))
        return this.get('user2');
      else if (window.current_user.screen_name === this.get('user2'))
        return this.get('user1');
      else
        return undefined;
    }
  },
  read: function() {
    $.get(
      "/messages/" + this.id + "/read", 
      function(response){
        $(".unread-message-counter").html(
          window.current_user.num_unread_messages -= response.changed
        );
      });
    this.get('messages').each(function(msg){
      if (msg.get('to_id') === window.current_user.id && !msg.get('is_read')) { msg.set('is_read', true); }
    });
  },
  unreadCount: function() {
    count = 0;
    this.get('messages').each(function(msg){
      if (msg.get('to_id') === window.current_user.id && !msg.get('is_read')) { count++; }
    });
    return count;
  }
});