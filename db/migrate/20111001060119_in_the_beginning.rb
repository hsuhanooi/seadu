class InTheBeginning < ActiveRecord::Migration
  def up
    create_table :vibe do |t|
      t.integer :type_key
      t.integer :room_id
      t.timestamps
    end
    
    create_table :questions do |t|
      t.integer :status_key
      t.integer :room_id
      t.string :content
      t.timestamps
    end
    
    create_table :rooms do |t|
      t.string :name
      t.integer :mood_threshold
      t.integer :question_threshold
      t.integer :teacher_id
      t.timestamps
    end
    
    create_table :teachers do |t|
      t.string :email
    end
    
    create_table :votes do |t|
      t.integer :type_key
      t.integer :question_id
      t.timestamps
    end
  end

  def down
    [:vibe, :question, :rooms, :teachers, :votes].each{|t| drop_table t}
  end
end
