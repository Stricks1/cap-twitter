module UsersHelper
  def unfollow(user)
    cntnt = link_to 'Unfollow', following_path(user), method: :delete, :class => 'textdec-none form-btn unfollow-btn align-self-center'  
    return cntnt if current_user.follows.include?(user)
  
    nil
  end

  def user_edit_destroy_retweet(opi)
    cntnt = ''
    if current_user && opi.user.username == current_user.username
      cntnt.concat(link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/b3ee28c00f9504f9995a544ad14f2440b83f40a0/app/assets/images/pencil.svg', border: 0, class: 'edit-opinion'), edit_opinion_path(opi))
      cntnt.concat(link_to 'x', opi, method: :delete, data: { confirm: 'Are you sure?' }, :class => 'textdec-none ml-1')
      cntnt.html_safe
    else
      if current_user && opi.user.username != current_user.username
        cntnt.concat(link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/retweet.png', border: 0, class: 'edit-opinion'), retweet_path(opi))
        cntnt.html_safe
      end
    end
  end

  def btn_follow(u)
    link = link_to '+', follow_path(u), :class => 'textdec-none circle-link'
    return link unless current_user.follows.include?(u) || current_user == u
    
    nil
  end
end
