require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test "nao deve salvar sem o username" do
    player = build(:player, username: nil)
    refute player.save
  end

  test "nao deve salvar sem o password" do
    player = build(:player, password: nil)
    refute player.save
  end

  test "nao deve salvar se o password e o password_confirmation nao forem iguais" do
    player = build(:player, password: "secret", password_confirmation: "unsecret")
    refute player.save
  end

  test "nao deve salvar se o username ja estiver em uso" do
    create(:player, username: "player")
    player = build(:player, username: "player")
    refute player.save
  end

  test "deve autenticar com o password correto" do
    player = create(:player, password: "secret")
    assert_equal player.authenticate("secret"), player
  end

  test "nao deve autenticar com o password incorreto" do
    player = create(:player, password: "secret")
    refute player.authenticate("unsecret")
  end

  test "deve saber sua propria role" do
    player = create(:player)
    assert_equal player.role, :PLAYER
  end

  test "deve saber que possui uma determinada role" do
    player = create(:player)
    assert player.has_roles?([:TEAM, :PLAYER])
  end

  test "deve saber que nao possui uma determinada role" do
    player = create(:player)
    refute player.has_roles?([:TEAM])
  end

  test "deve possuir a role vazia" do
    player = create(:player)
    assert player.has_roles?([])
  end

  test "deve pertencer a um time" do
    player = create(:player)
    refute_nil player.team
  end

  test "deve conhecer suas answers" do
    player = create(:player)
    refute_nil player.answers
  end
end
