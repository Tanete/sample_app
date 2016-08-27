class ChartsController < ApplicationController
  
  @@start_date = ("2016-08-19").to_datetime
  
  def mblog_today_count
    result = Mblog.group_by_hour(:created_timestamp,
                                time_zone = "Beijing", range: get_range_today, 
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
                                  time_zone: 'Beijing', range: get_range).count
    render json: result
  end
  
  def mblog_group_by_hour_of_day
    days = (Date.today-@@start_date).to_i
    result = Mblog.group_by_hour_of_day(:created_timestamp, 
                                  time_zone: 'Beijing', range: get_range).count
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
  
  private
    def get_range_today
      start = 24.hours.ago(Time.zone.now).change(:min=>0) + 1.hour + 1.second
      ending = Time.zone.now.change(:min=>0) + 1.hour- 1.second
      start..ending
    end
    
    def get_range
      Time.zone = 'Beijing'
      (@@start_date - 8.hour)..(Time.zone.today - 1.second)
    end
end
