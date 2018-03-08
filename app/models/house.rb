class House < ApplicationRecord
  has_many :users
  has_many :devices
end
