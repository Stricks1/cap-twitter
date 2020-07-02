module OpinionsHelper
  def right_title
    if current_user
      cntnt = 'WHO TO FOLLOW'
    else 
      cntnt = 'WHO IS HERE'
    end
  end
end
