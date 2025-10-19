class AddUserToRecipes < ActiveRecord::Migration[8.0]
  # Minimal models for backfill during migration
  class Recipe < ApplicationRecord; end
  class User   < ApplicationRecord; end

  def up
    # 1) Add the reference as NULLABLE so existing rows don't break
    add_reference :recipes, :user, null: true, foreign_key: true

    # 2) Backfill: pick an existing user (or create one) as owner
    owner = User.first || User.create!(
      email: "owner@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    Recipe.reset_column_information
    Recipe.where(user_id: nil).update_all(user_id: owner.id)

    # 3) Now enforce NOT NULL
    change_column_null :recipes, :user_id, false
  end

  def down
    remove_reference :recipes, :user, foreign_key: true
  end
end
