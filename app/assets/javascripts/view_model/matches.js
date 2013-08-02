var ViewModelMatches = function(view_model_leads) {
  var self = this;
  self.view_model_leads = view_model_leads;
  self.current_user_id = 0;
  self.own_lead = ko.observable(null);
  self.leads = ko.observableArray([]);
  self.view_model_conversation = new ViewModelConversation();

  self.view_conversation = function(data) {
    self.view_model_conversation.init(self.own_lead(), data);
    self.view_model_leads.on_page('view_conversation');
  };

  self.refresh_with_lead = function(lead) {
    self.own_lead(lead);
    Lead.matches(lead, self.leads);
  };

  self.set_curr_user_id = function(curr_id) {
    self.current_user_id = curr_id;
    self.view_model_conversation.current_user_id = curr_id;
  };
}
