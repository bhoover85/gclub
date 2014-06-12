class ChangePricesToString < ActiveRecord::Migration
  def change
    change_column :games, :list_price, :string
    change_column :games, :lowest_price, :string
    change_column :games, :savings, :string
  end
end
