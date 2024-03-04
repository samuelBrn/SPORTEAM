class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :categorie, null: false, foreign_key: true
      t.string :name
      t.string :adress
      t.datetime :start_at
      t.datetime :end_at
      t.string :status
      t.integer :max_player
      t.integer :min_player
      t.text :description

      t.timestamps
    end
  end
end
