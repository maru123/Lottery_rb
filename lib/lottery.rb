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
  end

  def winners

    results = []

    if @prize_count >= @members.uniq.length
        return @members.uniq
    end

    last_members = Marshal.load(Marshal.dump(@members))

    @prize_count.times do
      member = last_members.sample
      results << member
      last_members.delete(member)
    end
    results
  end

end
