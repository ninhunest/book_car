class Role < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}

  def load_structure
    result = {
      id: id,
      name: name
    }
    result
  end
end
