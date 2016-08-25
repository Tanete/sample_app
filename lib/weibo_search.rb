# encoding: utf-8
require 'httparty'

class WeiboSearch
  
  def initialize(word)
    @search_word = word
  end
  
  def url(page)
    @escape_s_word = URI::escape(@search_word)
    @search_url = "http://m.weibo.cn/page/pageJson?containerid=&containerid=100103type%3D2%26q%3D#{@escape_s_word}&type=wb&queryVal=#{@escape_s_word}A6&luicode=10000011&lfid=100103type%3D1%26q%3D&title=#{@escape_s_word}&v_p=11&ext=&fid=100103type%3D2%26q%3D#{@escape_s_word}&uicode=10000011&next_cursor=&page=#{page}"
  end

  def do_search(url)
    HTTParty.get(url).parsed_response
  end
  
  def retry_if_nil(search_url, json_res)
    if json_res['cards'].nil?
      5.times do
        sleep 2
        do_search(search_url)
        break if !json_res['cards'].nil?
      end
    end
  end
  
  def hash_post(post)
    mblog = post['card_group'][0]['mblog']
    hash = {}
    hash[:mid]               = mblog['id']
    hash[:created_timestamp] = Time.at(mblog['created_timestamp'])
    hash[:content]           = mblog['text']
    hash[:source]            = mblog['source']
    user                     = mblog['user']
    hash[:user_id]           = user['id']
    hash[:user_name]         = user['screen_name']
    hash[:user_status_count] = user['statuses_count']
    hash[:user_gender]       = user['gender']
    hash[:user_fansNum]      = user['fansNum']
    # puts hash
    return hash
  end

  # def start(page_min, page_max)
  #   (page_min..page_max).each do |page|
  #     search_url = url(page)
  #     json_res = do_search(search_url)
  #     retry_if_nil(search_url, json_res)
  #     next if json_res["cards"].nil?
  #     (0..9).each do |i|
  #       post = json_res['cards'][i]
  #       if post != nil
  #         hash_post(post)
  #       end
  #     end
  #   end
  # end  
end

# a = WeiboSearch.new("简书")
# a.start(1,5)