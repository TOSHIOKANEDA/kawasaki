module SlotsHelper
  def available_num(slot_id)
    bookings_num = Booking.where(slot_id: slot_id).length
    slot = Slot.find_by(id: slot_id)
    num = slot.max_num - bookings_num
  end

  def options_for_select_from_enum(klass,column)
    #該当クラスのEnum型リストをハッシュで取得
    enum_list = klass.send(column.to_s.pluralize)
    #Enum型のハッシュリストに対して、nameと日本語化文字列の配列を取得（valueは使わないため_)
    enum_list.map do | name , _value |
      # selectで使うための組み合わせ順は[ 表示値, value値 ]のため以下の通り設定
      [ t("enums.#{klass.to_s.downcase}.#{column}.#{name}") , name ]
    end
  end


end
