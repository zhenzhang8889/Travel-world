var Member = function(data, _model) {
  var self = this;

  self.model = _model;
  self._data = data;
  self.id = null;
  self.id_obsr = ko.observable(-1);

  self.init = function() {
    self.id_obsr(self.id);
  };

  self.refer_to_contact = function(_type, _post_id) {
    console.log("type=" + _type + "&post_id=" + _post_id);
    $.post("/account/refertos", "type=" + _type + "&post_id=" + _post_id + "&user_id=" + self.id, function(returnedData) {
      alert('Your refer has been sent.');
    });
  }

  self.added = ko.computed(function() {
    var ids = $.map(self.model.contacts(), function(contact) {
      return contact.id;
    });

    return $.inArray(self.id_obsr(), ids) >= 0;
  }, this);

  self.category = {name: ''};
  self.categoryName = '';
  self.profile = {area : {}, service: {}};
  self.full_name = '';
  self.imageUrlSmall = '';

  self.match_name = function(match, category_id) {
    if(!match || match == undefined) {
      match = '';
    }

    var name = self.full_name.toLowerCase();
    if(name == '') {
      return false;
    }
    var match = match.toLowerCase();

    return name.indexOf(match) >= 0 && (self.category_id == category_id || category_id == null || category_id == '')
  };

  self.location_desc = function() {
    if(self.profile != null && self.profile.area != null) {
      return self.profile.area.name + self.profile.region;
    }
    return '';
  };

  self.add_contact = function(callback) {
    var self = this;
    $.post("/contacts", "user_id=" + self.id, function(returnedData) {
      Member.load_contacts(_model.contacts, _model);

      // if(callback) {
      //   callback(self);
      // }
    });
  };

  self.del_contact = function(callback) {
    $.ajax({
      type: "DELETE",
      url: "/contacts/0",
      data: { user_id: self.id }
    }).success(function( msg ) {
      // self.added(false);
      Member.load_contacts(_model.contacts, _model);
      // if(callback) {
      //   callback(self);
      // }
    });
  };

  self.add_to_refer = function(_post) {
    var post_url = "/account/posts/" + _post.id + "/refer_tos";
    // console.log(post_url);
    $.post(post_url, "user_id=" + self.id, function(returnedData) {
      // console.log(returnedData);
      var refer_to = $.extend(new Member(returnedData, self.model), returnedData);
      _post.refer_to_users.push(refer_to);
      // self.added(true);
      // if(callback) {
      //   callback(self);
      // }
    });
  };

  // From original User class
  self.threads = ko.observableArray([]);
  self.location = ko.observable(data.city + " (" + data.country + ")");
  self.location2 = ko.observable(data.city + ", " + data.country);
  self.image = ko.observable(data.imageUrlMedium);
  self.category = ko.observable(data.categoryName);

  self.subName = ko.computed(function() {
    return self.location() + " - " + self.category();
  });
}

Member.search = function(load_array, _model) {
  $.getJSON("/members", function(data) {
    $(data).each(function(i, item) {
      var member = $.extend(new Member(item, _model), item);
      load_array.push(member);
    });
  });
}

Member.load_contacts = function(load_array, _model, callback) {
  $.getJSON("/contacts", function(data) {
    load_array.removeAll();
    $(data).each(function(i, item) {
      var member = $.extend(new Member(item, _model), item);
      load_array.push(member);
    });
    if(callback) {
      callback();  
    }
  });
}

Member.load_all = function(load_array, _model) {
    $.getJSON("/users/all", function(allData){
    // console.log(allData);
    load_array.removeAll();

    $(allData).each(function(idx, item){
      var user = $.extend(new User(item, _model), item);
      user.init();
      load_array.push(user);
    });
    setTimeout(QueryLoader.loadCallback(), 1000);
  });
}

var User = Member;
