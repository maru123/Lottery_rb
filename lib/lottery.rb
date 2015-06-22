class Lottery

  attr_reader :members, :prize_count

  def initialize (prize_count)
    @prize_count = prize_count
    @members = []
  end

  def add(name,weight)
    name.empty? || @members.include?(name) || weight < 1 ||
    weight.times { @members << name }
  end

  def winners
    if @prize_count >= @members.uniq.length
        return @members.uniq
    end

    last_members = @members.dup
    @prize_count.times.each_with_object([]) do |i, results|
      member = last_members.sample
      results << member
      last_members.delete(member)
    end
  end
end
