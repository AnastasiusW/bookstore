class HomePage < SitePrism::Page
  element :flash_success, '#flash_success_id'

  def flash_success_message
    flash_success.text
  end
end
