class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :house, optional: true

  after_create :create_and_asign_house

  def create_and_asign_house
    self.house = House.create
  end
end
