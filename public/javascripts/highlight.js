Event.addBehavior({
  'body' : function(e) {
    var highlighted = $(location.hash.replace(/#/, 'run_'));
    if (highlighted) {
      highlighted.addClassName("highlight");
    }
  }
});
