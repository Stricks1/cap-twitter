module ApplicationHelper
  def header_bar
    cntnt = "<a href='/opinions'>"
    cntnt.concat("<img src='https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/clapperboardWhite.png'")
    cntnt.concat("alt='clapperboard' class='logo'><div class='align-self-center px-2 d-flex justify-content-between'></a>")
    if current_user
      cntnt.concat(logged_btn)
    else
      cntnt.concat(to_log_btn)
    end
    cntnt.concat('</div>')
    cntnt.html_safe
  end

  def to_log_btn
    ret = ''
    ret.concat((link_to 'Sign Up', signup_path, class: 'color-grey align-self-center px-2 flex-nowrap'))
    ret.concat(' ')
    ret.concat((link_to 'Login', login_path, class: 'color-grey align-self-center px-2 flex-nowrap'))
  end

  def logged_btn
    ret = ''
    ret.concat((link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/b3ee28c00f9504f9995a544ad14f2440b83f40a0/app/assets/images/pencil.svg', class: 'logo-sm', alt: 'edit'), edit_user_path(current_user)))
    ret.concat(' ')
    ret.concat((link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/23f63c21dad717cb072411ac3a3c1c338891995a/app/assets/images/mail.svg', class: 'logo-sm', alt: 'email')))
    ret.concat(' ')
    ret.concat((link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/23f63c21dad717cb072411ac3a3c1c338891995a/app/assets/images/search.svg', class: 'logo-sm', alt: 'search')))
    ret.concat(' ')
    ret.concat((link_to 'Logout', logout_path, class: 'color-grey align-self-center px-2 flex-nowrap'))
  end

  def flash_info
    if notice
      ret = "<div><span id='notice' class='text-center d-block py-2'>"
      ret.concat(notice + '</span></div>')
      ret.concat("<div class='bg-main-grey d-flex row h-100-flash justify-content-center'>")
    elsif alert
      ret = "<div><span id='alert' class='text-center d-block py-2'>"
      ret.concat(alert + '</span></div>')
      ret.concat("<div class='bg-main-grey d-flex row h-100-flash justify-content-center'>")
    else
      ret = "<div class='bg-main-grey d-flex row h-100 justify-content-center'>"
    end
    ret.html_safe
  end

  def current_profile(usr)
    usr = fill_user_images(usr)
    begin
      image_tag(usr.photo, class: 'profile p-2', alt: usr.username, onerror: 'imgErrorPhoto(this);')
    rescue Sprockets::Rails::Helper::AssetNotFound
      image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/user_default.png', class: 'profile p-2', alt: usr.username)
    end
  end

  def fill_user_images(usr)
    usr.photo = 'https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/user_default.png' if usr.photo.blank?
    usr.cover_image = 'https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/cover_default.jpg' if usr.cover_image.blank?
    usr
  end

  def user_info(usr)
    cntnt = if usr
              user_info_logged(usr)
            else
              "<div class='col-12 d-flex flex-column min-vh-100'>"
            end
    cntnt.html_safe
  end

  def user_info_logged(usr)
    cntnt = "<div class='bg-left-bt-tab col-4 col-md-3'><div class='d-flex flex-column'><div class='d-flex bg-left-tab'>"
    cntnt.concat(current_profile(usr))
    cntnt.concat("<span class='align-self-center bold-name'>")
    cntnt.concat(usr.full_name)
    cntnt.concat("</span></div><div class='d-flex justify-content-between bg-left-tab'><div class='w-50 border-dark-bl-1 py-2'><span class='text-center d-block light-color'>")
    cntnt.concat(usr.followers.count.to_s)
    cntnt.concat("</span><span class='text-center d-block bold-flw'>Following</span></div><div class='w-50 border-dark-bl-2 py-2'><span class='text-center d-block light-color'>")
    cntnt.concat(usr.followeds.count.to_s)
    cntnt.concat("</span><span class='text-center d-block bold-flw'>Followers</span></div></div><div><a href='")
    cntnt.concat(opinions_path)
    cntnt.concat("' class='d-block left-links d-flex p-4'><i class='fa fa-ticket logo-left px-2' aria-hidden='true'></i><span class='left-bold-txt'>home</span></a><a href='#' class='d-block left-links d-flex p-4'><i class='fa fa-at logo-left px-2' aria-hidden='true'></i>")
    cntnt.concat("<span class='left-bold-txt'>connect</span></a><a href='#' class='d-block left-links d-flex p-4'><i class='fa fa-hashtag logo-left px-2' aria-hidden='true'></i><span class='left-bold-txt'>discover</span></a><a href='")
    cntnt.concat(user_path(usr))
    cntnt.concat("' class='d-block left-links d-flex p-4'><i class='fa fa-user logo-left px-2' aria-hidden='true'></i><span class='left-bold-txt'>profile</span></a>")
    cntnt.concat("<a href='#' class='d-block left-links d-flex p-4'>")
    cntnt.concat("<i class='fa fa-pie-chart logo-left px-2' aria-hidden='true'></i>")
    cntnt.concat("<span class='left-bold-txt'>statistics</span></a></div></div></div><div class='col-8 col-md-9 d-flex flex-column min-vh-100'>")
  end
end
