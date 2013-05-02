class PageStat
  extend Garb::Model

  metrics :exits, :pageviews, :visitors, :newVisits, :entrances, :uniquePageviews, :timeOnPage
  dimensions :page_path
end

module AnalyticsHelper

  def update_google_analytics
    Garb::Session.api_key = 'AIzaSyCC9m0nHitdxoduTZ-BxIuFGF_nJuhJxNY'
    Garb::Session.login(APP_CONFIG['ga_login'], APP_CONFIG['ga_password'])
    profile = Garb::Management::Profile.all.detect {|p| p.web_property_id == APP_CONFIG['ga_id']}

    PageStat.results(profile).results.each do |result|
      match = /(\/[a-zA-Z0-9_]{5,}\/projects\/[0-9]+)-/.match(result.page_path)
      result.page_path = match[1] unless match.nil?
      a = Analytical.find_by_page_path(result.page_path)
      if a.nil?
        Analytical.create(result.marshal_dump)
      else
        a.update_attributes(result.marshal_dump)
      end
    end
  end

  def google_analytics(path = request.full_path)
    match = /(\/[a-zA-Z0-9_]{5,}\/projects\/[0-9]+)-/.match(path)
    path = match[1] unless match.nil?
    stat = Analytical.find_by_page_path(path)
    if stat.nil? || stat.updated_at < Time.now - 10 * 60
      begin
        update_google_analytics
        stat = Analytical.find_by_page_path(path)
      rescue
        10.times { p "GOOGLE ANALYTICS CRAPPED OUT AGAIN!!!" }
      end
    end
    stat
  end
     
end