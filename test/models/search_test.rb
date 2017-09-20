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

require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
