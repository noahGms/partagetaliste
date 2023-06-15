class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true
      t.string :user_name

      t.timestamps
    end
  end
end
