class AddActiveToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :active, :boolean, default: true
  end
end
