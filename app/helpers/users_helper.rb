module UsersHelper
  def unfollow(user)
    cntnt = link_to 'Unfollow', following_path(user), method: :delete, :class => 'textdec-none form-btn unfollow-btn align-self-center'  
    return cntnt if current_user.follows.include?(user)
  
    nil
  end
end
