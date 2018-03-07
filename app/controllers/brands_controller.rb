class BrandsController < ApplicationController
  def index
    Brand.all
  end
end
