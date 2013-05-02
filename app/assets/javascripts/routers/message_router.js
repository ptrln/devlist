MSG.Routers.MessageRouter = Backbone.Router.extend({
  initialize: function($list) {
    this.$list = $list;
  },

  routes: {
    "": "chain",
    ":id": "chain"
  },

  chain: function(id) {
    if (id) {
      model = MSG.Store.Chains.getAllFor(id);
      var view = new MSG.Views.MessageListView({
        model: model,
        toId: id
      });
    } else {
      // if (MSG.Store.Chains.length > 0) {
      //   Backbone.history.navigate("#/" + MSG.Store.Chains.first().other());
      // } else {
        var view = new MSG.Views.InitialMessageView();
      //}
    }
    this.$list.html(view.render().$el);
  }

});