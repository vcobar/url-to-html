class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :url
      t.text :html
      t.integer :server_code
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
