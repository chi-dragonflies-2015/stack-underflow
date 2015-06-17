class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :voted, polymorphic: true, index: true

      t.timestamps
    end
  end
end
