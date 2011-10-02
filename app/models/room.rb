class Room < ActiveRecord::Base
  belongs_to :teacher
  has_many :vibes
  has_many :questions, include: :votes, :conditions => {:status => 'new'}
  
  ROOM_STATES = ['active', 'expired']
  
  validates :status, inclusion: {in: ROOM_STATES}
  validate :name_is_unique
  validates :name, presence: true, length: 1..255
  validates :vibe_threshold, numericality: true
  validates :question_threshold, numericality: true
  
  after_initialize :init
  
  def bored_vibes
    vibes.bored
  end
  
  def good_vibes
    vibes.good
  end
  
  def confused_vibes
    vibes.confused
  end
  
  def active?
    status.eql?('active')
  end
  
  #Returns the end time for the room or the current time if its still open
  def ended_at
    read_attribute(:ended_at) || Time.now
  end
  
  def mock
    Vibe::VIBE_TYPES.each{ |vibe|
      (1..200).each{|i|
        created = created_at + rand(3300) + 300
        v = Vibe.new(:vibe_type => vibe, :room_id => id, :created_at => created, :updated_at => created)
        v.save!
      }
    }
    
    test_q = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    (1..30).each{|i|
      content = test_q[0, rand(test_q.length)]
      created = created_at + rand(3300) + 300
      q = Question.create(:status => "new", :room_id => id, :content => content, :created_at => created, :updated_at => created)
      
      (1..(rand(50) + 1)).each{|c|
        v_created_at = q.created_at + rand(3300) + 300
        Vote.create(:vote_type => Vote::VOTE_TYPES[0], :question_id => q.id, :created_at => v_created_at, :updated_at => v_created_at)
      }
    }
  end
  
  def finished?
    status == 'expired'
  end
  
  def finish_room
    r = nil
    if status != 'expired' || ended_at.nil?
      self.ended_at = Time.now
      self.status = 'expired'
      r = self.save
    else
      r = true
    end
    r
  end
  
  def visit(session)
    rooms_visited = session[:rooms]
    has_visited = false
    if rooms_visited
      rooms_visited.split(',').each{|room_id|
        if room_id.to_i == id
          has_visited = true
        end
      }

      if has_visited
        session[:rooms] = rooms_visited + ",#{id}"
        listeners = (num_listeners || 1) + 1
        Room.find_by_sql("update rooms set num_listeners = #{listeners}")
        return true
      end

    else
      session[:rooms] = id.to_s
      listeners = (num_listeners || 1) + 1
      Room.find_by_sql("update rooms set num_listeners = #{listeners} where id = #{id}")
      return true
    end
    return false
  end
  
  def seconds_alive
    (Time.now - created_at).round
  end
  
  private
  def init
    self.status ||= 'active'
    self.vibe_threshold ||= 10
    self.question_threshold ||= 10
  end
  
  def name_is_unique
    if active? and Room.exists?(status: 'active', name: name)
      errors.add(:name, 'is currently in use')
    end
  end
end