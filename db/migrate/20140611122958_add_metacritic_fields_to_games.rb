class AddMetacriticFieldsToGames < ActiveRecord::Migration
  def change
    add_column :games, :rlsdate, :date
    add_column :games, :developer, :string
    add_column :games, :publisher, :string
    add_column :games, :score, :integer
  end
end
