var LeadReply = function() {
}

LeadReply.fetch = function(lead_id, match_id, load_array) {
  load_array.removeAll();

  $.getJSON("/account/lead_generations/" + lead_id + "/fetch_replies?match_id=" + match_id, function(data) {
    $(data).each(function(i, item) {
      load_array.push($.extend(new LeadReply(), item));
    });    
  });
};
