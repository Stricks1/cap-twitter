module OpinionsHelper
  def right_title
    current_user ? 'WHO TO FOLLOW' : 'WHO IS HERE'
  end

  def center_title
    current_user ? 'Followeds Opinions' : 'All Opinions'
  end

  def linked_unlinked_comment(opi)
    opi.user = fill_user_images(opi.user)
    if current_user
      begin
        link_to image_tag(opi.user.photo, class: 'timeline-photo', alt: opi.user.username, onerror: 'imgErrorPhoto(this);'), user_path(opi.user)
      rescue Sprockets::Rails::Helper::AssetNotFound
        link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/user_default.png', class: 'timeline-photo', alt: opi.user.username), user_path(opi.user)
      end
    else
      begin
        image_tag(opi.user.photo, class: 'timeline-photo', alt: opi.user.username, onerror: 'imgErrorPhoto(this);')
      rescue Sprockets::Rails::Helper::AssetNotFound
        image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/user_default.png', class: 'timeline-photo', alt: opi.user.username)
      end
    end
  end

  def linked_unlinked_who(usr)
    usr = fill_user_images(usr)
    if current_user
      begin
        link_to image_tag(usr.photo, class: 'rounded-circle who-photo mx-2 align-self-center', alt: usr.username, onerror: 'imgErrorPhoto(this);'), user_path(usr), class: 'align-self-center'
      rescue Sprockets::Rails::Helper::AssetNotFound
        link_to image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/user_default.png', class: 'rounded-circle who-photo mx-2 align-self-center', alt: usr.username), user_path(usr), class: 'align-self-center'
      end
    else
      begin
        image_tag(usr.photo, class: 'rounded-circle who-photo mx-2 align-self-center', alt: usr.username, onerror: 'imgErrorPhoto(this);')
      rescue Sprockets::Rails::Helper::AssetNotFound
        image_tag('https://raw.githubusercontent.com/Stricks1/cap-twitter/feature/app/assets/images/user_default.png', class: 'rounded-circle who-photo mx-2 align-self-center', alt: usr.username)
      end
    end
  end

  def edit_destroy_retweet(opi)
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

  def copied_info(opi)
    return nil unless opi.copied

    edited = opi.created_at != opi.updated_at
    info = edited ? 'Edited opinion copied from @' : 'Opinion copied from @'
    info.concat(opi.copied.username)
    current_user ? (link_to info, user_path(opi.copied)) : info
  end

  def op_btn_follow(usr)
    return nil unless current_user

    link_to '+', follow_path(usr), class: 'textdec-none circle-link'
  end

  def form_edit_info(opinion)
    return unless current_user == opinion.user

    cntnt = "<div class='bg-white w-75 border rounded-border p-3 my-4 color-light-grey'>"
    cntnt.concat("<p class='font-weight-bold'>CORRECT YOUR OPINION</p>")
    cntnt.concat(form_with(model: opinion, local: true, html: { method: 'patch' }))
    form_with(model: opinion, local: true) do |form|
      cntnt.concat((form.text_area :text, class: 'form-text', placeholder: 'Give your opinion...', autofocus: true))
      opinion.errors.messages[:text].each do |message|
        cntnt.concat("<div class='error-sm'>")
        cntnt.concat(message)
        cntnt.concat('</div>')
      end
      cntnt.concat("<div class='actions mt-4'>")
      cntnt.concat((form.submit 'Edit Opinion', class: 'form-btn'))
      cntnt.concat('</div>')
    end
    cntnt.concat('</div>')
    cntnt.html_safe
  end

  def form_opinion(opinion)
    return unless current_user

    cntnt = "<div class='bg-white w-75 border rounded-border p-3 my-4 color-light-grey'><p class='font-weight-bold'>WRITE ABOUT A MOVIE</p>"
    cntnt.concat(form_with(model: opinion, local: true))
    form_with(model: opinion, local: true) do |form|
      cntnt.concat((form.text_area :text, class: 'form-text', placeholder: 'Give your opinion...', autofocus: true))
      opinion.errors.messages[:text].each do |message|
        cntnt.concat("<div class='error-sm'>")
        cntnt.concat(message)
        cntnt.concat('</div>')
      end
      cntnt.concat("<div class='actions mt-4'>")
      cntnt.concat((form.submit 'Send Opinion', class: 'form-btn'))
      cntnt.concat('</div>')
    end
    cntnt.concat('</div>')
    cntnt.html_safe
  end
end
