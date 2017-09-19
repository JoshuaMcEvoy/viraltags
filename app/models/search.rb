# == Schema Information
#
# Table name: searches
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  text              :text
#  screen_name       :text
#  profile_image_url :text
#  lat               :text
#  lng               :text
#  updated_at        :datetime         not null
#

class Search < ApplicationRecord
  def seconds_since_midnight
    self.created_at - self.created_at.change(:hour => 0)
  end

  def minutes_since_midnight
    self.seconds_since_midnight / 60
  end
end
