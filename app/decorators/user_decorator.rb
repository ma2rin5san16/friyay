class UserDecorator < ApplicationDecorator
  delegate_all

  def generate
    if Time.now.year - object.birthday.year < 20
      10
    elsif 20 <= Time.now.year - object.birthday.year && Time.now.year - object.birthday.year < 30
      20
    elsif 30 <= Time.now.year - object.birthday.year && Time.now.year - object.birthday.year < 40
      30
    elsif 40 <= Time.now.year - object.birthday.year && Time.now.year - object.birthday.year < 50
      40
    elsif 50 <= Time.now.year - object.birthday.year && Time.now.year - object.birthday.year < 60
      50
    elsif Time.now.year - object.birthday.year >= 60
      60
    end
  end

end
