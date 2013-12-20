class Location < ActiveRecord::Base
  # name: string, street_address: string, secondary_address: string, city: string, region: string,
  # postal_code: string, country: string, instructions: text, map: string, url: string, parent_location_id:  integer
  # locateable_id: integer, locateable_type: string, slug: string
  extend PersistedExtension
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :locateable, polymorphic: true
  has_one :parent, class_name: Location, primary_key: :parent_location_id, foreign_key: :id
  has_many :children, class_name: Location, primary_key: :id, foreign_key: :parent_location_id
  validates :name, presence: true
  biggs :address,
        recipient:      :name,
        street:         [:street_address, :secondary_address],
        city:           :city,
        state:          :region,
        zip:            :postal_code,
        country:        :country


  def duplicate_for_event(event_id)
    # duplicates the original location
    new_location = self.dup
    # sets parent_location_id equal to the original
    new_location.parent_location_id = self.id
    # sets the event location to the newly duplicated event
    event = Event.friendly.find(event_id)
    event.location = new_location
    # returns the new location
    new_location
  end
end
