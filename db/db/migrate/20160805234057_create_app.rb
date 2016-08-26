class CreateApp < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :gender
    end

    create_table :clubs do |t|
      t.string :name
    end

    create_table :club_users do |t|
      t.belongs_to :club
      t.belongs_to :user
    end
  end
end
