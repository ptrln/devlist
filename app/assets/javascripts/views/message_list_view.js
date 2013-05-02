MSG.Views.MessageListView = Backbone.View.extend({
  initialize: function(args) {
    var msgs = this.model.get('messages');
    this.listenTo(msgs, 'add', this.rerender.bind(this));
    this.formView = new MSG.Views.NewMessageFormView({
      model: model,
      to: args.toId
    });
    this.formView.render();
  },
  events: {
    "click .close-message-btn": "closeMessageList"
  },
  render: function() {
    var r = JST["messages/message"]({
      messages: this.model.get('messages'),
      me: window.current_user.screen_name,
      you: this.model.other()
    });
    this.$el.html(r);
    this.$el.find("#message-list-form").html(this.formView.$el);
    setTimeout(function(){
      var msgBox = this.$el.find(".box-content");
      console.log(msgBox.prop("scrollHeight"));
      msgBox.animate({ scrollTop: msgBox.prop("scrollHeight") - msgBox.height() }, 1000);
    }.bind(this), 100);
    this.$el.find("abbr.timeago").timeago();
    this.model.read();
    return this;
  },
  rerender: function() {
    var r = JST["messages/message"]({
      messages: this.model.get('messages'),
      me: window.current_user.screen_name,
      you: this.model.other()
    });
    var oldHeight = this.$el.find("#message-scrollable").prop('scrollHeight');
    var oldScrollTop = this.$el.find("#message-scrollable").prop('scrollTop');
    var form = this.$el.find("#message-list-form").detach();
    this.$el.html(r);
    this.$el.find("#message-scrollable").prop('scrollTop', oldScrollTop);
    form.appendTo(this.$el.find("#message-list-form"));
    setTimeout(function(){
      var msgBox = this.$el.find(".box-content");
      console.log(msgBox.prop("scrollHeight"));
      msgBox.animate({ scrollTop: msgBox.prop("scrollHeight") }, 1000);
    }.bind(this), 100);
    this.$el.find("abbr.timeago").timeago();
    this.model.read();
    return this;
  },
  closeMessageList: function() {
    $(".chains-list-selected").removeClass("chains-list-selected");
    Backbone.history.navigate("#/");
  }
});