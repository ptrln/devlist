MSG.Views.ChainListView = Backbone.View.extend({
  initialize: function() {
    this.listenTo(this.collection, 'change', this.render.bind(this));
    this.listenTo(this.collection, 'sort', this.render.bind(this));
    this.listenTo(this.collection, 'add', this.render.bind(this));
  },
  events: {
    "click .message-chain": "clickedChain"
  },
  render: function() {
    var r = JST["messages/chain"]({
      chain: this.collection
    });
    this.$el.html(r);
    return this;
  },
  clickedChain: function(event) {
    var target = $(event.currentTarget);
    $(".chains-list-selected").removeClass("chains-list-selected");
    target.addClass("chains-list-selected");
    Backbone.history.navigate("#/" + target.attr('data-to'));
  }
});