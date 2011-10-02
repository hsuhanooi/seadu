class Vibe < ActiveRecord::Base
  attr_accessor :chart_time
  
  belongs_to :room
  
  PollInterval = 10
  Decay = 120
  VIBE_TYPES = ['bored', 'good', 'confused']
  
  scope :bored, where(vibe_type: 'bored')
  scope :good, where(vibe_type: 'good')
  scope :confused, where(vibe_type: 'confused')
  
  validates :room_id, presence: true
  validates :vibe_type, inclusion: {in: VIBE_TYPES}
  
  Point = Struct.new(:count, :seconds_after_start)
  
  ChartSeriesOrder = ['bored', 'confused', 'good']
  
  def self.chart(room_id)
    sql = "SELECT count(1) as room_id, vibe_type, created_at FROM `vibes` where room_id = #{room_id} GROUP BY vibe_type, (60/1) * HOUR( created_at ) + FLOOR( MINUTE( created_at ) / 1 )"
    Vibe.find_by_sql(sql)
  end
  
  def self.chart_live(room, last_ping)
    last_format = (last_ping - PollInterval - Decay).utc.strftime("%Y-%m-%d %H:%M:%S")
    sql = "SELECT count(1) as room_id, vibe_type FROM vibes where room_id = #{room.id} and created_at > '#{last_format}' GROUP BY vibe_type"
    seconds = (Time.now - room.created_at).round
    hash = {:bored => [seconds, 0], :confused => [seconds, 0], :good => [seconds, 0]}
    vibes = Vibe.find_by_sql(sql)
    vibes.each{|v|
      p = Point.new(v.room_id, seconds)
      hash[v.vibe_type] = [p.seconds_after_start, p.count]
    }
    hash.to_json
  end
  
  def seconds_after_start
    (created_at - room.created_at).round
  end
  
  def self.chart_series(room_id)
    str = ""
    chart_data = Vibe.chart(room_id)
    room = Room.find(room_id)
    started_at = room.created_at
    ended_at = room.ended_at
    last_time = (ended_at - started_at).round
    max_time = last_time > 7200 ? 7200 : last_time
    ChartSeriesOrder.each{|v|
      friendly = nil
      if v == 'good'
        friendly = 'Engaged'
      elsif v == 'confused'
        friendly = 'Lost'
      elsif v == 'bored'
        friendly = 'Bored'
      end
      vibes = chart_data.select{|s| s.vibe_type == v}.sort{|x, y| x.created_at <=> y.created_at}
      str << "{\n"
      str << "name: '#{friendly}',\n"
      data = ["{ x: 0, y: null}", "{ x: #{max_time}, y: '0'}"]
      idx = 0
      last_count = 0
      (0..last_time).each{|time|
        if time % 60 == 0
          point = vibes[idx]
          if point
            v_created = (point.created_at - room.created_at).round
            if v_created <= time
              data << "{ x: #{time}, y: #{point.room_id}}"
              last_count = point.room_id
              idx += 1
            else
              data << "{ x: #{time}, y: #{last_count}}"
            end
          end
        end
      }
      str << "data: [#{data.join(', ')}]\n"
      str << "},\n"
    }
    return str.chop
  end
end