class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.text :description
      t.boolean :publish

      t.timestamps
    end
  end
end
