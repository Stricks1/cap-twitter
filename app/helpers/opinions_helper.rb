module OpinionsHelper
  def right_title
    if current_user
      cntnt = 'WHO TO FOLLOW'
    else 
      cntnt = 'WHO IS HERE'
    end
  end

  def center_title
    if current_user
      cntnt = 'Followeds Opinions'
    else
      cntnt = 'All Opinions'
    end
  end

  def linked_unlinked_comment(opi)
    if current_user
      cntnt = link_to image_tag(opi.user.photo, border: 0, class: 'timeline-photo'), user_path(opi.user)
    else
      cntnt = image_tag(opi.user.photo, border: 0, class: 'timeline-photo')
    end
  end


  def linked_unlinked_who(u)
    if current_user
      cntnt = link_to image_tag(u.photo, border: 0, class: 'rounded-circle who-photo mx-2 align-self-center'), user_path(u), class: 'align-self-center'
    else
      cntnt = image_tag(u.photo, border: 0, class: 'rounded-circle who-photo mx-2 align-self-center')
    end
  end

  def edit_destroy_retweet(opi)
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

  def copied_info(opi)
    return nil unless opi.copied

    edited = opi.created_at == opi.updated_at ? false : true
    info = edited ? 'Edited opinion copied from @' : 'Opinion copied from @'
    info.concat(opi.copied.username)
    if current_user
      cntnt = link_to info, user_path(opi.copied)
    else
      cntnt = info
    end
  end

  def op_btn_follow(u)
    link = link_to '+', follow_path(u), :class => 'textdec-none circle-link'
    return link if current_user

    nil
  end
end
