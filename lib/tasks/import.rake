require 'csv'
namespace :import do
  
  desc "Import mblogs from csv"
  task mblogs: :environment do
    filename = File.join Rails.root, 'mblogs.csv'
    counter = 0
    CSV.foreach(filename, :headers => true) do |row|
      mblog = Mblog.create( mid: row['mid'],
                            created_timestamp: 8.hours.ago(row['created_timestamp'].to_datetime),
                            content: row['content'],
                            source: row['source'],
                            user_id: row['user_id'],
                            user_name: row['user_name'],
                            user_gender: row['user_gender'],
                            user_status_count: row['user_status_count'],
                            user_fansNum: row['user_fansNum'])
      puts "#{row['mid']} - #{mblog.errors.full_messages.join(',')}" if mblog.errors.any?
      counter += 1 if mblog.persisted?
    end
    Rails.logger.info "rake task: imported #{counter} mblogs"
  end
end