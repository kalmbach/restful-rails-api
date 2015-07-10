class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name, null: false, index: true
      t.string :description
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
