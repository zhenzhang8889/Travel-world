var ViewModelLeads = function() {
  var self = this;
  self.view_model_matches = new ViewModelMatches(self);
  self.current_user_id = 0;
  self.leads = ko.observableArray([]);
  self.on_page = ko.observable('view_leads');

  self.view_leads = function() {
    self.on_page('view_leads');
  };

  self.view_new_lead = function() {
    self.on_page('view_new_lead');
  };

  self.view_matches = function(data) {
    self.view_model_matches.refresh_with_lead(data);
    self.back_to_matches();
  };

  self.back_to_matches = function() {
    self.on_page('view_matches');
  };
  self.post_lead = function(formElement) {
    var data = $(formElement).serialize();
    $.post("/account/lead_generations", data, function(returnedData) {
      var lead = Lead.new(returnedData, self.current_user_id);
      self.leads.push(lead);
    });
    self.view_leads();
  };
  self.refresh_current_user_id = function(current_user_id) {
    self.current_user_id = current_user_id;
    self.leads.removeAll();
    Lead.all(self.leads, self.current_user_id);
    self.view_model_matches.set_curr_user_id(current_user_id);
  }
};

ViewModelLeads.prototype = {};
