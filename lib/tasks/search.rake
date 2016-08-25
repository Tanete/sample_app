namespace :search do
  task mblogs: :environment do
    require 'app/models/mblog.rb'
    Mblog.hunt("简书",1,100)
  end
end