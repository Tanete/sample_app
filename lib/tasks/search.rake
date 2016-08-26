namespace :search do
  task mblogs: :environment do
    Mblog.hunt("简书",1,100)
    Rails.logger.info "rake task: imported mblogs"
  end
end