class CatalogItem < ActiveRecord::Base

  attr_accessor :upload_url

  has_attached_file :feature_image,
    styles: {
      large: '720x432#'
    },
    convert_options: {
      large: '-quality 80 -strip'
    }

  before_save :get_remote_image

  validates_presence_of :creator,
                        :name,
                        :description,
                        :url,
                        :released_at
  validates_attachment :feature_image, content_type: { content_type: /image/ }

  belongs_to :catalog_category

  private

  def get_remote_image
    if upload_url.present?
      io = open(URI.parse(upload_url))
      self.feature_image = io
    end
  end

end
