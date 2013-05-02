MSG.Views.NewMessageFormView = Backbone.View.extend({
  initialize: function(args) {
    this.to = args ? args.to : undefined;
  },

  events: {
    "submit form": "newMessage"
  },

  render: function() {
    console.log(this);
    var r = JST["messages/new"]({
      to: this.to
    });
    this.$el.html(r);
    return this;
  },

  newMessage: function(event) {
    console.log('submit submit submit');
    event.preventDefault();
    var msg = new MSG.Models.Message({
      to: $("#new-message-screen-name").val(),
      body: $("#new-message-body").val()
    });
    if (this.model) { var that = this.model; }

    if (that) { $("#new-message-body").focus(); }
    
    msg.save(null, {
      success: function(model, response) {
        if (!that) { $("#new-message-screen-name").val(""); }
        $("#new-message-body").val("");

        if (MSG.Store.Chains.getAllFor(msg.get('to')) === undefined) {
          var ids = [msg.get('to'), window.current_user.screen_name].sort()
          var chain = new MSG.Models.Chain({user1: ids[0], user2: ids[1]});
          var isNew = true;
        } else {
          var chain = MSG.Store.Chains.getAllFor(msg.get('to'));
        }
        chain.get('messages').add(msg);
        
        if (isNew) { MSG.Store.Chains.add(chain); }
        MSG.Store.Chains.sort();
        Backbone.history.navigate("#/" + msg.get('to'));
      }
    });
  }

});