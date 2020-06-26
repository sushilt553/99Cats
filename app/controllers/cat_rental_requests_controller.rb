class CatRentalRequestsController < ApplicationController

    before_action :require_login
    before_action :require_cat_ownership!, only: [:approve, :deny]

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

    def approve
        current_cat_rental_request.approve!
        redirect_to cat_url(current_cat)
    end

    def deny
        current_cat_rental_request.deny!
        redirect_to(cat_url(current_cat))
    end

    private
    def cat_rental_request_params
        params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
    end

    def current_cat_rental_request
        CatRentalRequest.find_by(id: params[:id])
    end

    def require_cat_ownership!
        if !current_user.owns_cat?(current_cat)
            redirect_to cat_url(current_cat)
        end
    end

    def current_cat
        current_cat_rental_request.cat
    end
end
