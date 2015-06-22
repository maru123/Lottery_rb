class Lottery

  attr_reader :members, :prize_count

  def initialize (prize_count)
    @prize_count = prize_count
    @members = []
    @lastMembers = []
  end

  def add(name,weight)
    name.empty? || @members.include?(name) || weight < 1 ||
    weight.times { @members << name }
    # if name.empty? then return false end
    # if @members.include?(name) then return false end
    # if weight < 1 then return false end
    # weight.times { @members << name }

  end

  def winners

    results = []

    if @prize_count >= @members.uniq.length then
        return results = Marshal.load(Marshal.dump(@members.uniq))
    end

    last_members = Marshal.load(Marshal.dump(@members))

    @prize_count.times do
      winner_index = rand(last_members.length-1)
      results << last_members[winner_index]
      last_members.delete(last_members[winner_index])
    end
    results
  end

end
