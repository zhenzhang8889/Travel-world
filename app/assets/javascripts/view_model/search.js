var ViewModelSearch = function(_model) {
  var self = this;
  self.members = _model.users;
  self.model = _model;

  self.search_category_id = ko.observable(null);
  self.search_name = ko.observable('');

  // Member.search(self.members);

  self.set_search_category_id = function(data, event) {
    // console.log($(event.target).val());
    self.search_category_id($(event.target).val());
    return true;
  };

  self.set_search_name = function(data, event) {
    // console.log($(event.target).val());
    self.search_name($(event.target).val());
    return true;
  };

  // self.remove_callback = function(contact) {
  //   self.model.contacts.remove(contact);
  // };

  // self.add_callback = function(contact) {
  //   self.model.contacts.push(contact);
  // };

}
