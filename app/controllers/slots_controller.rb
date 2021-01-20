class SlotsController < ApplicationController
  before_action :find_params, only: [:edit, :update, :destroy]

  def index
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
      redirect_to root_path
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
      redirect_to root_path
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
      redirect_to root_path
    end
  end

  private

  def slot_params
    params.require(:slot).permit(:max_num, :date, :access_level, :power_switch, :full_status, :slot_purpose)
  end

  def find_params
    @slot = Slot.find(params[:id])
  end
end
