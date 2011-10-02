class InTheBeginning < ActiveRecord::Migration
  def up
    create_table :vibes do |t|
      t.integer :vibe_type
      t.integer :room_id
      t.timestamps
    end
    
    create_table :questions do |t|
      t.string :status
      t.integer :room_id
      t.string :content
      t.timestamps
    end
    
    create_table :rooms do |t|
      t.string :name
      t.string :status
      t.integer :vibe_threshold
      t.integer :question_threshold
      t.integer :teacher_id
      t.timestamps
      t.timestamp :ended_at
    end
    
    create_table :teachers do |t|
      t.string :email
    end
    
    create_table :votes do |t|
      t.string :vote_type
      t.integer :question_id
      t.timestamps
    end
  end

  def down
    [:vibes, :questions, :rooms, :teachers, :votes].each{|t| drop_table t}
  end
end
