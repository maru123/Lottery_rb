class Lottery

  attr_reader :members, :prize_count

  def initialize prize_count
    @prize_count = prize_count
    @members = []
  end

  def add name, weight
    name.empty? || @members.include?(name) || weight < 1 ||
    weight.times { @members << name }
  end

  def winners
    last_members = @members.dup
    @prize_count.times.each_with_object([]) { |i, results|
      results << last_members.sample
      last_members.delete(results.last)
    }.compact
  end
end
