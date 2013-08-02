var ViewModelProfiles = function(_models) {
  var self = this;

  self.view_model_posts = new ViewModelPosts(_models);

  self.contacts = _models.contacts;
  self.profile = ko.observable(null);
  self.view_mode = ko.observable(false);
  self.chop_mode = ko.observable(false);
  self.photo_model = ko.observable(false);
  self.pre_prof_avatar_url = ko.observable('');
  self.pre_prof_avatar_url_trigger = ko.observable('');

  self.prof_avatar_url = ko.observable('');

  // self.pre_prof_avatar_url.subscribe(function(newValue) {
  //   // alert("The person's new name is " + newValue);
  // });

  self.enter_edit_view_mode = function() {
    self.edit_model();
    // self.view_mode(false);    
  };

  self.chop_profile_avatar = function(form) {
    var data = $(form).serialize();
    $.ajax({
        url: '/account/profile/avatar',
        type: 'PUT',
        data: data,
        success: function(data) {
          self.init();
        }
    });
  }

  self.reload_profile = function() {
    Profile.current_profile(self.profile, function() {
      if(self.profile() != null) {
        self.prof_avatar_url(self.profile().prof_avatar_url());
        self.pre_prof_avatar_url(self.profile().pre_prof_avatar_url());
        self.pre_prof_avatar_url_trigger(self.profile().pre_prof_avatar_url());
      }
    });
  };

  self.init = function() {
    self.load();
    self.view_mode(true);
    self.chop_mode(false);

    $('.avatar_upload_div .btn').removeAttr("disabled");
    $('.avatar_upload_div .bar').css('width', 0);
    
  };

  self.to_photo_model = function() {
    self.load();
    self.view_mode(false);
    self.chop_mode(false);
    self.photo_model(true);
  };

  self.edit_model = function() {
    self.load();
    self.view_mode(false);
    self.chop_mode(false);
    self.photo_model(false);
  };

  self.chop = function() {
    self.load();
    self.view_mode(false);
    self.chop_mode(true);
    self.photo_model(true);
  };

  self.load = function() {
    self.reload_profile();
  };

  self.update = function(formElement) {
    var data = $(formElement).serialize();

    $.ajax({
        url: '/account/profile',
        type: 'PUT',
        data: data,
        success: function(data) {
          self.init(); 
        }
    });
  }
}

var ViewModelProfileStats = function(_models) {
  var self = this;

  self.init = function() {

    
  };
  
}
