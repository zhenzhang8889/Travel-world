# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.delete_all
# Group.delete_all
# QuickMessage.delete_all
# MessageThread.delete_all
# Message.delete_all


if LocationGroup.count == 0
  ["global|||Global|||10", "continent|||Continent|||20", "country|||Country|||30"].each do |lg|
    data = lg.split('|||')
    LocationGroup.create(:code => data[0], :name => data[1], :lorder => data[2])    
  end
end

if Area.count == 0
  File.readlines("#{Rails.root}/db/data/areas.txt").each do |line|
    data = line.gsub(/\n/, "").split('|||')
    # if data.size > 3
    #   puts data.to_json
    # # puts LocationGroup.find_by_code(data[2])
    #   puts LocationGroup.find_by_code(data[3])
    # end
    Area.create(:name => data[0],
      :atype => data.size > 2 ? data[2] : nil,
      :location_group => data.size > 3 ? LocationGroup.find_by_code(data[3]) : nil)
  end

  File.readlines("#{Rails.root}/db/data/areas.txt").each do |line|
    data = line.gsub(/\n/, "").split('|||')
    if data.size >= 2
      curr = Area.find_by_name(data[0])
      parent = Area.find_by_name(data[1])
      curr.parent = parent
      curr.save
    end
  end
end

if Service.count == 0
  ['Accommodation|||Accommodation', 'Airline|||Airline', 'Destination Management|||Destination Management', 'Tourism Organisation|||Tourism Organisation', 'Land Travel|||Land Travel', 'Media / Press|||Media / Press', 'IT / Technology Companies|||IT / Technology Companies', 'Tourist Attractions|||Tourist Attractions', 'Entertainment|||Entertainment', 'Tours|||Tours', 'Association|||Association', 'Training / Recruitment|||Training / Recruitment', 'Travel Agency|||Travel Agency', 'Ticketing|||Ticketing', 'Water Travel|||Water Travel', 'Charity|||Charity', 'Local Venue Operator|||Local Venue Operator', 'Travel Planner|||Travel Planner'].each do |s|
    Service.create(:code => s.split('|||')[0], :name => s.split('|||')[1])
  end
end

if Activity.count == 0
  ['Bed & Breakfast@@@', 'Holiday Parks@@@', 'Holiday Homes@@@', 'Hotels@@@', 'Motels@@@', 'Arts & Crafts@@@', 'Kayaking / Fresh Water@@@', 'Air Transport@@@', 'Bus / Coach Transport@@@', 'Ferries / Water Taxis@@@Transport', 'Backpackers@@@Accommodation', 'Caving@@@Activity', 'Conventions / Venues@@@Activity', 'Cycling / Mountain Biking@@@Activity', 'Diving@@@Activity', 'Scenic Flights@@@Activity', 'Galleries@@@Activity', 'Horse Treks@@@Activity', 'Hot Air Ballooning@@@Activity', 'Jet Boating@@@Activity', 'Climbing@@@Activity', 'Museums@@@Activity', 'Paragliding and Hang gliding@@@Activity', 'Rafting@@@Activity', 'Sky Diving@@@Activity', 'Study / Education@@@Activity', 'Surfing@@@Activity', 'Volcanic / Geothermal@@@Activity', 'Walking / Trekking@@@Activity', 'Weddings@@@Activity', 'Windsurfing & Kitesurfing@@@Activity', 'Wineries@@@Activity', 'Zoos@@@Activity', 'Boat Cruises@@@Activity', 'Sailing@@@Activity', 'Off Road Driving Adventure@@@Activity', 'Miscellaneous Madness@@@Activity', 'Sightseeing Tours@@@Tours', 'Dolphins@@@Activity', 'Whale Watching@@@Activity', 'Penguins@@@Activity', 'Bird Watching@@@Activity', 'Spas / Health Resorts and Thermal Bathing Pools@@@Activity', 'Cultural Attractions@@@Activity', 'Heritage Attractions@@@Activity', 'Guided Tours@@@Tours', 'Group Tours@@@Tours', 'Independent Tours@@@Tours', 'Urban and Scenic Attractions@@@Activity', 'Motorcycling@@@Transport', 'Boutique Accommodation@@@Accommodation', 'Serviced Apartments@@@Accommodation', 'Lodges@@@Accommodation', 'Exclusive@@@Accommodation', 'Seals@@@Activity', 'Other Wildlife@@@Activity', 'Custom Transfers@@@Transport', 'Fishing / Salt Water@@@Activity', 'Kayaking / Salt Water@@@Activity', 'Parasailing@@@Activity', 'Boat Cruises - Overnight@@@Activity', 'Skiing@@@', 'Snowboarding@@@'].each do |act|
    cate_name = act.split('@@@')[1]
    
    cate = nil
    unless cate_name.blank?
      cate = Actcate.find_or_create_by_name(cate_name)
    end

    Activity.create(:name => act.split('@@@')[0], :actcate => cate)
  end
end

if Term.count == 0
  Term.create
end

if Category.count == 0
  accommodation = Category.create(:name => "Accommodation")
  airline = Category.create(:name => "Airline")
  association = Category.create(:name => "Association")
  charity = Category.create(:name => "Charity")
  destination_management = Category.create(:name => "Destination Management")
  entertainment = Category.create(:name => "Entertainment")
  it_technology = Category.create(:name => "IT / Technology")
  land_travel = Category.create(:name => "Land Travel")
  local_venue_operator = Category.create(:name => "Local Venue Operator")
  media_press = Category.create(:name => "Media / Press")
  ticketing = Category.create(:name => "Ticketing")
  tourism_organisation = Category.create(:name => "Tourism Organisation")
  tourist_attractions = Category.create(:name => "Tourist Attractions")
  tours  = Category.create(:name => "Tours")
  training_recruitment = Category.create(:name => "Training / Recruitment")
  travel_agency = Category.create(:name => "Travel Agency")
  travel_planner = Category.create(:name => "Travel Planner")
  travel_writer = Category.create(:name => "Travel Writer")
  responsible_tourism = Category.create(:name => "Responsible Tourism")

  #Travel Trade
  user = User.create(:email => "enrique@xmartlabs.com", :password => "holanda", :traveler => false, :firstName => "Enrique",
                     :lastName => "Galindo", :country => "Uruguay", :city => "Montevideo", :category_id => it_technology.id,
                     :avatar => File.open(::Rails.root.join('public','photos','enrique.gif')))
  marcos = User.create(:email => "marcos@xmartlabs.com", :password => "holanda", :traveler => false, :firstName => "Marcos",
                       :lastName => "Lopez", :country => "Argentina", :city => "Buenos Aires", :category_id => tourism_organisation.id,
                       :avatar => File.open(::Rails.root.join('public','photos','marcos.jpeg')))
  emiliano = User.create(:email => "emiliano@xmartlabs.com", :password => "holanda", :traveler => false, :firstName => "Emiliano",
                         :lastName => "Barcia", :country => "USA", :city => "New York", :category_id => it_technology.id,
                         :avatar => File.open(::Rails.root.join('public','photos','emiliano.gif')))
  michael = User.create(:email => "michael@xmartlabs.com", :password => "holanda", :traveler => false, :firstName => "Michael",
                        :lastName => "Jobs", :country => "Spain", :city => "Madrid", :category_id => training_recruitment.id,
                        :avatar => File.open(::Rails.root.join('public','photos','michael.gif')))
  maximo = User.create(:email => "maximo@xmartlabs.com", :password => "holanda", :traveler => false, :firstName => "Maximo",
                       :lastName => "Mussinni", :country => "England", :city => "London", :category_id => travel_planner.id,
                       :avatar => File.open(::Rails.root.join('public','photos','maximo.jpeg')))
  gaston = User.create(:email => "gaston@xmartlabs.com", :password => "holanda", :traveler => false, :firstName => "Gaston",
                       :lastName => "Castro", :country => "France", :city => "Paris", :category_id => responsible_tourism.id,
                       :avatar => File.open(::Rails.root.join('public','photos','gaston.gif')))
  gabriel = User.create(:email => "gabriel@xmartlabs.com", :password => "holanda", :traveler => false, :firstName => "Gabriel",
                       :lastName => "Romano", :country => "Brazil", :city => "Sao Paulo", :category_id => tours.id,
                       :avatar => File.open(::Rails.root.join('public','photos','gabriel.jpeg')))
  guzman = User.create(:email => "guzman@xmartlabs.com", :password => "holanda", :traveler => false, :firstName => "Guzman",
                       :lastName => "Romero", :country => "Germany", :city => "Berlin", :category_id => media_press.id,
                       :avatar => File.open(::Rails.root.join('public','photos','guzman.jpeg')))

  qm1 = QuickMessage.create(:body => "I'm in a meeting.", :user_id => user.id)
  qm2 = QuickMessage.create(:body => "Busy... call you back in an hour.", :user_id => user.id)

  group1 = Group.create(:name => "Uruguay", :user_id => user.id, :traveler => false)
  group2 = Group.create(:name => "Hotels", :user_id => user.id, :traveler => false)
  group3 = Group.create(:name => "Other", :user_id => user.id, :traveler => false)

  group1.users << marcos
  group1.users << emiliano
  group1.users << michael
  group1.users << maximo
  group1.users << gaston
  group1.users << gabriel
  group1.users << guzman

  group3.users << marcos
  group2.users << emiliano
  group3.users << michael
  group2.users << maximo
  group3.users << gaston
  group2.users << gabriel
  group3.users << guzman

  group4 = Group.create(:name => "Friends", :user_id => emiliano.id, :traveler => false)

  group4.users << marcos
  group4.users << user
  group4.users << michael
  group4.users << maximo
  group4.users << gaston
  group4.users << gabriel
  group4.users << guzman

  group4 = Group.create(:name => "Family", :user_id => emiliano.id, :traveler => false)

  group4.users << marcos
  group4.users << user
  group4.users << guzman


  t1 = MessageThread.create(:subject => "Test1")
  m1 = Message.create(:content => "Hola", :ack => false, :message_thread_id => t1.id, :user_id => user.id)
  m2 = Message.create(:content => "Como va?", :ack => false, :message_thread_id => t1.id, :user_id => marcos.id)
  m3 = Message.create(:content => "Bien.", :ack => false, :message_thread_id => t1.id, :user_id => user.id)
  m4 = Message.create(:content => "Vos?", :ack => false, :message_thread_id => t1.id, :user_id => user.id)
  m5 = Message.create(:content => "Bien", :ack => false, :message_thread_id => t1.id, :user_id => marcos.id)
  t1.users << user
  t1.users << marcos

  t2 = MessageThread.create(:subject => "Test2")
  m1 = Message.create(:content => "Hi", :ack => false, :message_thread_id => t2.id, :user_id => user.id)
  m2 = Message.create(:content => "How are you?", :ack => false, :message_thread_id => t2.id, :user_id => emiliano.id)
  m3 = Message.create(:content => "Fine.", :ack => false, :message_thread_id => t2.id, :user_id => user.id)
  m4 = Message.create(:content => "You?", :ack => false, :message_thread_id => t2.id, :user_id => user.id)
  m5 = Message.create(:content => "Fine", :ack => false, :message_thread_id => t2.id, :user_id => emiliano.id)
  t2.users << user
  t2.users << emiliano

  t3 = MessageThread.create(:subject => "Test3")
  m1 = Message.create(:content => "Hola", :ack => false, :message_thread_id => t3.id, :user_id => user.id)
  m2 = Message.create(:content => "How are you?", :ack => false, :message_thread_id => t3.id, :user_id => michael.id)
  m3 = Message.create(:content => "Bien.", :ack => false, :message_thread_id => t3.id, :user_id => user.id)
  m4 = Message.create(:content => "you?", :ack => false, :message_thread_id => t3.id, :user_id => user.id)
  m5 = Message.create(:content => "Bien", :ack => false, :message_thread_id => t3.id, :user_id => michael.id)
  t3.users << user
  t3.users << michael

  t4 = MessageThread.create(:subject => "Test4")
  m1 = Message.create(:content => "Hi", :ack => false, :message_thread_id => t4.id, :user_id => user.id)
  m2 = Message.create(:content => "Como va?", :ack => false, :message_thread_id => t4.id, :user_id => maximo.id)
  m3 = Message.create(:content => "Fine.", :ack => false, :message_thread_id => t4.id, :user_id => user.id)
  m4 = Message.create(:content => "Vos?", :ack => false, :message_thread_id => t4.id, :user_id => user.id)
  m5 = Message.create(:content => "Fine", :ack => false, :message_thread_id => t4.id, :user_id => maximo.id)
  t4.users << user
  t4.users << maximo

  t5 = MessageThread.create(:subject => "Test5")
  m1 = Message.create(:content => "Hola", :ack => false, :message_thread_id => t5.id, :user_id => user.id)
  m2 = Message.create(:content => "How are you?", :ack => false, :message_thread_id => t5.id, :user_id => gaston.id)
  m3 = Message.create(:content => "Bien.", :ack => false, :message_thread_id => t5.id, :user_id => user.id)
  m4 = Message.create(:content => "Vos?", :ack => false, :message_thread_id => t5.id, :user_id => user.id)
  m5 = Message.create(:content => "Fine", :ack => false, :message_thread_id => t5.id, :user_id => gaston.id)
  t5.users << user
  t5.users << gaston

  t6 = MessageThread.create(:subject => "Test6")
  m1 = Message.create(:content => "Hi", :ack => false, :message_thread_id => t6.id, :user_id => user.id)
  m2 = Message.create(:content => "How areyou?", :ack => false, :message_thread_id => t6.id, :user_id => gabriel.id)
  m3 = Message.create(:content => "Bien.", :ack => false, :message_thread_id => t6.id, :user_id => user.id)
  m4 = Message.create(:content => "You?", :ack => false, :message_thread_id => t6.id, :user_id => user.id)
  m5 = Message.create(:content => "Bien", :ack => false, :message_thread_id => t6.id, :user_id => gabriel.id)
  t6.users << user
  t6.users << gabriel

  t7 = MessageThread.create(:subject => "Test7")
  m1 = Message.create(:content => "Hola", :ack => false, :message_thread_id => t7.id, :user_id => user.id)
  m2 = Message.create(:content => "Como va?", :ack => false, :message_thread_id => t7.id, :user_id => guzman.id)
  m3 = Message.create(:content => "Fine.", :ack => false, :message_thread_id => t7.id, :user_id => user.id)
  m4 = Message.create(:content => "Vos?", :ack => false, :message_thread_id => t7.id, :user_id => user.id)
  m5 = Message.create(:content => "Bien", :ack => false, :message_thread_id => t7.id, :user_id => guzman.id)
  t7.users << user
  t7.users << guzman

  t8 = MessageThread.create(:subject => "Test8")
  t8.users << marcos
  t8.users << user

  t9 = MessageThread.create(:subject => "Test9")
  t9.users << emiliano
  t9.users << user

  t10 = MessageThread.create(:subject => "Test10")
  t10.users << michael
  t10.users << user

  t11 = MessageThread.create(:subject => "Test11")
  t11.users << maximo
  t11.users << user

  t12 = MessageThread.create(:subject => "Test12")
  t12.users << gaston
  t12.users << user

  t13 = MessageThread.create(:subject => "Test13")
  t13.users << gabriel
  t13.users << user

  t14 = MessageThread.create(:subject => "Test14")
  t14.users << guzman
  t14.users << user

  # Travelers
  martin = User.create(:email => "martin@xmartlabs.com", :password => "holanda", :traveler => true, :firstName => "Martin",
                     :lastName => "Barreto", :country => "Uruguay", :city => "Montevideo", :description => "Passioned Programer",
                     :avatar => File.open(::Rails.root.join('public','photos','martin.jpeg')))
  agustin = User.create(:email => "agustin@xmartlabs.com", :password => "holanda", :traveler => true, :firstName => "Agustin",
                       :lastName => "Hernandez", :country => "Argentina", :city => "Buenos Aires", :description => "Passioned Soccer",
                       :avatar => File.open(::Rails.root.join('public','photos','agustin.jpeg')))
  diego = User.create(:email => "diego@xmartlabs.com", :password => "holanda", :traveler => true, :firstName => "Diego",
                         :lastName => "Gard", :country => "USA", :city => "New York", :description => "Rocker",
                         :avatar => File.open(::Rails.root.join('public','photos','diego.jpeg')))
  ramiro = User.create(:email => "ramiro@xmartlabs.com", :password => "holanda", :traveler => true, :firstName => "Ramiro",
                        :lastName => "Jobs", :country => "Spain", :city => "Madrid", :description => "Party man!",
                        :avatar => File.open(::Rails.root.join('public','photos','ramiro.jpeg')))
                        
  group5 = Group.create(:name => "Uruguay", :user_id => user.id, :traveler => true)
  group6 = Group.create(:name => "Argentina", :user_id => user.id, :traveler => true)

  group5.users << martin
  group5.users << agustin

  group6.users << diego
  group6.users << ramiro

  group8 = Group.create(:name => "All", :user_id => martin.id, :traveler => true)
  group8.users << diego
  group8.users << ramiro
  group8.users << agustin

  group9 = Group.create(:name => "All", :user_id => agustin.id, :traveler => true)
  group9.users << diego
  group9.users << ramiro
  group9.users << martin

  group10 = Group.create(:name => "All", :user_id => diego.id, :traveler => true)
  group10.users << agustin
  group10.users << ramiro
  group10.users << martin

  group11 = Group.create(:name => "All", :user_id => ramiro.id, :traveler => true)
  group11.users << agustin
  group11.users << diego
  group11.users << martin

  group12 = Group.create(:name => "Travel Agency", :user_id => martin.id, :traveler => false)
  group13 = Group.create(:name => "Travel Agency", :user_id => agustin.id, :traveler => false)
  group14 = Group.create(:name => "Travel Agency", :user_id => diego.id, :traveler => false)
  group15 = Group.create(:name => "Travel Agency", :user_id => ramiro.id, :traveler => false)

  group12.users << user
  group13.users << user
  group14.users << user
  group15.users << user

  t15 = MessageThread.create(:subject => "Test1 Travelers 1")
  m1 = Message.create(:content => "Hola", :ack => false, :message_thread_id => t15.id, :user_id => user.id)
  m2 = Message.create(:content => "Como va?", :ack => false, :message_thread_id => t15.id, :user_id => martin.id)
  m3 = Message.create(:content => "Bien.", :ack => false, :message_thread_id => t15.id, :user_id => user.id)
  m4 = Message.create(:content => "Vos?", :ack => false, :message_thread_id => t15.id, :user_id => user.id)
  m5 = Message.create(:content => "Bien", :ack => false, :message_thread_id => t15.id, :user_id => martin.id)
  t15.users << user
  t15.users << martin

  t16 = MessageThread.create(:subject => "Test1 Travelers 2")
  t16.users << martin
  t16.users << user

  t17 = MessageThread.create(:subject => "Test1 Travelers 3")
  m1 = Message.create(:content => "Hola", :ack => false, :message_thread_id => t17.id, :user_id => user.id)
  m2 = Message.create(:content => "Como va?", :ack => false, :message_thread_id => t17.id, :user_id => agustin.id)
  m3 = Message.create(:content => "Bien.", :ack => false, :message_thread_id => t17.id, :user_id => user.id)
  m4 = Message.create(:content => "Vos?", :ack => false, :message_thread_id => t17.id, :user_id => user.id)
  m5 = Message.create(:content => "Bien", :ack => false, :message_thread_id => t17.id, :user_id => agustin.id)
  t17.users << user
  t17.users << agustin

  t18 = MessageThread.create(:subject => "Test1 Travelers 4")
  t18.users << martin
  t18.users << agustin

  t19 = MessageThread.create(:subject => "Test1 Travelers 5")
  m1 = Message.create(:content => "Hola", :ack => false, :message_thread_id => t19.id, :user_id => user.id)
  m2 = Message.create(:content => "Como va?", :ack => false, :message_thread_id => t19.id, :user_id => diego.id)
  m3 = Message.create(:content => "Bien.", :ack => false, :message_thread_id => t19.id, :user_id => user.id)
  m4 = Message.create(:content => "Vos?", :ack => false, :message_thread_id => t19.id, :user_id => user.id)
  m5 = Message.create(:content => "Bien", :ack => false, :message_thread_id => t19.id, :user_id => diego.id)
  t19.users << user
  t19.users << diego

  t20 = MessageThread.create(:subject => "Test1 Travelers 6")
  t20.users << diego
  t20.users << user

  t21 = MessageThread.create(:subject => "Test1 Travelers 7")
  m1 = Message.create(:content => "Hola", :ack => false, :message_thread_id => t21.id, :user_id => user.id)
  m2 = Message.create(:content => "Como va?", :ack => false, :message_thread_id => t21.id, :user_id => ramiro.id)
  m3 = Message.create(:content => "Bien.", :ack => false, :message_thread_id => t21.id, :user_id => user.id)
  m4 = Message.create(:content => "Vos?", :ack => false, :message_thread_id => t21.id, :user_id => user.id)
  m5 = Message.create(:content => "Bien", :ack => false, :message_thread_id => t21.id, :user_id => ramiro.id)
  t21.users << user
  t21.users << ramiro

  t22 = MessageThread.create(:subject => "Test1 Travelers 9")
  t22.users << ramiro
  t22.users << martin

  t23 = MessageThread.create(:subject => "Test1 Travelers 10")
  t23.users << martin
  t23.users << diego

  t24 = MessageThread.create(:subject => "Test1 Travelers 11")
  t24.users << martin
  t24.users << agustin

  t25 = MessageThread.create(:subject => "Test1 Travelers 8")
  t25.users << ramiro
  t25.users << diego

  t26 = MessageThread.create(:subject => "Test1 Travelers 8")
  t26.users << ramiro
  t26.users << agustin

  t27 = MessageThread.create(:subject => "Test1 Travelers 12")
  t27.users << agustin
  t27.users << diego


  group11 = Group.create(:name => "All", :user_id => user.id, :traveler => false)
  group11.users << marcos
  group11.users << emiliano
  group11.users << michael
  group11.users << maximo
  group11.users << gaston
  group11.users << gabriel
  group11.users << guzman

  group12 = Group.create(:name => "All", :user_id => marcos.id, :traveler => false)
  group12.users << user
  group12.users << emiliano
  group12.users << michael
  group12.users << maximo
  group12.users << gaston
  group12.users << gabriel
  group12.users << guzman

  group14 = Group.create(:name => "All", :user_id => emiliano.id, :traveler => false)
  group14.users << user
  group14.users << marcos
  group14.users << michael
  group14.users << maximo
  group14.users << gaston
  group14.users << gabriel
  group14.users << guzman

  group15 = Group.create(:name => "All", :user_id => michael.id, :traveler => false)
  group15.users << user
  group15.users << marcos
  group15.users << emiliano
  group15.users << maximo
  group15.users << gaston
  group15.users << gabriel
  group15.users << guzman

  group16 = Group.create(:name => "All", :user_id => maximo.id, :traveler => false)
  group16.users << user
  group16.users << marcos
  group16.users << emiliano
  group16.users << michael
  group16.users << gaston
  group16.users << gabriel
  group16.users << guzman

  group17 = Group.create(:name => "All", :user_id => gaston.id, :traveler => false)
  group17.users << user
  group17.users << marcos
  group17.users << emiliano
  group17.users << michael
  group17.users << maximo
  group17.users << gabriel
  group17.users << guzman

  group18 = Group.create(:name => "All", :user_id => gabriel.id, :traveler => false)
  group18.users << user
  group18.users << marcos
  group18.users << emiliano
  group18.users << michael
  group18.users << maximo
  group18.users << gaston
  group18.users << guzman

  group19 = Group.create(:name => "All", :user_id => guzman.id, :traveler => false)
  group19.users << user
  group19.users << marcos
  group19.users << emiliano
  group19.users << michael
  group19.users << maximo
  group19.users << gaston
  group19.users << gabriel

  group20 = Group.create(:name => "All", :user_id => user.id, :traveler => true)
  group20.users << diego
  group20.users << ramiro
  group20.users << martin
  group20.users << agustin

  group21 = Group.create(:name => "All", :user_id => marcos.id, :traveler => true)
  group21.users << diego
  group21.users << ramiro
  group21.users << martin
  group21.users << agustin

  group22 = Group.create(:name => "All", :user_id => emiliano.id, :traveler => true)
  group22.users << diego
  group22.users << ramiro
  group22.users << martin
  group22.users << agustin

  group23 = Group.create(:name => "All", :user_id => guzman.id, :traveler => true)
  group23.users << diego
  group23.users << ramiro
  group23.users << martin
  group23.users << agustin

  group24 = Group.create(:name => "All", :user_id => michael.id, :traveler => true)
  group24.users << diego
  group24.users << ramiro
  group24.users << martin
  group24.users << agustin

  group25 = Group.create(:name => "All", :user_id => maximo.id, :traveler => true)
  group25.users << diego
  group25.users << ramiro
  group25.users << martin
  group25.users << agustin

  group26 = Group.create(:name => "All", :user_id => gaston.id, :traveler => true)
  group26.users << diego
  group26.users << ramiro
  group26.users << martin
  group26.users << agustin

  group27 = Group.create(:name => "All", :user_id => gabriel.id, :traveler => true)
  group27.users << diego
  group27.users << ramiro
  group27.users << martin
  group27.users << agustin


  group28 = Group.create(:name => "All", :user_id => diego.id, :traveler => false)
  group28.users << user
  group28.users << guzman
  group28.users << marcos
  group28.users << emiliano
  group28.users << michael
  group28.users << maximo
  group28.users << gaston
  group28.users << gabriel

  group29 = Group.create(:name => "All", :user_id => ramiro.id, :traveler => false)
  group29.users << user
  group29.users << guzman
  group29.users << marcos
  group29.users << emiliano
  group29.users << michael
  group29.users << maximo
  group29.users << gaston
  group29.users << gabriel

  group30 = Group.create(:name => "All", :user_id => martin.id, :traveler => false)
  group30.users << user
  group30.users << guzman
  group30.users << marcos
  group30.users << emiliano
  group30.users << michael
  group30.users << maximo
  group30.users << gaston
  group30.users << gabriel

  group31 = Group.create(:name => "All", :user_id => agustin.id, :traveler => false)
  group31.users << user
  group31.users << guzman
  group31.users << marcos
  group31.users << emiliano
  group31.users << michael
  group31.users << maximo
  group31.users << gaston
  group31.users << gabriel
end

if Admin.count == 0
  Admin.create(:email => 'matt.codina@gmail.com', :password => 'access', :password_confirmation => 'access')
  Admin.create(:email => 'lewisou@gmail.com', :password => '123456', :password_confirmation => '123456')
end

