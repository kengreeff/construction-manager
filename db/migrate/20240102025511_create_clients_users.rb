class CreateClientsUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :clients_users do |t|
      t.belongs_to :client
      t.belongs_to :user

      t.timestamps
    end
  end
end
