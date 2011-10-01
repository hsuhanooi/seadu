class MakeVibeTypeString < ActiveRecord::Migration
  def up
    change_column :vibes, :vibe_type, :string
  end

  def down
    change_column :vibes, :vibe_type, :integer
  end
end
