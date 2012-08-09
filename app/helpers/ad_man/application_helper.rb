module AdMan
  module ApplicationHelper
      def link_to_ad(keyword = nil, size = "leaderboard")
    		keyword ||= get_keyword_from_url
				if keyword && !keyword.blank? 
    		  keyword_id = Keyword.find_by_name(keyword).id
    			ad = Advertisement.render_random_ad(keyword_id)
       	  #grab size? leaderboard or banner
				else 
					ad = Advertisement.render_random_ad
				end
    		if !ad.nil?
    			ad.display_count += 1
    			ad.save
    			link_to image_tag(ad.ad_banner.url(size)), { :controller => 'advertisements', :action => 'click_through', :id => ad.id }, 
    			:method => :post, :target => '_blank'
    		end
    	end    

    	#grab the keyword form request url
  		def get_keyword_from_url
  		 req_url = request.env["REQUEST_PATH"].split("/")
    	 keyword_names = Keyword.all.map{ |keyword| keyword.name }
    	 keyword = req_url & keyword_names
		   #return (keyword)?(keyword):(Keyword.all[rand(Keyword.all.size)])
	     end
  end
end
