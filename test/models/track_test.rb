require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test "nao deve salvar sem o nome" do
    track = build(:track, name: nil)
    refute track.save
  end

  test "deve conhecer suas questions" do
    track = create(:track)
    refute_nil track.questions
  end

end
