require_relative '../lib/lottery.rb'
describe Lottery do
  let(:lottery) { Lottery.new(prize_count) }
  let(:prize_count) { 1 }
  let(:members) { %w(John Jane Matz) }
  let(:add_member) { members.each{|name| lottery.add(name,1) } }

  describe '#add' do
    it '名前が与えられない場合はメンバーに追加しない' do
      lottery.add('',1)
      expect(lottery.members.count('')).to eq 0
    end
    it '重みが正の数より小さい場合はメンバーに追加しない' do
      lottery.add('John',0)
      expect(lottery.members.count('John')).to eq 0
    end
    it '同一の名前がすでに登録されている場合は追加しない' do
      lottery.add('John',1)
      lottery.add('John',1)
      expect(lottery.members.count('John')).to eq 1
    end

    it '異なる名前を3人登録したらメンバーが3人になっている' do
      add_member
      expect(lottery.members.length).to eq 3
    end
  end
  describe '#members' do
    it '登録した3人の名前が返される' do
      add_member
      expect(lottery.members).to eq members
    end
  end
  describe '#winners' do
  #   # shared_examples '該当者なし' do
  #   #   it '空の配列が返される' do
  #   #     expect(lottery.winners).to eq []
  #   #   end
  #   # end
    context '懸賞が0の場合' do
      let(:prize_count) { 0 }
      it '該当者なし' do
        expect(lottery.winners).to eq []
    #   it_behaves_like '該当者なし'
      end
    end
    context '登録者が0人の場合' do
      it '該当者なし' do
        expect(lottery.winners).to eq []
    #   it_behaves_like '該当者なし'
      end
    end

    context '登録者数が懸賞以下の場合' do
      let(:prize_count) { 3 }
      it '登録した3人の名前が返される' do
        add_member
        expect(lottery.winners.include?(members[0])).to be true
        expect(lottery.winners.include?(members[1])).to be true
        expect(lottery.winners.include?(members[2])).to be true
      end
    end

    context '登録者数が懸賞より多い場合' do
      let(:prize_count) { 2 }
      it '懸賞分の名前が返される' do
        add_member
        expect(lottery.winners.length).to eq prize_count
      end
    end

    context '重み付けされている場合' do
      let(:prize_count) { 1 }
      it '100回試して重み付け順に当選する' do
        counts = {A1: 0, A3: 0, A5: 0, A10: 0}
        lottery.add("A1",1)
        lottery.add("A3",3)
        lottery.add("A5",5)
        lottery.add("A10",10)
        1000.times do
          counts[lottery.winners.first.intern] += 1
        end

        expect(counts[:A1] < counts[:A3] && counts[:A3] < counts[:A5] && counts[:A5] < counts[:A10]).to eq true
      end
    end

  end
end
