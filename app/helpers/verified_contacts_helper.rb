module VerifiedContactsHelper
  def verifiedContactIcon(type)
    case type
    when "twitter"
      "<i class='icon-twitter icon-2x pull-left'></i>"
    when "facebook"
      "<i class='icon-facebook icon-2x'></i>"
    when "linkedin"
      "<i class='icon-linkedin icon-2x'></i>"
    when "github"
      "<i class='icon-github icon-2x'></i>"
    else
      ""
    end
  end

  def verifiedContactLink(contact)
    case contact.t
    when "twitter"
      "https://twitter.com/#{contact.info}"
    when "facebook"
      "https://facebook.com/"
    when "linkedin"
      contact.info
    when "github"
      "https://github.com/#{contact.info}"
    else
      ""
    end
  end
end
