class CreatePictures < ActiveRecord::Migration[5.1]

  create_table :users do |t|
    t.string :id
  end

  create_table :comments do |t|
    t.string :id
  end

  def change
    create_table :pictures do |t|
      t.string :image
      t.belongs_to :user
      t.has_many :pictures
      t.timestamps
    end
  end
end
