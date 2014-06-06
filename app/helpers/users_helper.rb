module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.email, class: "gravatar")
  end

  def wisher_path wisher
     "/users/#{wisher.id}"
  end

  def owner_path owner
     "/users/#{owner.id}"
  end

  def wished_path wished
     "/games/#{wished.friendly_id}"
  end

  def owned_path owned
     "/games/#{owned.friendly_id}"
  end
end
