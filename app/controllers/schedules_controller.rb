class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def index
    # 並び順を明示的にした方がよい。開始日が古い順にする例
    @schedules = Schedule.order(:start_date)
  end

  def show
    # 特に不要（set_scheduleで済む）
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to @schedule, notice: 'スケジュールを作成しました。'
    else
      # render時もステータスコード422を返すとREST的
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # 特に不要（set_scheduleで済む）
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to @schedule, notice: 'スケジュールを更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy
    redirect_to schedules_url, notice: 'スケジュールを削除しました。'
  end

  private

  def set_schedule
    # エラー時のハンドリングも親切
    @schedule = Schedule.find_by(id: params[:id])
    redirect_to schedules_url, alert: '指定したスケジュールが見つかりません。' unless @schedule
  end

  def schedule_params
    # strong parameters
    params.require(:schedule).permit(:title, :start_date, :end_date, :all_day, :memo)
  end
end

