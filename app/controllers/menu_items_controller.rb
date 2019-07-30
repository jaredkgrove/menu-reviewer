class MenuItemsController < ApplicationController
  # get "/:restaurant_slug/menu_items" do
  #   @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
  #   @menu_items = @restaurant.menu_items
  #   if Helpers.logged_in?(session)
  #     erb :"menu_items/menu_items"
  #   else
  #     redirect to "/login"
  #   end
  # end

  # get "/menu_items/new" do
  #   if Helpers.logged_in?(session)
  #     erb :"menu_items/new"
  #   else
  #     redirect to "/login"
  #   end
  # end

  get "/menu_items/:id" do
    if Helpers.logged_in?(session)
      @menu_item = MenuItem.find_by_slug(params[:id])
      @restaurant = @menu_item.restaurant
      erb :"menu_items/show_menu_item"
    else
      redirect to "/login"
    end
  end

  # get "/menu_items/:id/edit" do
  #   @menu_item = MenuItem.find(params[:id])
  #   if !Helpers.logged_in?(session)
  #     redirect to "/login"
  #   elsif !!@menu_items && Helpers.logged_in?(session) && @menu_items.user == Helpers.current_user(session)
  #     erb :"tweets/edit_tweet"
  #   elsif !!@tweet
  #     redirect to "/tweets/#{@tweet.id}"
  #   else
  #     redirect to "/tweets"
  #   end
  # end

end
