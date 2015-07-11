class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|

    	t.string :facebookID
    	t.string :facebookHASH
    	t.string :fullName
    	t.string :gender

      t.timestamps null: false
    end
  end
end
