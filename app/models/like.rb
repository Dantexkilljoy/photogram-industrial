class Like < ApplicationRecord
  belongs_to :fan, class_name: "User", foreign_key: "fan_id", counter_cache: true
  belongs_to :photo, counter_cache: true
end
