# == Schema Information
#
# Table name: searches
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  text              :text
#  screen_name       :text
#  profile_image_url :text
#  updated_at        :datetime         not null
#

class Search < ApplicationRecord
end
