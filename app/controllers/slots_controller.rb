class SlotsController < ApplicationController
  def index
  end

  def new
    @slot = Slot.new
    @slots = Slot.all
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
  end

  def show
  end

  def destroy
  end

  private

  def slot_params
    params.require(:slot).permit(:max_num, :date, :access_level, :power_switch, :full_status, :slot_purpose)
  end
end
