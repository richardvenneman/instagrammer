# frozen_string_literal: true

module Instagrammer::Utils
  def get_page_status
    if page.has_content?("Private")
      :private
    elsif page.has_content?("Sorry")
      :not_found
    elsif page.find(:json_ld, visible: false)
      :public
    end
  rescue Capybara::ElementNotFound
    :invalid
  end
end
