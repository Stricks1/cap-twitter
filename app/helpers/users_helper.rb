module UsersHelper
  def follow_unfollow(user)
    cntnt = link_to 'Unfollow', following_path(user), method: :delete, class: 'textdec-none form-btn unfollow-btn align-self-center'
    return cntnt if current_user.follows.include?(user)

    cntnt = link_to 'Follow', follow_path(user), class: 'textdec-none form-btn unfollow-btn align-self-center'
    return cntnt unless current_user.follows.include?(user) || current_user == user

    nil
  end

  def user_edit_destroy_retweet(opi)
    cntnt = ''
    if current_user && opi.user.username == current_user.username
      cntnt.concat((link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/b3ee28c00f9504f9995a544ad14f2440b83f40a0/app/assets/images/pencil.svg', class: 'edit-opinion', alt: 'edit'), edit_opinion_path(opi)))
      cntnt.concat((link_to 'x', opi, method: :delete, data: { confirm: 'Are you sure?' }, class: 'textdec-none ml-1'))
      cntnt.html_safe
    elsif current_user && opi.user.username != current_user.username
      cntnt.concat((link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/retweet.png', class: 'edit-opinion', alt: 'copy_opinion'), retweet_path(opi)))
      cntnt.html_safe
    end
  end

  def btn_follow(usr)
    link = link_to '+', follow_path(usr), class: 'textdec-none circle-link'
    return link unless current_user.follows.include?(usr) || current_user == usr

    nil
  end

  def user_copied_info(opi)
    return nil unless opi.copied

    edited = opi.created_at != opi.updated_at
    info = edited ? 'Edited opinion copied from @' : 'Opinion copied from @'
    info.concat(opi.copied.username)
    link_to info, user_path(opi.copied)
  end

  def cover_photo(usr)
    usr = fill_user_images(usr)
    begin
      image_tag(usr.cover_image, class: 'cover-img', alt: 'Cover_Image', onerror: 'imgErrorCover(this);')
    rescue Sprockets::Rails::Helper::AssetNotFound
      image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/cover_default.jpg', class: 'cover-img', alt: 'Cover_Image')
    end
  end

  def link_user_img(usr)
    usr = fill_user_images(usr)
    begin
      link_to image_tag(usr.photo, class: 'rounded-circle who-photo mx-2 align-self-center', alt: usr.username, onerror: 'imgErrorPhoto(this);'), user_path(usr), class: 'align-self-center'
    rescue Sprockets::Rails::Helper::AssetNotFound
      link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/user_default.png', class: 'rounded-circle who-photo mx-2 align-self-center', alt: usr.username), user_path(usr), class: 'align-self-center'
    end
  end

  def user_photo(opi)
    opi.user = fill_user_images(opi.user)
    begin
      image_tag(opi.user.photo, class: 'timeline-photo', alt: 'User', onerror: 'imgErrorPhoto(this);')
    rescue Sprockets::Rails::Helper::AssetNotFound
      image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/user_default.png', class: 'timeline-photo', alt: 'User')
    end
  end

  def profile_photo(usr)
    usr = fill_user_images(usr)
    begin
      image_tag(usr.photo, class: 'profile-right p-2', alt: usr.username, onerror: 'imgErrorPhoto(this);')
    rescue Sprockets::Rails::Helper::AssetNotFound
      image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/user_default.png', class: 'profile-right p-2', alt: usr.username)
    end
  end

  def link_follow(current, usr)
    return link_to '+', follow_path(usr), class: 'textdec-none circle-link' unless current.follows.include?(usr) || current == usr
  end

  def link_unfollow(usr)
    return link_to '-', following_path(usr), method: :delete, class: 'textdec-none circle-link' if current_user.follows.include?(usr)
  end

  def class_follower_following(opt)
    opt ? "<div class='d-flex flex-column following'>" : "<div class='d-flex flex-column followed'>"
  end
end
