module OpinionsHelper
  def right_title
    current_user ? 'WHO TO FOLLOW' : 'WHO IS HERE'
  end

  def center_title
    current_user ? 'Followeds Opinions' : 'All Opinions'
  end

  def linked_unlinked_comment(opi)
    if current_user
      link_to image_tag(opi.user.photo, border: 0, class: 'timeline-photo'), user_path(opi.user)
    else
      image_tag(opi.user.photo, border: 0, class: 'timeline-photo')
    end
  end

  def linked_unlinked_who(usr)
    if current_user
      link_to image_tag(usr.photo, border: 0, class: 'rounded-circle who-photo mx-2 align-self-center'), user_path(usr), class: 'align-self-center'
    else
      image_tag(usr.photo, border: 0, class: 'rounded-circle who-photo mx-2 align-self-center')
    end
  end

  def edit_destroy_retweet(opi)
    cntnt = ''
    if current_user && opi.user.username == current_user.username
      cntnt.concat((link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/b3ee28c00f9504f9995a544ad14f2440b83f40a0/app/assets/images/pencil.svg', border: 0, class: 'edit-opinion'), edit_opinion_path(opi)))
      cntnt.concat((link_to 'x', opi, method: :delete, data: { confirm: 'Are you sure?' }, class: 'textdec-none ml-1'))
      cntnt.html_safe
    elsif current_user && opi.user.username != current_user.username
      cntnt.concat((link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/retweet.png', border: 0, class: 'edit-opinion'), retweet_path(opi)))
      cntnt.html_safe
    end
  end

  def copied_info(opi)
    return nil unless opi.copied

    edited = opi.created_at != opi.updated_at
    info = edited ? 'Edited opinion copied from @' : 'Opinion copied from @'
    info.concat(opi.copied.username)
    if current_user
      link_to info, user_path(opi.copied)
    else
      info
    end
  end

  def op_btn_follow(usr)
    link = link_to '+', follow_path(usr), class: 'textdec-none circle-link'
    return link if current_user

    nil
  end
end
