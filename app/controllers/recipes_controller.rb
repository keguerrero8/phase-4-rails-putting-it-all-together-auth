class RecipesController < ApplicationController
    def index
        user = User.find_by(id: session[:user_id])
        if user
            render json: Recipe.all, status: 201
        else
            render json: {errors: ["No user logged in"]}, status: 401
        end
    end

    def create
        user = User.find_by(id: session[:user_id])
        if user
            recipe = user.recipes.create(recipe_params)
            if recipe.valid?
                render json: recipe, status: 201
            else
                render json: {errors: ["Invalid data"]}, status: 422
            end 
        else
            render json: {errors: ["No user logged in"]}, status: 401
        end      
    end

    private
    
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
