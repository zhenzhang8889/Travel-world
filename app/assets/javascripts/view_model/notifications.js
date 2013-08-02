var ViewModelNotification = function(_model) {
  var self = this;
  self.post_refer_tos = _model.post_refer_tos;
  self.member_refer_tos = _model.member_refer_tos;

  Referto.load_posts(self.post_refer_tos, _model);
  Referto.load_members(self.member_refer_tos, _model);
};