module ApplicationHelper
  def header_bar
    cntnt = "<img src='https://www.bh-bims.org/wp-content/uploads/2017/12/twitter-icon-white.png'"
    cntnt.concat("class='logo'><div class='align-self-center px-4'>")
    if current_user 
      cntnt.concat(logged_btn)
    else
      cntnt.concat(to_log_btn)
    end
    cntnt.concat('</div>')
    cntnt.html_safe
  end

  def to_log_btn
    ret = ""
    ret.concat(link_to "Sign Up", signup_path, class: 'color-grey')
    ret.concat(" ")
    ret.concat(link_to "Log In", login_path, class: 'color-grey')
  end

  def logged_btn
    ret = ""
    ret.concat(link_to image_tag('https://image.flaticon.com/icons/svg/598/598234.svg', border: 0, class: 'logo-sm'), edit_user_path(current_user))
    ret.concat(" ")
    ret.concat(link_to "Log Out", logout_path, class: 'color-grey')
  end
end
