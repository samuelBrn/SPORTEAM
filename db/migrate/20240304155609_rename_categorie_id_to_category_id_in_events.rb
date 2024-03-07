class RenameCategorieIdToCategoryIdInEvents < ActiveRecord::Migration[6.0]
  def change
    rename_column :events, :categorie_id, :category_id
  end
end
