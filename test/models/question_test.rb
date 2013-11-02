require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test "nao deve salvar sem o nome" do
    question = build(:question, name: nil)
    refute question.save
  end

  test "deve pertencer a uma track" do
    question = create(:question)
    refute_nil question.track
  end

  test "deve conhecer suas answers" do
    question = create(:question)
    refute_nil question.answers
  end

  test "deve saber qual a proxima question" do
    question = create(:question, next: create(:question))
    refute_nil question.next
  end

  test "deve salver suas answers" do
    question = create(:question)
    assert_difference 'question.answers.count' do
      question.update(answers_attributes: [json_value: "given answer",
        player_id: create(:player).id])
    end
  end

  test "deve saber as answers de um determinado player" do
    player = create(:player)
    question = create(:question)
    answer = create(:answer, player_id: player.id, question_id: question.id)
    assert_equal answer, question.given_answer(player)
  end

  # ****** deve testar o resume ******
  test "deve saber qual a primeira question de uma dada track" do
    track = create(:track)
    # player = create(:player)
    create(:question, track_id: track.id)
    assert_equal Question.resume(track, player), track.questions.first
  end
end
