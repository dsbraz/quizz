require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test "nao deve salvar sem o username" do
    team = build(:team, username: nil)
    refute team.save
  end

  test "nao deve salvar sem o password" do
    team = build(:team, password: nil)
    refute team.save
  end

  test "nao deve salvar se o password e o password_confirmation nao forem iguais" do
    team = build(:team, password: "secret", password_confirmation: "unsecret")
    refute team.save
  end

  test "nao deve salvar se o username ja estiver em uso" do
    create(:team, username: "team")
    team = build(:team, username: "team")
    refute team.save
  end

  test "deve autenticar com o password correto" do
    team = create(:team, password: "secret")
    assert_equal team.authenticate("secret"), team
  end

  test "nao deve autenticar com o password incorreto" do
    team = create(:team, password: "secret")
    refute team.authenticate("unsecret")
  end

  test "deve saber sua propria role" do
    team = create(:team)
    assert_equal team.role, :TEAM
  end

  test "deve saber que possui uma determinada role" do
    team = create(:team)
    assert team.has_roles?([:TEAM, :PLAYER])
  end

  test "deve saber que nao possui uma determinada role" do
    team = create(:team)
    refute team.has_roles?([:PLAYER])
  end

  test "deve possuir a role vazia" do
    team = create(:team)
    assert team.has_roles?([])
  end

  test "deve conhecer seus players" do
    team = create(:team)
    refute_nil team.players
  end

  test "deve salvar seus players" do
    team = build(:team)
    assert_difference 'team.players.count' do
      team.update(players_attributes: [username: "team", password: "secret",
        password_confirmation: "secret"])
    end
  end

  test "deve rejeitar players sem username" do
    team = create(:team)
    assert_no_difference 'team.players.count' do
      team.update(players_attributes: [username: "", password: "secret",
        password_confirmation: "secret"])
    end
  end
end
