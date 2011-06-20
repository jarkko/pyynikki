Event.addBehavior({
  'body' : function(e) {
    var highlighted = $(location.hash.replace(/#/, ''));
    if (highlighted) {
      highlighted.addClassName("highlight");
    }
  }
});
