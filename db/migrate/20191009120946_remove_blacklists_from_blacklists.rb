class RemoveBlacklistsFromBlacklists < ActiveRecord::Migration[6.0]
  def change

    remove_column :blacklists, :blacklists, :string
  end
end
