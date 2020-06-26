class CatsController < ApplicationController

    before_action :require_login, only: [:new, :create, :edit, :update]

    def index
        @cats = Cat.all
        render :index
    end

    def show
        @cat = Cat.find_by(id: params[:id])
        @rental_requests = @cat.cat_rental_requests.order(:start_date)

        if @cat
            render :show
        else
            render json: "Cat not found"
        end
    end

    def new
        @cat = Cat.new
        render :new
    end

    def create
        @cat = Cat.new(cat_params)
        # @cat.user_id = current_user.id
        @cat.owner = current_user

        if @cat.save
            redirect_to cats_url
        else
            flash.now[:errors] = @cat.errors.full_messages
            render :new
        end
    end

    def edit
        @cat = current_user.cats.find(id: params[:id])
        
        render :edit
    end

    def update
        @cat = current_user.cats.find(id: params[:id])

        if @cat.update_attributes(cat_params)
            redirect_to cat_url(@cat)
        else
            flash.now[:errors] = @cat.errors.full_messages
            render :edit
        end
    end

    private

    def cat_params
        params.require(:cat).permit(:name, :color, :sex, :birth_date, :description)
    end
end
