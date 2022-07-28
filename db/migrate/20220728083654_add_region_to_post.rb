class AddRegionToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :region, :string
  end
end
