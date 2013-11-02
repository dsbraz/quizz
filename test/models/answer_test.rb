require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test "nao deve salvar sem o valor" do
    answer = build(:answer, json_value: nil)
    refute answer.save
  end

  test "deve pertencer a uma question" do
    answer = create(:answer)
    refute_nil answer.question
  end

  test "deve pertencer a um player" do
    answer = create(:answer)
    refute_nil answer.player
  end

  test "dada uma question so deve ter uma answer para cada player" do
    question = create(:question)
    player = create(:player)
    create(:answer, question_id: question.id, player_id: player.id)
    assert_raises ActiveRecord::RecordNotUnique do
      create(:answer, question_id: question.id, player_id: player.id)
    end
  end
end
