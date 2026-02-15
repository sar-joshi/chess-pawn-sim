class CreatePawnGames < ActiveRecord::Migration[8.1]
  def change
    create_table :pawn_games do |t|
      t.integer :xpos
      t.integer :ypos
      t.string :facing
      t.string :colour
      t.text :history

      t.timestamps
    end
  end
end
