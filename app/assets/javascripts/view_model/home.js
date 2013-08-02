var ViewModelHome = function(_models) {
	var self = this;

  self.models = _models;
	self.posts = self.models.feeds;
  self.contacts = _models.contacts;

  Post.load(self.posts, _models);
};
