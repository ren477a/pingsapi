
class DevicesController < ApplicationController
  def index
    devices = Device.pluck('device_id')
    render json: devices, status: :ok
  end
end