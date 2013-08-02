var Profile = function() {
  var self = this;

  self.area = null;
  self.prof_avatar = null;
  self.pre_prof_avatar = null;
  self.service = {name: ''};
  self.activities = [];
  self.special_act_list = [];
  self.address = {
    number: '',
    street: '',
    city: '',
    region: '',
    country: '',
    zip: '',
    phone: ''
  };

  self.prof_avatar_url = function() {
    if(self.prof_avatar != null) {
      return self.prof_avatar.medium_url;
    }
    return null;
  };

  self.pre_prof_avatar_url = function() {
    // console.log(self.pre_prof_avatar);
    if(self.pre_prof_avatar != null) {
      return self.pre_prof_avatar.medium_url
    }
    return null;
  };


  self.activity_list = function() {
    var rs = [];
    $(self.activities).each(function(idx, ele) {
      rs.push(ele.name);
    });

    rs = $.merge(self.special_act_list, rs);
    return rs;
  };

  self.activity_text = function() {
    var rs = [];
    $(self.activities).each(function(idx, ele) {
      rs.push(ele.name);
    });

    rs = $.merge(self.special_act_list, rs);

    return rs.join(', ')
  };

  self.full_address = function() {
    return self.address.number + ' ' + self.address.street + ' ' + self.address.city + ' ' + self.address.region + ' ' + self.address.country + ' ' + self.address.zip;
  };

  self.location = function() {
    if(self.area) {
      return self.area.name + self.region;
    } else {
      return self.region;
    }
  };
}

Profile.current_profile = function(profile, call_back) {
  $.getJSON("/account/profile", function(data) {
    profile($.extend(new Profile(), data));
    if(call_back) {
      call_back();
    }
  });
}
