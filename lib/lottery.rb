class Lottery

  attr_reader :members, :winners, :prize_count

  def initialize (prize_count)
    @prize_count = prize_count
    @members = []
    @winners = []
    @lastMembers = []
  end

  def add(name,weight)

    if name.empty? then return false end
    if @members.include?(name) then return false end
    if weight < 1 then return false end

    for i in 1..weight do
        @members << name
    end

  end

  def selectWinners

    @winners = []

    if @prize_count >= @members.uniq.length then
        return @winners = Marshal.load(Marshal.dump(@members.uniq))
    end

    last_members = Marshal.load(Marshal.dump(@members))

    for i in 1..@prize_count do
        winner_index = rand(last_members.length-1)
        @winners << last_members[winner_index]
        last_members.delete(last_members[winner_index])
    end

  end

end
