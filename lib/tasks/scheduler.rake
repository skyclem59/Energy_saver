desc "This task is called by the Heroku scheduler add-on"
task :feed_electricity => :environment do
  puts "Updating feed..."
  NewsFeed.update
  puts "done."
end
