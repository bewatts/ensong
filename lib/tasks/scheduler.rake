namespace :cleanup do 
  task :delete_demo_users => :environment do
    User.delete_demo_users
  end
end