MSG.Views.InitialMessageView = Backbone.View.extend({
  render: function() {
    var r = JST["messages/initial"]();
    this.$el.html(r);
    var formView = new MSG.Views.NewMessageFormView();
    this.$el.find("#initial-message-form").html(formView.render().$el);
    return this;
  }
});