class Message < ApplicationRecord
  has_one :lead_data, inverse_of: :message, dependent: :destroy
  mount_uploader :email, EmailUploader
end
