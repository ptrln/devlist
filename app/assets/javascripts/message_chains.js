window.MSG = {
  Views: {},
  Routers: {},
  Models: {},
  Collections: {},
  Store: {},
  initialize: function($chain, $list, $form, chainsData) {
    MSG.Store.Chains = new MSG.Collections.Chains(chainsData);
    var chainView = new MSG.Views.ChainListView({
      collection: MSG.Store.Chains
    });
    $chain.html(chainView.render().$el);

    new MSG.Routers.MessageRouter($list, $form);
    Backbone.history.start();
    Backbone.history.navigate("#/");
  }
}