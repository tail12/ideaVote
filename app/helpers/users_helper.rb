module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    unless user.avatar.url
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
    else
      image_tag(user.avatar.url, alt: user.name, class: "gravatar")
    end
  end
end
