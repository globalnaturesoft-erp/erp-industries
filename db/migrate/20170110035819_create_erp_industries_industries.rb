class CreateErpIndustriesIndustries < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_industries_industries do |t|
      t.string :name
      t.text :description
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
