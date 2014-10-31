class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name_first
      t.string :name_last
      t.datetime :birth_dt_tm

      t.timestamps
    end
  end
end
