class Patient < ApplicationRecord
    has_one_attached :imagen
    has_one_base64_attached :avatar
end
