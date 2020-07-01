module ApplicationHelper
  def header_bar
    cntnt = "<img src='https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/twitter-icon-white.png'"
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
    ret.concat(link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/b3ee28c00f9504f9995a544ad14f2440b83f40a0/app/assets/images/pencil.svg', border: 0, class: 'logo-sm'), edit_user_path(current_user))
    ret.concat(" ")
    ret.concat(link_to "Log Out", logout_path, class: 'color-grey')
  end
end
