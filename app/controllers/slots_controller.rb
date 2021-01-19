class SlotsController < ApplicationController
  before_action :find_params, only: [:edit, :update]

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
    if @slot.update(slot_params)
      p "無事保存"
      redirect_to root_path
    else
      p "失敗"
      redirect_to new_slot_path
    end
  end

  def destroy
  end

  def edit
  end

  private

  def slot_params
    params.require(:slot).permit(:max_num, :date, :access_level, :power_switch, :full_status, :slot_purpose)
  end

  def find_params
    @slot = Slot.find(params[:id])
  end
end
