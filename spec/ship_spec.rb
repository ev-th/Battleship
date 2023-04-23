require "ship"

RSpec.describe Ship do
  context "initially" do
    context "with a length of 0" do
      it "fails" do
        expect { Ship.new(0) }.to raise_error "Length must be a positive integer."
      end
    end

    context "with a length of -1" do
      it "fails" do
        expect { Ship.new(-1) }.to raise_error "Length must be a positive integer."
      end
    end
    
    context "length is a string" do
      it "fails" do
        expect { Ship.new("3") }.to raise_error "Length must be a positive integer."
      end
    end

    it "has a length" do
      ship = Ship.new(3)
      expect(ship.length).to eq 3
    end

    it "has 0 damage" do
      ship = Ship.new(3)
      expect(ship.damage).to eq 0
    end
  end

  describe "#hit" do
    it "adds 1 damage at a time" do
      ship = Ship.new(3)
      ship.hit
      expect(ship.damage).to eq 1
    end

    it "accumulates damage" do
      ship = Ship.new(3)
      ship.hit
      ship.hit
      expect(ship.damage).to eq 2
    end
  end
  
  describe "#sunk?" do
    context "when has not yet been damaged" do
      it "returns false" do
        ship = Ship.new(3)
        expect(ship.sunk?).to eq false
      end
    end

    context "when it has been partially damaged" do
      it "returns false" do
        ship = Ship.new(3)
        ship.hit
        expect(ship.sunk?).to eq false
      end
    end

    context "when it has been fully damaged" do
      it "returns true" do
        ship = Ship.new(3)
        ship.hit
        ship.hit
        ship.hit
        expect(ship.sunk?).to eq true
      end
    end
  end
end