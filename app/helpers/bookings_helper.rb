module BookingsHelper

  def normal
    Slot.where(full_status: 0).where(power_switch: 0).where(access_level: 0).order(date: "ASC", start_time: "ASC").map{|o| [[o.date.strftime("%Y年%m月%d日")+"の", o.start_time+"から", o.end_time+"まで"].join(""), o.id]}
  end

  def vip
    Slot.where(full_status: 0).where(power_switch: 0).where(access_level: 1).order(date: "ASC", start_time: "ASC").map{|o| [[o.date.strftime("%Y年%m月%d日")+"の", o.start_time+"から", o.end_time+"まで"].join(""), o.id]}
  end

  def dr
    Slot.where(full_status: 0).where(power_switch: 0).where(access_level: 2).order(date: "ASC", start_time: "ASC").map{|o| [[o.date.strftime("%Y年%m月%d日")+"の", o.start_time+"から", o.end_time+"まで"].join(""), o.id]}
  end

end
