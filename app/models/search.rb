# == Schema Information
#
# Table name: searches
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  text              :text
#  screen_name       :text
#  profile_image_url :text
#  address           :text
#  latitude          :text
#  longitude         :text
#  updated_at        :datetime         not null
#

class Search < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
end
