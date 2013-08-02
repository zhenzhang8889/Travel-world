web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
web_old: bundle exec thin -p $PORT -e $RACK_ENV -R private_pub.ru start