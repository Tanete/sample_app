namespace :search do
  task mblogs: :environment do
    Mblog.hunt("简书",1,100)
    logger.info "rake task: imported mblogs"
  end
end