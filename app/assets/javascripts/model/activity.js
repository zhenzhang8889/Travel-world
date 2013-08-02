var Activity = function() {
	
};

Activity.load = function(load_array) {
  $.getJSON("/account/friend_acts.json", function(data) {
    $(data).each(function(i, item) {
      load_array.push($.extend(new Activity(), item));
    });
  });
};
