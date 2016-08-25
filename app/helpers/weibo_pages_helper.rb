module WeiboPagesHelper
  # Helper for chartkick options
  
  def last_update_time
    last = Mblog.order(:created_timestamp).last
    last.created_timestamp.localtime("+08:00")
  end
  
  def mblog_today_count
    column_chart mblog_today_count_charts_path, library: {
        title: {
          display: true,
          text: 'Posts Counts in Last 24 Hours',
          fontSize: 20
        }
    }
  end
  
  def mblog_by_gender
    pie_chart  mblog_by_gender_charts_path, library: {
        title: {
          display: true,
          text: 'UserSex',
          fontSize: 20
        }
    }
  end
  
  def mblog_top_source_bar
    bar_chart mblog_top_source_charts_path, 
    xtitle: "Counts of Posts", ytitle: "Source",
    library: {
      title: {
        display: true,
        text: 'Top 5 Source of Posts',
        fontSize: 20,
      }
    }
  end
  
  def mblog_top_source_pie
    pie_chart mblog_top_source_charts_path, library: {
      title: {
        display: true,
        text: 'Top 5 Source of Posts',
        fontSize: 20
      }
    }
  end
  
  def mblog_group_by_day
    area_chart mblog_group_by_day_charts_path,
    xtitle: "Dates", ytitle: "Counts of Posts",
    library: {
      title: {
        display: true,
        text: 'Posts Counts Group by Day',
        fontSize: 20
      }
    }
  end
  
  def mblog_group_by_hour_of_day
    line_chart mblog_group_by_hour_of_day_charts_path, 
    xtitle: "Hour of Day", ytitle: "Counts of Posts",
    library: {
      title: {
        display: true,
        text: 'Posts Counts Group by Hour of Day',
        fontSize: 20
      }
    }
  end
  
  def mblog_publish_top_source
    pie_chart mblog_publish_top_source_charts_path, library: {
      title: {
        display: true,
        text: 'Posts with Write/Publish - Top 5 source',
        fontSize: 20
      }
    }
  end
  
  def mblog_share_top_source
    pie_chart mblog_share_top_source_charts_path, library: {
      title: {
        display: true,
        text: 'Posts with Share - Top 5 source',
        fontSize: 20,
      }
    }
  end
  
end
