class Analytical < ActiveRecord::Base
  attr_accessible :page_path, 
                  :exits, 
                  :pageviews, 
                  :visitors, 
                  :new_visits, 
                  :entrances, 
                  :unique_pageviews, 
                  :time_on_page
end
