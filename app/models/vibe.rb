class Vibe < ActiveRecord::Base
  attr_accessor :count
  
  belongs_to :room
  
  VIBE_TYPES = ['bored', 'good', 'confused']
  
  scope :bored, where(vibe_type: 'bored')
  scope :good, where(vibe_type: 'good')
  scope :confused, where(vibe_type: 'confused')
  
  validates :room_id, presence: true
  validates :vibe_type, inclusion: {in: VIBE_TYPES}
  
  def self.chart(room_id)
    sql = "SELECT count(1) as room_id, vibe_type, created_at FROM `vibes` where room_id = #{room_id} GROUP BY vibe_type, (60/1) * HOUR( created_at ) + FLOOR( MINUTE( created_at ) / 1 )"
    Vibe.find_by_sql(sql)
  end
  
  def self.chart_series(room_id)
    str = ""
    chart_data = Vibe.chart(room_id)
    room = Room.find(room_id)
    if !chart_data.empty?
      started_at = room.created_at
      ended_at = room.ended_at
      last_time = ended_at - started_at
      ['bored', 'good'].each{|v|
        vibes = chart_data.select{|s| s.vibe_type == v}
        str << "{\n"
        str << "name: '#{v}',\n"
        data = ["{ x: 0, y: null}", "{ x: #{last_time}, y: null}"]
        vibes.each{|point|
          if point.created_at
            data << "{ x: #{point.created_at - room.created_at}, y: #{point.room_id || "null"}}"
          end
        }
        str << "data: [#{data.join(', ')}]\n"
        str << "},\n"
      }
    end
    return str.chop
  end
end