class ReviewsController < ApplicationController

    get "/:restaurant_slug/menu_items/:menu_item_id/reviews/new" do
      if Helpers.logged_in?(session)
        @menu_item = MenuItem.find(params[:menu_item_id])
        @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
        redirect to "/#{@menu_item.restaurant.slug}/menu_items/#{@menu_item.id}" if !@restaurant.menu_items.include?(@menu_item)
        erb :"reviews/new"
      else
        redirect to "/login"
      end
    end

    get "/:restaurant_slug/menu_items/:menu_item_id/reviews/:id" do
      @review = Review.find(params[:id])
      @menu_item = MenuItem.find(params[:menu_item_id])
      @user = @review.user
      @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
      # binding.pry
      redirect to "/#{@review.menu_item.restaurant.slug}/menu_items/#{@review.menu_item.id}/reviews/#{@review.id}" if !(@review.menu_item == @menu_item && @restaurant.menu_items.include?(@menu_item))
      erb :"reviews/show_review"
    end

    get "/:restaurant_slug/menu_items/:menu_item_id/reviews/:id/edit" do
      @review = Review.find(params[:id])
      redirect_if_not_owner(@review)
      @menu_item = MenuItem.find(params[:menu_item_id])
      @user = @review.user
      @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
      redirect to "/#{@review.menu_item.restaurant.slug}/menu_items/#{@review.menu_item.id}/reviews/#{@review.id}" if !(@review.menu_item == @menu_item && @restaurant.menu_items.include?(@menu_item))
      #could this create infinite loop?
      if !Helpers.logged_in?(session)
        redirect to "/login"
      else
        erb :"reviews/edit_review"
      end
    end

    post "/:restaurant_slug/menu_items/:menu_item_id/reviews" do
      review = Review.new(rating: params[:rating], comment: params[:comment], user: Helpers.current_user(session), menu_item_id: params[:menu_item_id] )
      if review.save
        redirect to "/#{params[:restaurant_slug]}/menu_items/#{params[:menu_item_id]}/reviews/#{review.id}"
      else
        redirect to "/#{params[:restaurant_slug]}/menu_items/#{params[:menu_item_id]}?error=There was a problem creating the review"
      end
    end

    patch "/:restaurant_slug/menu_items/:menu_item_id/reviews/:id" do
      @review = Review.find(params[:id])
      redirect_if_not_owner(@review)
      if !Helpers.logged_in?(session) || params[:rating].empty?
        redirect to "/#{@review.menu_item.restaurant.slug}/menu_items/#{@review.menu_item.id}/reviews/#{@review.id}/edit?error=There was a problem updating the review"
      else
        @review.update(rating: params[:rating], comment:params[:comment]) #Check params hash to include rating, comment, menu_item, and ???restaurant???
        @review.save
<<<<<<< HEAD
        redirect to "/#{@review.menu_item.restaurant.slug}/menu_items/#{@review.menu_item.id}/reviews/#{@review.id}"
=======
          redirect to "/#{@review.menu_item.restaurant.slug}/menu_items/#{@review.menu_item.id}/reviews/#{@review.id}"
      else
          redirect to "/#{@review.menu_item.restaurant.slug}/menu_items/#{@review.menu_item.id}/reviews/#{@review.id}/edit?error=There was a problem updating the review"
>>>>>>> b9eb60e5cd3be8635e182cac95e6570c80ab2c9a
      end
    end

    delete "/:restaurant_slug/menu_items/:menu_item_id/reviews/:id" do
      Review.find(params[:id]).destroy if Helpers.logged_in?(session) && Review.find(params[:id]).user == Helpers.current_user(session)
      redirect to "/#{params[:restaurant_slug]}/menu_items/#{params[:menu_item_id]}"
    end

end
