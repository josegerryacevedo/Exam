class AddColumnToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :short_url, :string
  end
end
