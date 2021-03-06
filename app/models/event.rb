class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  # include Mongoid::MultiParameterAttributes
  include Mongoid::Paperclip

  has_many :arts

  slug :name

  field :name
  field :description
  field :website
  field :starts_at, type: DateTime
  field :ends_at, type: DateTime

  has_mongoid_attached_file :icon, 
    :styles => {
      :thumbnail => "30x30", 
      :thumbnail_retina => "60x60", 
      :small => "100x100"
    }, 
    :path => ':rails_root/public/system/events/:attachment/:id/:style.:extension',
    :url => '/system/events/:attachment/:id/:style.:extension'


  index(slug: 1)

  validates_presence_of :name
  validates_presence_of :starts_at
  validates_presence_of :ends_at
  validates_uniqueness_of :slug

  scope :current, -> { where :ends_at.gte => Date.today }
end
