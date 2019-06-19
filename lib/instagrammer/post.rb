# frozen_string_literal: true

class Instagrammer::Post
  include Capybara::DSL

  def initialize(shortcode)
    @shortcode = shortcode
    visit_page
  end

  def inspect
    attributes = %i(image_url image_urls caption upload_date comment_count like_count)
    "#<#{self.class.name}:#{object_id} #{attributes.map { |attr| "#{attr}:#{send(attr).inspect}" }.join(", ")}>"
  end

  IMAGE_URLS_RE = /(\S+) (\d+)w/
  def image_urls
    @image["srcset"].scan(IMAGE_URLS_RE).collect do |match|
      {
        url: match[0],
        width: match[1].to_i
      }
    end
  end

  def image_url
    @image["src"]
  end

  def user
    Instagrammer::User.new @data["author"]["alternateName"]
  end

  def caption
    @data["caption"]
  end

  def upload_date
    DateTime.parse @data["uploadDate"]
  end

  def comment_count
    @data["commentCount"].to_i
  end

  def like_count
    @data["interactionStatistic"]["userInteractionCount"].to_i
  end

  private
    def visit_page
      visit "https://www.instagram.com/p/#{@shortcode}/"
      check_status

      @data = JSON.parse(page.first(:json_ld, visible: false).text(:all))
      @image = page.first(:image)
    end

    def check_status
      if page.has_content?("Private")
        raise Instagrammer::PrivatePost.new("Private post: #{@shortcode}")
      elsif page.has_content?("Sorry")
        raise Instagrammer::PostNotFound.new("Post not found: #{@shortcode}")
      end
    end
end
