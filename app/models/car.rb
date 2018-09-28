class Car < ApplicationRecord
  has_many :car_photos
  accepts_nested_attributes_for :car_photos
  def load_structure
    result = {
      id: id,
      bien_so: bien_so,
      anh: hehe
    }
    result
  end

  def hehe
    arr = []
    self.car_photos.each do |a|
      arr.push ({
        id: a.id,
        url: a.anh.url
      })
    end
    return arr
  end
end
