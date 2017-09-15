# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  longitude  :string
#  latitude   :string
#  user_id    :integer
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ApplicationRecord
  belongs_to :user, :optional => true
end
