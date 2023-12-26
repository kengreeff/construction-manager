class ClientsProject < ApplicationRecord
  belongs_to :client
  belongs_to :project
end
