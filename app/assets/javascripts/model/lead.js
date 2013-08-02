var Lead = function(item) {
  var self = this;

  self.is_live_o = ko.observable(item.is_live);
  self.ready_to_rm = ko.observable(false);
  self.top_level_match = ko.observable(0);
  self.top_level_match_label = ko.observable('');
  self.unread_for_particular_lead = ko.observable(0);
  self.unread_for_particular_lead_label = ko.observable('');

  self.refresh_top_level_match = function(curr_user_id) {
    if(self.user_id == curr_user_id) {
      $.getJSON("/account/lead_generations/" + self.id + "/top_level_match", function(data) {
        self.top_level_match(data.count);
        self.top_level_match_label(data.match_label);
      });      
    }
    return self;
  };

  self.unread_replies_for_particular_lead = function(lead) {
    $.getJSON("/account/lead_generations/" + lead.id + "/unread_replies?match_id=" + self.id, function(data) {
      self.unread_for_particular_lead(data.count);
      self.unread_for_particular_lead_label(data.label);
    });
    return self;
  };
};

Lead.new = function(item, curr_user_id) {
  return $.extend(new Lead(item), item).refresh_top_level_match(curr_user_id);
}

Lead.all = function(load_array, curr_user_id) {
  $.getJSON("/account/lead_generations", function(data) {
    $(data).each(function(i, item) {
      load_array.push(Lead.new(item, curr_user_id));
    });
  });
};

Lead.matches = function(lead, load_array) {
  load_array.removeAll();
  $.getJSON("/account/lead_generations/" + lead.id + "/matched", function(data) {
    $(data).each(function(i, item) {
      load_array.push(Lead.new(item, -1).unread_replies_for_particular_lead(lead));
    });
  });
};

Lead.prototype = {
  id : 0,
  user_name : "",
  user_id : "",
  matches : 0,
  keywords : [],
  created_at : "",
  unread_replies_for_particular_lead : 0,
  details : "no details",
  unread_replies : 0,
  proftag : false,

  show_match_page : function(lead) {
    alert('show_match_page not implemented');
  },

  area_text : function() {
    var rs = this.area.name;
    if(this.sub_area) {
      rs = rs + ' ' + this.sub_area.name;
    }

    return rs + ' ' + this.area_desc
  },

  opt_type : function() {
    if (this.lg_type == 'providing') {
      return "Sell / Offer";
    } else {
      return "Buy / Find";
    }
  },

  match_acc_url : function() {
    return "/lead_generations/" + this.id + "/matched";
  },
  say_hello : function() {
    return "";
  },

  go_live : function() {
    var self = this;
    self.is_live_o(true);
    $.ajax({
        url: '/account/lead_generations/' + self.id + '/live',
        // data: 'post_id=' + post_id,
        type: 'PUT',
        success: function(data) { },
        error: function(data) {
          self.is_live_o(false);
        }
    });
  },

  go_pause : function() {
    var self = this;
    self.is_live_o(false);
    $.ajax({
        url: '/account/lead_generations/' + self.id + '/pause',
        // data: 'post_id=' + post_id,
        type: 'PUT',
        success: function(data) { },
        error: function() {
          self.is_live_o(true);
        }
    });
  },

  delete_self : function() {
    var self = this;

    self.ready_to_rm(true);
    $.ajax({
        url: '/account/lead_generations/' + self.id,
        // data: 'post_id=' + post_id,
        type: 'DELETE',
        success: function(data) { },
        error: function() {
          self.ready_to_rm(false);
        }
    });
  }
};
