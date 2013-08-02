


ko.observableArray.fn.filterByProperty = function(propName, matchValue) {
    return ko.computed(function() {
        var allItems = this(), matchingItems = [];
        for (var i = 0; i < allItems.length; i++) {
            var current = allItems[i];
            if (ko.utils.unwrapObservable(current[propName]) === matchValue)
                matchingItems.push(current);
        }
        return matchingItems;
    }, this);
}

ko.observableArray.fn.getByProperty = function(propName, matchValue) {
  var allItems = this(), matchingItem;
  for (var i = 0; i < allItems.length; i++) {
      var current = allItems[i];
      if (ko.utils.unwrapObservable(current[propName]) === matchValue){
          matchingItem = current;
          break;
      }
  }
  return matchingItem;
}

function UserAck(id){
  var self = this;
  self.id = ko.observable(id);
  self.confirmed = ko.observable(false);
  
  self.confirmUser = function(){
    self.confirmed(true);
  }
}

function Message(data){
  var self = this;
  self.id = ko.observable(data.id);
  self.content = ko.observable(data.content);
  self.created_at = ko.observable(data.created_at);
  self.updated_at = ko.observable(data.updated_at);
  self.message_thread_id = ko.observable(data.message_thread_id);
  self.user_id = data.user.id;
  self.email = data.user.email;
  self.confirmedUsers = ko.observableArray([]);
  self.ack = ko.observable(data.ack);
  self.ackUsers = ko.observableArray([]);
  self.person = ko.observable();
  self.thread = ko.observable();
  self.attachUrl = ko.observable(data.getAttach);
  
  if (data.status != null){
    self.confirmedUsers($.map(data.status.split(","), function(id){ 
      user = self.confirmedUsers.getByProperty("id", parseInt(id));
      if (user == undefined){
        new_ack_user = new UserAck(parseInt(id));
        new_ack_user.confirmUser();
        return new_ack_user;
      }
      else
        user.confirmUser();
    }));
  }
  
  if (data.acked != null){
    self.ackUsers($.map(data.acked.split(","), function(id){ 
      user = self.ackUsers.getByProperty("id", parseInt(id));
      if (user == undefined){
        new_ack_user = new UserAck(parseInt(id));
        new_ack_user.confirmUser();
        return new_ack_user;
      }
      else
        user.confirmUser();
    }));
  }
  
  self.fullRow = ko.computed(function() {
    return self.content();
  }, self);
  
  self.getPerson = function(){
    // console.log(self.person());

    if ((self.person() == undefined) || (self.person().id != self.user_id)){
      new_person = application.users.getByProperty("id", self.user_id)
      if (new_person == undefined)
        new_person = application.currentPerson();
      self.person(new_person);
    }
    return self.person();
  };
  
  self.allConfirmedBack = function(){
    thread = application.threads.getByProperty("id", self.message_thread_id());
    if (thread != undefined){
      threads_length = thread.users().length; 
      return (self.confirmedUsers.filterByProperty("confirmed",true)().length == threads_length);
    }
    else
      return false;
  }
  
  self.receiveAllsendAcknowledgement = function(){
    // If we use groups of users we need to use the length of the user threads.
    return (self.ackUsers.filterByProperty("confirmed",true)().length > 0);
  }

  self.userSentAcknowledgement = function(){
    ack = self.ackUsers.getByProperty("id", application.currentUser);
    if (ack == undefined)
      return false;
    return ack.confirmed();
  }

  self.getStatus = ko.computed(function(){
    if (self.ack() && application.currentUser != self.user_id)
      if (!self.userSentAcknowledgement())
        return " Acknowledgement Required";
      else
        return " Acknowledgement Sent";
    if (self.ack() && application.currentUser == self.user_id)
      if (self.receiveAllsendAcknowledgement())
        return " Acknowledgement Received";
      else
        return " Acknowledgement Pending";
    if (!self.ack()){
      if (application.currentUser != self.user_id)
        return " Received";
      if ((!self.allConfirmedBack()) && (application.currentUser == self.user_id))
        return " Pending";
      if ((self.allConfirmedBack()) && (application.currentUser == self.user_id))
        return " Delivered";
    }
  })

  self.getStatusMsg = function(){
    if (self.ack() && application.currentUser != self.user_id)
      if (!self.userSentAcknowledgement())
        return " Acknowledgement Required";
      else
        return " Acknowledgement Sent";
    if (self.ack() && application.currentUser == self.user_id)
      if (self.receiveAllsendAcknowledgement())
        return " Acknowledgement Received";
      else
        return " Acknowledgement Pending";
    if (!self.ack()){
      if (application.currentUser != self.user_id)
        return " Received";
      if ((!self.allConfirmedBack()) && (application.currentUser == self.user_id))
        return " Pending";
      if ((self.allConfirmedBack()) && (application.currentUser == self.user_id))
        return " Delivered";
    }
  }
  
  self.getDateTime = ko.computed(function(){
    date = new Date(self.updated_at());
    return monthNames[date.getMonth()] + " " + date.getDate() + " - " + date.getHours() + ":" + date.getMinutes() + " - "
  })
  
  self.getDateTimeRecent = ko.computed(function(){
    date = new Date(self.updated_at());
    return monthNames[date.getMonth()] + " " + date.getDate() + " - " + date.getHours() + ":" + date.getMinutes();
  })
  
  self.getMessageClass = ko.computed(function(){
    return_class ="dialog-single";
    if (self.ack() && application.currentUser != self.user_id)
      if (!self.userSentAcknowledgement())
        return "dialog-required " + return_class;
      else
        return "dialog-received " + return_class;
    if (self.ack() && application.currentUser == self.user_id)
      if (self.receiveAllsendAcknowledgement())
        return "dialog-received " + return_class;
      else
        return "dialog-required " + return_class;
    if (!self.ack()){
      return return_class;
    }
  })
  
  self.getMessageArrowClass = ko.computed(function(){
    return_class ="dialog-arrow";
    if (self.ack() && application.currentUser != self.user_id)
      if (!self.userSentAcknowledgement())
        return "dialog-required-row " + return_class;
      else
        return "dialog-received-row " + return_class;
    if (self.ack() && application.currentUser == self.user_id)
      if (self.receiveAllsendAcknowledgement())
        return "dialog-received-row " + return_class;
      else
        return "dialog-required-row " + return_class;
    if (!self.ack()){
      return return_class;
    }
  })
  
  self.confirmUser = function(user_id){
    user = self.confirmedUsers.getByProperty("id", user_id);
    if (user == undefined){
      user = new UserAck(user_id);
      self.confirmedUsers.push(user);
    }
    user.confirmUser();
  }
  
  self.receiveAcknowledgement = function(user_id){
    user = self.ackUsers.getByProperty("id", user_id);
    if (user == undefined){
      user = new UserAck(user_id);
      self.ackUsers.push(user);
    }
    user.confirmUser();
  }

  self.allConfirmed = ko.computed(function(){
    thread = application.threads.getByProperty("id", self.message_thread_id());
    if (thread != undefined){
      threads_length = thread.users().length; 
      return (self.confirmedUsers.filterByProperty("confirmed",true)().length == threads_length);
    }
    else
      return false;
  });
  
  self.confirmedMessage = ko.computed(function(){
    ack = self.ackUsers.getByProperty("id", application.currentUser);
    if (ack == undefined)
      return false;
    return ack.confirmed();
  });
  
  self.sendAcknowledgement = function(){
    $.ajax({
      url: '/message_thread/' + self.message_thread_id() + '/acknowledgement',
      type: 'POST',
      data: 'message_id=' + self.id(),
      success: function(data) {
        ack = self.ackUsers.getByProperty("id", application.currentUser);
        ack.confirmed(true);
      }
    });
  }
  
  self.getThread = function(){
    if (self.thread() == undefined)
      self.thread(application.threads.getByProperty("id", self.message_thread_id()));
    return self.thread();
  }
  
  self.getSearchedThread = function(){
    thread = self.getThread();
    application.getSearchedThread(thread);
  }
}

function Thread(data){
  //attrs
  var self = this;
  self.id = ko.observable(data.id);
  self.subject = ko.observable(data.subject);
  self.updated_at = ko.observable(data.updated_at);
  self.messages = ko.observableArray([]);
  self.messages($.map(data.messages, function(item) { if (item.content != null) return new Message(item) }));
  self.users = ko.observableArray([]);
  self.users($.map(data.users, function(item) {
    user = application.users.getByProperty("id", item.id);
    if (user != undefined){
      user.threads.push(self);
      return user;
    }
  }));
  self.printUrl = "/message_thread/" + data.id;
  
  //helpers
  self.editing = ko.observable(false);
  self.usingQM = ko.observable(false);
  self.newMessage = ko.observable("");
  self.lastId = ko.observable("");
  self.requireAck = ko.observable(false);
  self.attachId = ko.observable(0);
  
  self.searching = ko.observable(false);
  self.filterText = ko.observable("");
  self.filteredMessages = ko.computed(function() {
    if (self.filterText().length > 0) {
        var messagesArray = self.messages();            
        return ko.utils.arrayFilter(messagesArray, function(m) {
          if (m.content().toLowerCase().search(self.filterText().toLowerCase()) != -1)
            return true;
          else
            return false;
        });
    }
    else
      return self.messages();
  });
  
  //methods
  self.edit = function() { 
    self.editing(true);
  };
  
  self.useQM = function(){
    self.searching(false);
    self.usingQM(!self.usingQM());
  }
  
  self.setQM = function(qm){
    self.newMessage(qm.body());
    self.usingQM(false);
  }
  
  self.setSearching = function(){
    self.usingQM(false);
    self.searching(!self.searching());
  }
  
  self.closeAction = function(){
    self.usingQM(false);
    self.searching(false);
  }
  
  self.disableSearch = function(){
    self.searching(false);
  }

  self.saveSubject = function(){
    if (self.editing()){
      self.editing(false);
      $.ajax({
        url: '/threads/change_subject/',
        type: 'PUT',
        data: "id=" + self.id() + "&subject=" + self.subject(),
      });
    }
  };
  
  self.addMessage = function(){
    if (self.newMessage().length > 0){
      $.ajax({
        url: '/messages',
        type: 'POST',
        data: 'content=' + encodeURIComponent(self.newMessage()) + '&message_thread_id=' + self.id() + '&ack=' + self.requireAck() 
              + '&attach_id=' + self.attachId(),
        success: function(data) {
          if (self.requireAck())
            changeCheckClass('ack-check' + self.id());
          if (self.attachId() != 0){
            self.attachId(0);
            var iframe = document.getElementById("iframe" + self.id());
            iframe.src = '/upload/' + self.id()
          }
            
          self.requireAck(false);
          self.newMessage("");
        }
      });
    }
  }
    
  self.sendACK = function(){
    // messages = self.messages.filterByProperty("ack", true);
    ko.utils.arrayForEach(self.messages(), function(m) {
      if (m.user_id != application.currentUser){
        u = m.confirmedUsers.getByProperty("id", application.currentUser);
        if (u == undefined){
          application.sendACK(m.message_thread_id(), m.id(), application.currentUser);
          ua = new UserAck(application.currentUser);
          ua.confirmUser();
          m.confirmedUsers.push(ua);
        }
      }
      if (m.ack()){
        ko.utils.arrayForEach(self.users(), function(u){
          user = m.ackUsers.getByProperty("id", u.id());
          if (user == undefined){
            m.ackUsers.push(new UserAck(u.id()))
          }
        })
        if (m.user_id != application.currentUser)
          m.ackUsers.push(new UserAck(application.currentUser));
      }
    });

    
  }
  
  self.getDateTime = ko.computed(function(){
    date = new Date(self.updated_at());
    return monthNames[date.getMonth()] + " " + date.getDate() + " - " + date.getHours() + ":" + date.getMinutes();
  })
  
  self.contextMenuThreadClick = function(m,e){
    $('.menu').css({
      top: (~~(e.pageY / 2))+'px',
      left: (~~(e.pageX / 2))+'px'
    })
    $('#menu' + m.id()).show();
  };

  self.getLastMessage = ko.computed(function(){
    last = "";
    count = self.messages().length;
    if (count > 0)
      last = self.messages()[count-1].content;
    return last;
  })
  
  self.getRecentThread = function(){
    current_user = self.users()[0];
    page = application.pages.getByProperty("currentReceiver",current_user.id());
    if (page == undefined)
    {
      np = new Page("threads");
      np.threads(current_user.threads());
      np.currentReceiver(current_user.id());
      np.currentGroup(application.groups()[0]);
      np.searchingUsers(false);
      application.pages.unshift(np);
    }
    else{
      page.threads(current_user.threads());
      page.currentReceiver(current_user.id());
      page.currentGroup(application.groups()[0]);
      page.searchingUsers(false);
      page.typePage("threads");
    }
  }
  
  self.getUser = function(){    
    if (self.users().length > 0){
      if (self.users()[0].id() != application.currentUser)
        return self.users()[0];
      else
        return self.users()[1];
    }  
  }
}

function quickMessage(data){
  var self = this;
  self.id = ko.observable(data.id);
  self.body = ko.observable(data.body);
  self.editing = ko.observable(false);
  
  self.editQM = function() { 
    self.editing(true);
  };
  
  self.updateQM = function(){
    if (self.editing()){
      self.editing(false);
      $.ajax({
        url: '/quick_message/' + self.id(),
        type: 'PUT',
        data: "body=" + self.body()
      });
    }
  };
  
  self.deleteQM = function(m,e){
    $.ajax({
      url: '/quick_message/' + self.id(),
      type: 'delete',
      data: "",
      success: function(data) {
        application.qm.remove(m);
      }
    });
  }
}

function GroupUser(data){
  var self = this;
  self.id = ko.observable(data.id);
  self.name = ko.observable(data.firstName + " " + data.lastName);
  self.email = ko.observable(data.email);
  self.location = ko.observable(data.city + " (" + data.country + ")");
  self.image = ko.observable(data.imageUrlSmall);
  self.category = ko.observable(data.categoryName);
  self.traveler = ko.observable(data.traveler);
  self.description = ko.observable(data.description);
  
  self.subName = ko.computed(function() {
    if (self.traveler() == true)
      return self.location() + " - " + self.description();
    else
      return self.location() + " - " + self.category();
  })
  
  self.addPerson = function(){
    page = application.pages.getByProperty("typePage", "group");
    page.currentGroup().addPerson(self);
    page.searchingUsers(false);
  }

  self.removePerson = function(){
    page = application.pages.getByProperty("typePage", "group");
    page.currentGroup().removePerson(self.id());
  }
}

function Group(data){
  var self = this;
  self.id = ko.observable(data.id);
  self.name = ko.observable(data.name);
  self.traveler = ko.observable(data.traveler);
  self.groupUsers = ko.observableArray([]);
  
  
  self.groupUsers($.map(data.users, function(item) { 
    if (item.id != application.currentUser){
      user = application.users.getByProperty("id", item.id);
      if (user == undefined) {
        // console.log(self.datas);
        // console.log(application.datas);
        var member = $.extend(new Member(item, application.datas), item);
        application.users.push(member);        
      }

      return new GroupUser(item);
    }
  }));

  self.editing = ko.observable(false);

  self.edit = function() { 
    self.editing(true);
  };

  self.saveName = function(){
    if (self.editing()){
      self.editing(false);
      $.ajax({
        url: '/groups/' + self.id(),
        type: 'PUT',
        data: "name=" + self.name(),
        success: function(data) {
        }
      });
    }
  };
  
  self.setSelected = function(){
    application.selectedGroup(self.id());
    return false;
  }
  
  self.setGroup = function(){
    application.viewGroup(self);
  }
  
  self.visibleGroup = ko.computed(function() {
    return application.selectedGroup() == self.id();
  });
  
  self.addPerson = function(groupUser){
    $.ajax({
      url: '/groups/' + self.id() + '/addUser',
      type: 'POST',
      data: 'user_id=' + groupUser.id(),
      success: function(data) {
        self.groupUsers.push(groupUser);
      }
    });

  }
  
  self.removePerson = function(id){
    if (confirm("Are you sure you want to remove this person?")){
      $.ajax({
        url: '/groups/' + self.id() + '/removeUser',
        type: 'DELETE',
        data: 'user_id=' + id,
        success: function(data) {
          self.groupUsers.remove(self.groupUsers.getByProperty("id", id));
        }
      });
    }
  }
  
  self.destroyGroup = function(){
    if (confirm("Are you sure you want to delete this group?")){
      $.ajax({
        url: '/groups/' + self.id(),
        type: 'DELETE',
        success: function(data) {
          application.groups.remove(self);
        }
      });
      return true;
    }
    return false;
  }

  self.personsFilter = ko.computed(function(){
    if (application.searchName().length > 0) {
        var userArray = self.groupUsers();
        return ko.utils.arrayFilter(userArray, function(u) {
          if (u.name().toLowerCase().search(application.searchName().toLowerCase()) != -1)
            return true;
          return false;
        });
    }
    else{
      return self.groupUsers();
    }
  });
}

function Page(type){
  var self = this;
  self.typePage = ko.observable(type);
  self.threads = ko.observableArray([]);
  self.currentThread = ko.observable();
  self.currentReceiver = ko.observable();
  self.currentPagePerson = ko.observable();
  self.currentGroup = ko.observable();
  self.searchingUsers = ko.observable(false);
  self.usersToAdd = ko.observableArray([]);
  self.searchingUsersToAdd = ko.observable(false);
  self.show_profile = ko.observable();

  self.closePage = function() {
    application.pages.remove(self);
  }
  
  self.toggle_show_profile = function() {
    if(self.show_profile() == 1) {
      self.show_profile(0);
    } else {
      self.show_profile(1);
    }
  }

  self.backThreads = function(){
    current_user = application.users.getByProperty("id", self.currentReceiver());
    self.threads(current_user.threads());
    self.typePage("threads");
  }
  
  self.newThread = function(){
    $.ajax({
      url: '/message_thread/',
      type: 'POST',
      data: 'receiver_id=' + self.currentReceiver(),
      success: function(data) {
        thread = application.threads.getByProperty("id", data.id);
        self.currentThread(thread);
        self.typePage("message");
      }
    });
  }
  
  self.searchPerson = function(){
    if (!self.searchingUsers()){
      self.searchingUsersToAdd(true);
      self.searchingUsers(true);
      $.ajax({
        url: '/groups/' + self.currentGroup().id() + '/toAdd',
        type: 'GET',
        success: function(data) {
          self.usersToAdd($.map(data, function(item) {
            groupUser = new GroupUser(item);
            return groupUser;
          }));
          self.searchingUsersToAdd(false);
        }
      });
    } else {
      self.searchingUsers(false);
    }
  }
  
  self.archiveThread = function(m,e){
    $.get("/threads/archive/" + m.id(), function(data){
      self.threads.remove(m);
      application.threads.remove(m);
    });
  };
  
  self.deleteThread = function(m,e){
    if (confirm("Are you sure you want to delete this thread?")){
      $.get("/threads/delete/" + m.id(), function(data){
        self.threads.remove(m);
        application.threads.remove(m);
      });
    }
  };
  
  self.deleteGroup = function(){
    if (self.currentGroup().destroyGroup())
      self.closePage();
  }
  
  self.getConversation = function(thread){
    thread.sendACK();
    thread.usingQM(false);
    thread.searching(false);
    self.currentThread(thread);
    self.typePage("message");
    scrollDown(thread.id());
  };

  self.currentPerson = function(){
    if ((self.currentPagePerson() == undefined) || (self.currentPagePerson().id != self.currentReceiver())){
      person = application.users.getByProperty("id", self.currentReceiver());
      if (person == undefined)
        person = application.currentPerson();
      self.currentPagePerson(person);
    }
    return self.currentPagePerson();
  }
}

function app(){
  var self = this;

/* Score Area */
  this.hasCompleted = ko.observable(0);
  this.score = ko.observable(0);
  this.numberTask = ko.observable(0);
  this.clicked1 = ko.observable(0);
  this.clicked2 = ko.observable(0);
  this.clicked3 = ko.observable(0);
  this.clicked4 = ko.observable(0);
  this.clicked5 = ko.observable(0);

  this.completeTask1 = function() {
        this.score(this.score() + 30);
        this.numberTask(1);
        this.clicked1(this.clicked1() + 1);
    };
    this.completeTask2 = function() {
        this.score(this.score() + 10);
        this.clicked2(this.clicked2() + 1);
        this.numberTask(2);
    };
    this.completeTask3 = function() {
        this.score(this.score() + 20);
        this.clicked3(this.clicked3() + 1);
        this.numberTask(3);
    };
    this.completeTask4 = function() {
        this.score(this.score() + 30);
        this.clicked4(this.clicked4() + 1);
        this.numberTask(4);
    };
    this.completeTask5 = function() {
        this.score(this.score() + 10);
        this.clicked5(this.clicked5() + 1);
        this.numberTask(5);
    };

    this.resetClicks = function() {
        this.score(0);
    };

    this.hasClicked1 = ko.computed(function() {
        return this.clicked1() >= 1;
    }, this);
    this.hasClicked2 = ko.computed(function() {
        return this.clicked2() >= 1;
    }, this);
    this.hasClicked3 = ko.computed(function() {
        return this.clicked3() >= 1;
    }, this);
    this.hasClicked4 = ko.computed(function() {
        return this.clicked4() >= 1;
    }, this);
    this.hasClicked5 = ko.computed(function() {
        return this.clicked5() >= 1;
    }, this);

    this.hasCompleted= ko.computed(function() {
        return this.clicked1() >= 1 || this.clicked2() >= 1 || this.clicked3() >= 1|| this.clicked4() >= 1|| this.clicked5() >= 1 ;
    }, this);

  self.datas = new ViewModelData();
  self.view_model_home = new ViewModelHome(self.datas);
  self.view_model_leads = new ViewModelLeads();
  self.view_model_search = new ViewModelSearch(self.datas);
  self.view_model_profiles = new ViewModelProfiles(self.datas);
  self.view_model_profile_stats = new ViewModelProfileStats();
  self.view_model_network = new ViewModelNetwork(self.datas);
  self.view_model_notification = new ViewModelNotification(self.datas);

  self.threads = ko.observableArray([]);
  // self.users = ko.observableArray([]);
  self.users = self.datas.users;

  self.groups = ko.observableArray([]);
  self.selected_group = ko.observable();
  self.qm = ko.observableArray([]);
  self.qmToAdd = ko.observable("");
  self.pages = ko.observableArray([]);
  self.currentUser = 0;
  self.currentPerson = ko.observable("");
  self.selectedGroup = ko.observable(1);
  self.selectedRecent = ko.observable("today");

  self.main_menu_type = ko.observable("home");

  self.sideBarType = ko.observable("contacts");
  self.fullSearching = ko.observable(false);
  self.messageSearch = ko.observable("");
  self.startDate = ko.observable("2000-03-20");
  self.searchType = ko.observable("All");
  self.searchPlace = ko.observable("Messages");
  self.selectTypeSearch = ko.observable(false);
  self.side_bar_need_full_screen = ko.observable(false);
  self.availablePlaces = ko.observableArray(['Messages','People', 'Description'])
  self.availableStatus = ko.observableArray(['All','Delivered', 'Received', 'Pending', 'Acknowledgement Required', 'Acknowledgement Sent', 'Acknowledgement Received', 'Acknowledgement Pending'])
  var date = new Date();
  self.endDate = ko.observable(date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate());
  self.selectType = ko.observable(false);
  
  self.searchingPeople = ko.observable(false);
  self.searchName = ko.observable("");
  self.traveler = ko.observable(false);

  $.getJSON("/groups/", function(allData) {
    var mappedGroups = $.map(allData, function(item) { return new Group(item) });
    self.groups(mappedGroups);
    setTimeout(function(){QueryLoader.loadCallback();}, 1000);
  });

  $.getJSON("/quick_message", function(allData) {
    var mappedQM = $.map(allData, function(item) { return new quickMessage(item) });
    self.qm(mappedQM);
    setTimeout(QueryLoader.loadCallback(), 1000);
  });

  $.getJSON("/message_thread", function(allData) {
    var mappedThreads = $.map(allData, function(item) { return new Thread(item) });
    self.threads(mappedThreads);
    setTimeout(QueryLoader.loadCallback(), 1000);
  });
  
  // console.log(self.users);
  Member.load_all(self.users, self.datas);
  // $.getJSON("/users/all", function(allData){
  //   // console.log(allData);

  //   self.users.removeAll();
  //   $(allData).each(function(idx, item){
  //     var user = $.extend(new User(item, self.datas), item);
  //     user.init();
  //     self.users.push(user);
  //   });

  //   // var users = self.users();
  //   // var mappedThreads = $.map(allData, function(item) { 
  //   //   // var user = self.users.getByProperty("id", item.id);

  //   //   // console.log(user);
  //   //   if (!user) {
  //   //     // var user = $.extend(new User(item, self.datas), item);
  //   //     user = $.extend(new Member(item, self.datas), item);
  //   //     // console.log(user);
  //   //     self.users.push(user);
  //   //   }
  //   // });

  //   setTimeout(QueryLoader.loadCallback(), 1000);
  // });

  self.getThread = function(user) {
    console.log(user);

    self.fullSearching(false);
    current_user = self.users.getByProperty("id", user.id());
    page = self.pages.getByProperty("currentReceiver",user.id());
    if (page == undefined)
    {
      np = new Page("threads");
      console.log(current_user);
      np.threads(current_user.threads());
      np.currentReceiver(user.id());
      np.currentGroup(self.groups()[0]);
      np.searchingUsers(false);
      self.pages.unshift(np);
    }
    else{
      page.threads(current_user.threads());
      page.currentReceiver(user.id_obsr());
      page.currentGroup(self.groups()[0]);
      page.searchingUsers(false);
      page.typePage("threads");
    }
  };
  
  self.addMessage = function(message, thread_id){
    thread = self.threads.getByProperty("id", thread_id);
    thread.messages.push(message);
    
    if (message.user_id == self.currentUser){
      ko.utils.arrayForEach(thread.users(), function(user) {
        message.confirmedUsers.push(new UserAck(user.id_obsr()));
      });
    }
    
    if (message.ack()){
      ko.utils.arrayForEach(thread.users(), function(user) {
        u = message.ackUsers.getByProperty("id", user.id_obsr());
        if (u == undefined)
          message.ackUsers.push(new UserAck(user.id_obsr()));
      });
      if (message.user_id != self.currentUser)
        message.ackUsers.push(new UserAck(self.currentUser));
    }
    
    page = self.pages.getByProperty("currentThread", thread);
    if (page == undefined)
    {
      page = self.pages.getByProperty("currentReceiver", message.user_id);
      if (page == undefined)
      {
        np = new Page("message");
        np.currentReceiver(message.user_id);
        np.threads(self.users.getByProperty("id", message.user_id).threads())
        np.currentThread(thread);
        np.currentGroup(application.groups()[0]);
        np.searchingUsers(false);
        self.pages.unshift(np);
      }
      else{
       page.currentReceiver(message.user_id);
       page.threads(self.users.getByProperty("id", message.user_id).threads());
       page.currentThread(thread);
       page.currentGroup(application.groups()[0]);
       page.searchingUsers(false);
       page.typePage("message");
      }
      thread.sendACK();
    }
    else
      page.typePage("message");
  }
    
  self.addThread = function(thread, receiver_id){    
    self.threads.push(thread);
  }
  
  self.setCurrentUser = function(id){
    self.currentUser = id;
    self.view_model_leads.refresh_current_user_id(id);
  }

  self.changeSubject = function(id, subject){
    thread = self.threads.getByProperty("id", id);
    if (thread != undefined)
      thread.subject(subject);
  }
  
  self.removePerson = function(thread_id, user_id){
    thread = self.threads.getByProperty("id", thread_id);
    if (thread != undefined){
      person = self.users.getByProperty("id", user_id);
      thread.users.remove(person);
    }
  }
  
  self.viewGroups = function(){
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    self.sideBarType("groups");
  }

  self.viewGroup = function(group){
    page = self.pages.getByProperty("typePage", "group");

    if (page == undefined){
      np = new Page("group");
      np.currentGroup(group);
      np.searchingUsers(false);
      self.pages.unshift(np);
    }
    else{
      page.searchingUsers(false);
      page.currentGroup(group);
    }
  }
  
  self.createGroup = function(){
    $.ajax({
      url: '/groups/',
      type: 'POST',
      data: 'traveler=' + self.traveler(),
      success: function(data) {
        new_group = self.groups.getByProperty("id", data.id);
        if (new_group == undefined){
          new_group = new Group(data);
          self.groups.push(new_group);
        }
        self.viewGroup(new_group);
      }
    });
  }

  self.view_home = function() {
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    
    self.view_model_profiles.init();
    self.main_menu_type('home');
    self.side_bar_need_full_screen(true);
  }

  self.view_match_leads = function() {
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    self.sideBarType('match_leads');
    self.side_bar_need_full_screen(true);
  };

  self.view_notifications = function() {
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    
    self.view_model_profiles.init();
    self.main_menu_type('notifications');
    self.side_bar_need_full_screen(true);
  };

  self.view_network = function() {
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    
    self.view_model_profiles.init();
    self.main_menu_type('network');
    self.side_bar_need_full_screen(true);
  };

  self.view_profile_stats = function() {
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    
    self.view_model_profile_stats .init();
    self.main_menu_type('stats');
    self.side_bar_need_full_screen(true);
 
  }

  self.view_account_profile = function() {
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    
    self.view_model_profiles.init();
    self.main_menu_type('profile');
    self.side_bar_need_full_screen(true);    
  }

  self.view_members_search = function() {
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    self.view_model_leads.view_leads();
    self.main_menu_type('search');
    self.side_bar_need_full_screen(true);
  }

  self.viewLeads = function() {
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    self.view_model_leads.view_leads();
    self.main_menu_type('leads');
    self.side_bar_need_full_screen(true);
  }

  self.viewNone = function() {
    self.main_menu_type('None');
  }

  self.view_new_lead = function() {
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    self.sideBarType('new_lead');
    self.side_bar_need_full_screen(true);
  }

  self.viewChats = function() {
    self.main_menu_type('chats');
    self.viewContacts();
  }

  self.viewContacts = function(){
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    self.sideBarType("contacts");
    self.side_bar_need_full_screen(false);
  }

  self.viewSearch = function(){
    self.sideBarType('search');
    self.fullSearching(!self.fullSearching());
    self.side_bar_need_full_screen(false);
  }
  
  self.viewRecents = function(){
    self.fullSearching(false);
    self.selectedGroup(0);
    self.searchingPeople(false);
    self.searchName("");
    self.sideBarType("recents");
    self.side_bar_need_full_screen(false);
  }
  
  self.addQM = function(){
    if (self.qmToAdd().length > 0){
      $.ajax({
        url: '/quick_message',
        type: 'POST',
        data: 'body=' + self.qmToAdd(),
        success: function(data) {
          self.qmToAdd("");
          self.qm.push(new quickMessage(data));
        }
      });
    }
  }
  
  self.sendACK = function(message_thread_id, message_id){
    $.ajax({
      url: '/message_thread/' + message_thread_id + '/ack',
      type: 'POST',
      data: 'message_id=' + message_id
    });
  }
  
  self.receiveACK = function(message_thread_id, message_id, user_id){
    thread = self.threads.getByProperty("id", message_thread_id);
    message = thread.messages.getByProperty("id", message_id);
    message.confirmUser(user_id);
  }
  
  self.receiveAcknowledgement = function(message_thread_id, message_id, user_id){
    thread = self.threads.getByProperty("id", message_thread_id);
    message = thread.messages.getByProperty("id", message_id);
    message.receiveAcknowledgement(user_id);
  }

  self.filteredGroups = ko.computed(function() {
    var groupsArray = self.groups();
    groupsFilter = ko.utils.arrayFilter(groupsArray, function(g) {
      if (g.traveler() == self.traveler())
        return true;
      return false;
    });
    if (self.searchName().length > 0) {
        self.searchingPeople(true);
        return ko.utils.arrayFilter(groupsFilter, function(g) {
          if (g.personsFilter().length > 0)
            return true;
          return false;
        });
    }
    else{
      self.searchingPeople(false);
      return groupsFilter;
    }
  })
  
  self.setTravelTrade = function(){
    self.traveler(false);
  }

  self.setTraveler = function(){
    self.traveler(true);
  }
  
  self.todayThreads = ko.computed(function(){
    var threadsArray = self.threads();
    var today = new Date();
    return ko.utils.arrayFilter(threadsArray, function(t) {
      if (t.messages().length > 0){
        last_msg = t.messages()[t.messages().length - 1];
        m_date = new Date(last_msg.updated_at());
        if ((m_date.getFullYear() == today.getFullYear()) && (m_date.getMonth() == today.getMonth()) && (m_date.getDate() == today.getDate()))
          return true;
        else
          return false;
      }
      else
        return false;
    });
  })
  
  self.yesterdayThreads = ko.computed(function(){
    var threadsArray = self.threads();
    var today = new Date();
    today.setDate(today.getDate() - 1);
    return ko.utils.arrayFilter(threadsArray, function(t) {
      if (t.messages().length > 0){
        last_msg = t.messages()[t.messages().length - 1];
        m_date = new Date(last_msg.updated_at());
        if ((m_date.getFullYear() == today.getFullYear()) && (m_date.getMonth() == today.getMonth()) && (m_date.getDate() == today.getDate()))
          return true;
        else
          return false;
      }
      else
        return false;
    });
  })
  
  self.setSelectedRecent = function(tab){
    self.selectedRecent(tab);
  }
  
  self.lastWeekThreads = ko.computed(function(){
    var threadsArray = self.threads();
    var today = new Date();
    var lastDay = new Date();
    today.setDate(today.getDate() - 1);
    today.setHours(0);
    today.setMinutes(0);
    lastDay.setDate(today.getDate() - 8);
    lastDay.setHours(0);
    lastDay.setMinutes(0);    
    return ko.utils.arrayFilter(threadsArray, function(t) {
      if (t.messages().length > 0){
        last_msg = t.messages()[t.messages().length - 1];
        m_date = new Date(last_msg.updated_at());
        if (m_date <= today && m_date >= lastDay)
          return true;
        else
          return false;
      }
      else
        return false;
    });
  })
  
  self.filteredThreads = ko.computed(function() {
    var messages = []
    var startDate = new Date(self.startDate());
    var endDate = new Date(self.endDate());
    startDate.setDate(startDate.getDate() - 1);
    endDate.setDate(endDate.getDate() + 1);
    
    if (self.searchPlace() == "Messages"){
      ko.utils.arrayForEach(self.threads(), function(t) {
        var messagesArray = t.messages();            
        for (var i = 0, j = messagesArray.length; i < j; i++){
          message_date = new Date(messagesArray[i].updated_at());
          if ((messagesArray[i].content().toLowerCase().search(self.messageSearch().toLowerCase()) != -1) && 
              (message_date >= startDate) && (message_date <= endDate)){
              if (self.searchType() != "All"){
                if (messagesArray[i].getStatusMsg() == " " + self.searchType())
                  messages.push(messagesArray[i]);
              }
              else
                messages.push(messagesArray[i]);
            }
        }
      });
    }
    if (self.searchPlace() == "People"){
      ko.utils.arrayForEach(self.threads(), function(t) {
        var messagesArray = t.messages();            
        for (var i = 0, j = messagesArray.length; i < j; i++){
          message_date = new Date(messagesArray[i].updated_at());
          if ((messagesArray[i].getPerson().name().toLowerCase().search(self.messageSearch().toLowerCase()) != -1) && 
              (message_date >= startDate) && (message_date <= endDate)){
              if (self.searchType() != "All"){
                if (messagesArray[i].getStatusMsg() == " " + self.searchType())
                  messages.push(messagesArray[i]);
              }
              else
                messages.push(messagesArray[i]);
            }
        }
      })
    }
    if (self.searchPlace() == "Description"){
      ko.utils.arrayForEach(self.threads(), function(t) {
        var messagesArray = t.messages();            
        for (var i = 0, j = messagesArray.length; i < j; i++){
          message_date = new Date(messagesArray[i].updated_at());
          if ((messagesArray[i].getPerson().category().toLowerCase().search(self.messageSearch().toLowerCase()) != -1) && 
              (message_date >= startDate) && (message_date <= endDate)){
              if (self.searchType() != "All"){
                if (messagesArray[i].getStatusMsg() == " " + self.searchType())
                  messages.push(messagesArray[i]);
              }
              else
                messages.push(messagesArray[i]);
            }
        }
      })
    }
    return messages;
  })
  
  self.getSearchedThread = function(thread){
    page = self.pages.getByProperty("currentThread", thread);
    if (page == undefined)
    {
      page = self.pages.getByProperty("currentReceiver", thread.users()[0].id());
      if (page == undefined)
      {
        np = new Page("message");
        np.currentReceiver(thread.users()[0].id());
        np.threads(thread.users()[0].threads())
        np.currentThread(thread);
        np.currentGroup(self.groups()[0]);
        np.searchingUsers(false);
        self.pages.unshift(np);
      }
      else{
       page.currentReceiver(thread.users()[0].id());
       page.threads(thread.users()[0].threads());
       page.currentThread(thread);
       page.currentGroup(application.groups()[0]);
       page.searchingUsers(false);
       page.typePage("message");
      }
      thread.sendACK();
    }
    self.messageSearch("");
    self.fullSearching(false);
    scrollDown(thread.id());
  }
  
  self.setSearchType = function(data){
    self.searchType(data);
    self.setSelect(false);
  }
  
  self.setSearchPlace = function(data){
    self.searchPlace(data);
    self.selectTypeSearch(false);
  }
  
  self.setSelect = function(){
    self.selectType(!self.selectType());
  }
  
  self.setSelectType = function(){
    self.selectTypeSearch(!self.selectTypeSearch());
  }
  
  self.setAttachId = function(id, thread_id){
    thread = self.threads.getByProperty("id", thread_id);
    thread.attachId(id);
  }

  self.removeAttachId = function(thread_id){
    thread = self.threads.getByProperty("id", thread_id);
    thread.attachId(0);
  }

}

changeCheckClass = function(id){
  var label = $("#label_checkbox-" + id);
  var class_name = label.attr('class');
  if (class_name == "label_uncheck"){
    label.removeClass("label_uncheck");
    label.addClass("label_check");
  }
  else{
    label.removeClass("label_check");
    label.addClass("label_uncheck");
  }

}

var scrollDown = function(id){
  var threads_div = $('#' + id);
  threads_div.animate({scrollTop: threads_div[0].scrollHeight});
}

var application = new app();
application.view_home();

var monthNames = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sept", "Oct", "Nov", "Dec" ];

