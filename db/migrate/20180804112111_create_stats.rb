class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.jsonb :words, default: '{}'

      t.timestamps
    end
  end
end
