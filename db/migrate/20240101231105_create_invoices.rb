class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :quote, null: true, foreign_key: true
      t.belongs_to :supplier, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.string :reference
      t.text :description
      t.decimal :total, :precision => 8, :scale => 2
      
      t.datetime :issue_date
      t.datetime :due_date

      t.bigint :paid_by_user_id
      t.datetime :paid_at

      t.timestamps
    end
  end
end
