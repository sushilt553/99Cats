class CatRentalRequestsController < ApplicationController

    def new
        @cats = Cat.all
        render :new
    end

    def create
        @cats = Cat.all
        @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)

        if @cat_rental_request.save
            redirect_to cat_url(@cat_rental_request.cat)
        else
            flash.now[:errors] = @cat_rental_request.errors.full_messages
            render :new
        end
    end

    private
    def cat_rental_request_params
        params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
    end
end
