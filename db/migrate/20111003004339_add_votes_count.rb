class AddVotesCount < ActiveRecord::Migration
  def up
    add_column(:questions, :votes_count, :integer)
  end

  def down
    remove_column(:questions, :votes_count)
  end
end
