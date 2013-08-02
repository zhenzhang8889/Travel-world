var ViewModelPosts = function(_models) {
  var self = this;

  self.models = _models;
  self.posts = self.models.posts;
  Post.load_self(self.posts, _models);
  self.users = _models.users;
  self.contacts = _models.contacts;

  self.post = function(formElement) {
    $(formElement).find('input[type=submit]').attr("disabled", "disabled");

    $(formElement).ajaxSubmit({
      success: function(data) {
        var new_post = $.extend(new Post(self.models), data);
        new_post.init();
        self.posts.unshift(new_post);
      },
      complete: function() {
        console.log('asdf');
        $(formElement).find('input[type=submit]').removeAttr("disabled");
        $(formElement).find('textarea, input.file_input').val('');
        $(formElement).find('input.file_input').change();
      }
    });

  };
}
