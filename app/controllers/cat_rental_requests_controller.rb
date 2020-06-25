class CatRentalRequestsController < ApplicationController

    def new
        @cats = Cat.all
        render :new
    end

    def create
        
    end

    private
    def cat_rental_request_params
    end
end
