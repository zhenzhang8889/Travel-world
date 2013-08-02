var ViewModelConversation = function() {
  var self = this;

  self.own_lead = ko.observable(null);
  self.match_lead = ko.observable(null);
  self.replies = ko.observableArray([]);

  self.init = function(own_lead, match_l) {
    self.own_lead(own_lead);
    self.match_lead(match_l);
    self.refresh_replies();
  };

  self.refresh_replies = function() {
    if(self.own_lead() != null && self.match_lead() != null) {
      LeadReply.fetch(self.own_lead().id, self.match_lead().id, self.replies);
    }
  }

  self.post_reply = function(formElement) {
    var data = $(formElement).serialize();
    $.post("/lead_replies", data, function(returnedData) {
      var new_reply = $.extend(new LeadReply(), returnedData);
      self.replies.push(new_reply);
    });

    $(formElement).find('textarea').val('');
  };
}
