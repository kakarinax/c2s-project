class Message < ApplicationRecord
  mount_uploader :email, EmailUploader
end
