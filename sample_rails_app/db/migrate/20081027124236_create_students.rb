class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.column :name         , :string
      t.column :gpa          , :float
      t.column :enrolled     , :datetime
      t.column :graduated    , :date
      t.column :first_class  , :time
      t.column :life_story   , :text
      #t.column this         , :binary
      t.column :greek        , :boolean
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tests
  end
end
