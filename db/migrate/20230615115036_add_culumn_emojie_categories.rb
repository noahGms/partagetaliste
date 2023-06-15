class AddCulumnEmojieCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :emojie, :string
  end
end
