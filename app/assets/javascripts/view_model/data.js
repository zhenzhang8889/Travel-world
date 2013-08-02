var ViewModelData = function() {
  var self = this;

  // posts from contacts
  self.feeds = ko.observableArray([]);
  self.posts = ko.observableArray([]);
  self.users = ko.observableArray([]);
  self.contacts = ko.observableArray([]);
  self.post_refer_tos = ko.observableArray([]);
  self.member_refer_tos = ko.observableArray([]);
}
