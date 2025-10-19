class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  load_and_authorize_resource except: [:index, :show]

  before_action :set_recipe, only: [:show]

  def index
    @recipes = Recipe.includes(:user).order(created_at: :desc)
  end

  def show; end

  def new
  end

  def create
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe, notice: "Recipe created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "Recipe deleted."
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:title, :cook_time, :difficulty, :instructions)
    end
end
