class Mblog < ApplicationRecord
  validates :mid, uniqueness: true

  # Search related posts
  def self.hunt(search_word, page_min, page_max)
    counter = 0
    a = WeiboSearch.new(search_word)
    # each page
    (page_min..page_max).each do |page|
      search_url = a.url(page)
      json_res = a.do_search(search_url)
      a.retry_if_nil(search_url, json_res)
      next if json_res['cards'].nil?
      # store each post
      (0..9).each do |i|
        post = json_res['cards'][i]
        if post != nil
          result = a.hash_post(post)
          mblog = Mblog.create(result)
          counter += 1 if mblog.persisted?
        end
      end
    end
    logger.info "created: #{counter} posts"
  end
end
