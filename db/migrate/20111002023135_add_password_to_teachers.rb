class AddPasswordToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :password_hash, :string
    add_column :teachers, :password_salt, :string
  end
end
