class Type < ApplicationRecord
  belongs_to :brand
  has_many :actions
  has_many :devices
end
