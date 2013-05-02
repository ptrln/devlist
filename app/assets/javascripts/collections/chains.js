MSG.Collections.Chains = Backbone.Collection.extend({
  model: MSG.Models.Chain,
  getAllFor: function(id) {
    return MSG.Store.Chains.findWhere({user1: id}) || MSG.Store.Chains.findWhere({user2: id});
  },
  comparator: function(chain1, chain2) {
    if (chain1.unreadCount() === 0 && chain2.unreadCount() !== 0)
      return 1;
    else if (chain1.unreadCount() !== 0 && chain2.unreadCount() === 0)
      return -1;
    else {
      var t1 = chain1.get('messages').last().get('created_at');
      var t2 = chain2.get('messages').last().get('created_at');
      return (t1 < t2) ? 1 : -1;
    }
  }
});