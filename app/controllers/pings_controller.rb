
class PingsController < ApplicationController
  def index
    pings = Device.joins(:pings).select('devices.device_id, pings.epoch_time')
    render json: pings, status: :ok
  end

  def create
    id = Device.where(device_id: params[:device_id]).pluck('id')
    # Expect unix timestamp
    date = Time.at(params[:date].to_i).to_datetime
    if id.size==0
      device = Device.create({
        device_id: params[:device_id]
      })
    else
      device = Device.find(id).first
    end
    ping = device.pings.create({
      epoch_time: date
    })
    render json: ping
  end

  def bydate
    id = Device.where(device_id: params[:device_id])
    date = DateTime.strptime(params[:date], '%Y-%m-%d')
    pings = Ping.where(epoch_time: date.all_day, device_id: id).pluck('epoch_time')
    # Convert to Unix Timestamp
    pings.map! { |ping| ping.to_i }
    render json: pings
  end
    
  def fromto
    id = Device.where(device_id: params[:device_id])
    # May accept Unix Timestamps or ISODates
    if (params[:from] =~ /\d{4}-\d{2}-\d{2}/)
      from = DateTime.strptime(params[:from], '%Y-%m-%d')
    elsif params[:from] =~ /\d{10}/
      from = Time.at(params[:from].to_i).to_datetime
    end

    if (params[:to] =~ /\d{4}-\d{2}-\d{2}/)
      to = DateTime.strptime(params[:to], '%Y-%m-%d')
    elsif params[:to] =~ /\d{10}/
      to = Time.at(params[:to].to_i-1).to_datetime
    end
     
    pings = Ping.where(:epoch_time => from..to, device_id: id).pluck('epoch_time')
    
    # Convert to Unix Timestamp
    pings.map! { |ping| ping.to_i }
    render json: pings
  end

  def all
    hash = {}
    # Get all devices
    ids = Device.all.pluck('id')
    ids.each do |id|
      # Get device_id
      device_id = Device.where(id: id).pluck('device_id').first
      # Get pings for this device
      pings = Ping.where(device_id: id).pluck('epoch_time')
      # Convert to Unix Timestamp
      pings.map! { |ping| ping.to_i }
      hash[device_id] = pings
    end
    render json: hash
  end
  
  def allbydate
    date = DateTime.strptime(params[:date], '%Y-%m-%d')
    hash = {}
    # Get all devices
    ids = Device.all.pluck('id')
    ids.each do |id|
      # Get device_id
      device_id = Device.where(id: id).pluck('device_id').first
      # Get pings for this device
      pings = Ping.where(epoch_time: date.all_day, device_id: id).pluck('epoch_time')
    # Convert to Unix Timestamp
      pings.map! { |ping| ping.to_i }
      if pings.size > 0
        hash[device_id] = pings
      end
    end
    render json: hash
  end

  def allfromto
    # Parse from and to
    if (params[:from] =~ /\d{4}-\d{2}-\d{2}/)
      from = DateTime.strptime(params[:from], '%Y-%m-%d')
    elsif params[:from] =~ /\d{10}/
      from = Time.at(params[:from].to_i).to_datetime
    end

    if (params[:to] =~ /\d{4}-\d{2}-\d{2}/)
      to = DateTime.strptime(params[:to], '%Y-%m-%d')
    elsif params[:to] =~ /\d{10}/
      to = Time.at(params[:to].to_i-1).to_datetime
    end
    hash = {}
    # Get all devices
    ids = Device.all.pluck('id')
    ids.each do |id|
      # Get device_id
      device_id = Device.where(id: id).pluck('device_id').first
      # Get pings for this device
      pings = Ping.where(:epoch_time => from..to, device_id: id).pluck('epoch_time')
    # Convert to Unix Timestamp
      pings.map! { |ping| ping.to_i }
      if pings.size > 0
        hash[device_id] = pings
      end
    end
    render json: hash
  end

  # Deletes all data
  def clear
    pi = Ping.all.destroy_all
    d = Device.all.destroy_all
    render json: {}
  end
end