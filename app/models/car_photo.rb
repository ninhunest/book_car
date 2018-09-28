class CarPhoto < ApplicationRecord
  mount_uploader :anh, AnhUploader
  belongs_to :car
end
