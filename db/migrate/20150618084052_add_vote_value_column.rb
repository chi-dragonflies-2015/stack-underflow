class AddVoteValueColumn < ActiveRecord::Migration
  def change
    add_column :votes, :value, :integer
  end
end
