var Referto = function(_models) {
  var self = this;

  self.init = function() {
    // var member = $.extend(new Member(self.user, _model), self.user);
    // self.user = member;
  };
};

Referto.load_posts = function(load_array, _models) {
  $.getJSON('/account/refertos/posts', function(data) {
    $(data).each(function(i, item) {
      var referto = $.extend(new Referto(_models), item);
      referto.init();
      load_array.push(referto);
    });
  });
};

Referto.load_members = function(load_array, _models) {
  $.getJSON('/account/refertos/members', function(data) {
    $(data).each(function(i, item) {
      var referto = $.extend(new Referto(_models), item);
      referto.init();
      load_array.push(referto);
    });
  });
};
