class ExternalAuthController < ApplicationController
  before_filter :authenticate_user!

  def new
    redirect_to "/auth/" + params[:provider]
  end

  def fail
    flash[:error] = "oAuth was not successful. Please try again."
    redirect_to edit_profile_path
  end

  def create
    if user_signed_in? && params['denied'].nil?
      case request.env['omniauth.auth'].provider
      when "twitter"
        current_user.verified_contacts.create({t: "twitter", info: request.env['omniauth.auth'].extra.raw_info.screen_name, auth: request.env['omniauth.auth'].to_json})
      when "linkedin_oauth2"
        if current_user.user_profile.nil?
          info = request.env['omniauth.auth']["extra"]["raw_info"]
          current_user.create_user_profile({
            name: info["firstName"] + " " + info["lastName"], 
            headline: info["headline"], 
            summary: info["summary"]
          });
        end
        current_user.verified_contacts.create({t: "linkedin", info: request.env['omniauth.auth'].extra.raw_info.publicProfileUrl, auth: request.env['omniauth.auth'].to_json})
      when "github"
        contact = current_user.verified_contacts.create({t: "github", info: request.env['omniauth.auth'].extra.raw_info.login, auth: request.env['omniauth.auth'].to_json})

        info = request.env['omniauth.auth']["extra"]["raw_info"]

        github = Github.new(
          user: request.env['omniauth.auth'].extra.raw_info.login, 
          oauth_token: request.env['omniauth.auth']["credentials"]["token"], 
          client_id: APP_CONFIG['github_key'], 
          secret: APP_CONFIG['github_secret']
        )

        lang_count = Hash.new(0)

        repos = github.repos.list

        repos.each { |repo| lang_count[repo['language']] += 1 if repo['language'] }

        lang = []
        lang_count.each { |l, c| lang.push({x: l, y: c}) }

        contact.github_panels.create({
          :language_count_json => lang.to_json,
          :user_id => current_user.id,
          :login => info["login"],
          :url => info["html_url"],
          :public_repos => info["public_repos"],
          :total_repos => repos.count,
          :followers => info["followers"],
          :following => info["following"],
          :github_created_at => info["created_at"],
          :github_updated_at => info["updated_at"]
        });
      when "facebook"
        current_user.verified_contacts.create({t: "facebook", info: request.env['omniauth.auth'].extra.raw_info.link, auth: request.env['omniauth.auth'].to_json})
      when "angellist"
        current_user.verified_contacts.create({t: "angellist", info: request.env['omniauth.auth'].info.angellist_url, auth: request.env['omniauth.auth'].to_json})
      end
    else
      flash[:error] = "An error occured when we tried to verify your account. Please try again later."
    end
      redirect_to edit_profile_path
  end
end
