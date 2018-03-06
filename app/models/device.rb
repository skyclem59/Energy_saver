class Device < ApplicationRecord
  belongs_to :type
  belongs_to :house
end
