class ChartsController < ApplicationController
  
  @@start_date = ("2016-08-19").to_datetime
  @@range = 8.hours.ago(@@start_date)..(8.hours.ago(Date.today)-1)
  @@range_today = 24.hours.ago(Time.zone.now)..Time.zone.now
  
  def mblog_today_count
    result = Mblog.group_by_hour(:created_timestamp,
              time_zone = "Beijing", range: @@range_today, 
              current: true, format: "%l %P").count
    render json: result
  end
  
  def mblog_by_gender
    result = Mblog.group(:user_gender).count
    render json: [['Male',result['m']], ['Female',result['f']]]
  end
  
  def mblog_top_source
    result = Mblog.group(:source).where("source IS NOT NULL")
                              .order("count_all DESC, source").limit(5).count
    render json: result
  end
  
  def mblog_group_by_day
    
    
    result = Mblog.group_by_day(:created_timestamp, 
                                  time_zone: 'Beijing', range: @@range).count
    render json: result
  end
  
  def mblog_group_by_hour_of_day
    days = (Date.today-@@start_date).to_i
    result = Mblog.group_by_hour_of_day(:created_timestamp, 
                                  time_zone: 'Beijing', range: @@range).count
    result.each do |hour, count|
      result[hour] = count / days
    end
    render json: result
  end
  
  def mblog_publish_top_source
    result = Mblog.group(:source).where("content LIKE '%写了%' OR content LIKE '%发表%'")
                                .order("count_all DESC, source").limit(5).count
    render json: result
  end
  
  def mblog_share_top_source
    result = Mblog.group(:source).where("content LIKE '%推荐%'")
                                .order("count_all DESC, source").limit(5).count
    render json: result
  end
end
