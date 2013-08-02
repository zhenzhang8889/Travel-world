var Post = function(_models) {
  var self = this;
  self.user = {};
  self.replies = ko.observableArray([]);
  self.models = _models;
  self.contacts = _models.contacts;

  self.refer_to_state = ko.observable(0);
  // self.refer_to_users = ko.observableArray([]);

  // self.not_refered_users = ko.computed(function() {
  //   var refered = $.map(self.refer_to_users(), function(u){
  //     return u.id;
  //   });
  //   var all = _models.contacts();

  //   var  rs = [];
  //   $(all).each(function(idx, u) {
  //     if($.inArray(u.id, refered) < 0) {
  //       rs.push(u);
  //     }
  //   });

  //   return rs;
  // }, self);

  self.refer_to = function(_type, _data, _event) {
    var t = _event.target || _event.srcElement;
    var contacts_list = $(t).parent().parent().parent().next();

    self.refer_to_state(_type);
    setTimeout(function() {
      contacts_list.addClass('open');
      console.log(self.refer_to_state());
    }, 0);
  };

  self.init = function() {
    if(self.postreplies) {
      $(self.postreplies).each(function(ind, ele) {
        var new_reply = $.extend(new PostReply(), ele);
        self.replies.push(new_reply);
      });
    }
  };

  self.to_reply = function(formElement) {
    $(formElement).ajaxSubmit({
      success: function(data) {
        var new_reply = $.extend(new PostReply(), data);
        self.replies.push(new_reply);
      },
      complete: function() {
        $(formElement).find('input[type=text]').val('');
      }
    });    
  };
};

Post.load = function(load_array, _models) {
  this.load_data('/account/posts.json', load_array, _models);
};

Post.load_self = function(load_array, _models) {
  this.load_data('/account/posts/self.json', load_array, _models);
};

Post.load_data = function(path, array, _models) {
  $.getJSON(path, function(data) {
    $(data).each(function(i, item) {
      var post = $.extend(new Post(_models), item);
      post.init();
      array.push(post);
    });
  });
};

