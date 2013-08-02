var ViewModelNetwork = function(_model) {
  var self = this;

  self.contacts = _model.contacts;
  self.areas = ko.observableArray([]);
  self.services = ko.observableArray([]);

  self.filter_areas = ko.observableArray([]);
  self.filter_services = ko.observableArray([]);

  self.show_by_area_name = function(_area_name) {
    return self.show_by_names(_area_name, self.filter_areas);
  };

  self.show_by_service_name = function(_service_name) {
    return self.show_by_names(_service_name, self.filter_services);
  };

  self.show_by_names = function(_name, _visible_list) {
    if(_visible_list().length == 0) {
      return true;
    } else {
      return $.inArray(_name, _visible_list()) >= 0  
    }
  }

  self.after_loading = function() {
    $(self.contacts()).each(function(idx, ele) {
      if(ele.profile && ele.profile.area && $.inArray(ele.profile.area.name, self.areas()) == -1) {
        if(ele.profile.area.name != '' && ele.profile.area.name != null) {
          self.areas.push(ele.profile.area.name);  
        }
      }
    });

    $(self.contacts()).each(function(idx, ele) {
      if(ele.profile && ele.profile.service && $.inArray(ele.profile.service.name, self.services()) == -1) {
        if(ele.profile.service.name != '' && ele.profile.service.name != null) {
          self.services.push(ele.profile.service.name);
        }
      }
    });
  };

  Member.load_contacts(self.contacts, _model, self.after_loading);
};
