class SlotsController < ApplicationController
  include CommonActions
  before_action :authorized_user
  before_action :find_params, only: [:edit, :update, :destroy, :slot_booking]

  def index
    # ここはBookingが入っている分については、リストさせない方が良いwhereで制限を入れる
    @slots = Slot.all
  end

  def show
    if self.class.helpers.available_num(slot) - @slot.max_num == 0
      p "Bookingはありません"
      redirect_to new_slot_path
    end
  end

  def new
    @slot = Slot.new
    @slots = Slot.all
    @current_vol = 1
  end

  def create
    @slot = Slot.new(slot_params)
    if @slot.save
      p "無事保存"
      redirect_to new_slot_path
    else
      p "失敗"
      redirect_to new_slot_path
    end
  end

  def update
    if @slot.update(slot_params)
      p "無事保存"
      update_full_status(@slot.id)
      redirect_to new_slot_path
    else
      p "失敗"
      redirect_to root_path
    end
  end

  def destroy
    if @slot.destroy
      p "無事削除"
      redirect_to new_slot_path
    else
      p "失敗"
      redirect_to new_slot_path
    end
  end

  def edit
    @current_vol = Booking.where(slot_id: @slot.id).length
  end

  def power
    if params[:turn] == "off"
      Slot.update_all(power_switch: 1)
    elsif params[:turn] == "on"
      Slot.update_all(power_switch: 0)
    else
      p "失敗"
      redirect_to new_slot_path
    end
  end

  def update_date_all
    original_slots =  params[:slots].reject!{ |key, value| value == "0" }
    @slots = Slot.where(id: original_slots.keys).update_all(date: params[:to_date]) if original_slots.present?
    redirect_to slots_path
  end

  def copy
    original_slot = Slot.find(params[:id])
    @slot = original_slot.deep_clone
    @slot.save
    redirect_to new_slot_path if @slot.save
  end

  private

  def slot_params
    params.require(:slot).permit(:max_num, :date, :access_level, :power_switch, :full_status, :start_time, :end_time)
  end

  def find_params
    @slot = Slot.find(params[:id])
  end
end
