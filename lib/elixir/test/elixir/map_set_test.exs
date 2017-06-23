Code.require_file "test_helper.exs", __DIR__


defmodule Deck do
  defstruct cards: MapSet.new

  def filter_red_cards(deck) do
    no_black_cards = Enum.filter(deck.cards, fn card -> card.colour != :black end)
    %__MODULE__{deck | cards: no_black_cards}
  end
end


defmodule MapSetTest do
  use ExUnit.Case, async: true

  doctest MapSet

  test "new/1" do
    result = MapSet.new(1..5)
    assert MapSet.equal?(result, Enum.into(1..5, MapSet.new))
  end

  test "new/2" do
    result = MapSet.new(1..5, &(&1 + 2))
    assert MapSet.equal?(result, Enum.into(3..7, MapSet.new))
  end

  test "put/2" do
    result = MapSet.put(MapSet.new, 1)
    assert MapSet.equal?(result, MapSet.new([1]))

    result = MapSet.put(MapSet.new([1, 3, 4]), 2)
    assert MapSet.equal?(result, MapSet.new(1..4))

    result = MapSet.put(MapSet.new(5..100), 10)
    assert MapSet.equal?(result, MapSet.new(5..100))
  end

  test "union/2" do
    result = MapSet.union(MapSet.new([1, 3, 4]), MapSet.new)
    assert MapSet.equal?(result, MapSet.new([1, 3, 4]))

    result = MapSet.union(MapSet.new(5..15), MapSet.new(10..25))
    assert MapSet.equal?(result, MapSet.new(5..25))

    result = MapSet.union(MapSet.new(1..120), MapSet.new(1..100))
    assert MapSet.equal?(result, MapSet.new(1..120))
  end

  test "intersection/2" do
    result = MapSet.intersection(MapSet.new, MapSet.new(1..21))
    assert MapSet.equal?(result, MapSet.new)

    result = MapSet.intersection(MapSet.new(1..21), MapSet.new(4..24))
    assert MapSet.equal?(result, MapSet.new(4..21))

    result = MapSet.intersection(MapSet.new(2..100), MapSet.new(1..120))
    assert MapSet.equal?(result, MapSet.new(2..100))
  end

  test "difference/2" do
    result = MapSet.difference(MapSet.new(2..20), MapSet.new)
    assert MapSet.equal?(result, MapSet.new(2..20))

    result = MapSet.difference(MapSet.new(2..20), MapSet.new(1..21))
    assert MapSet.equal?(result, MapSet.new)

    result = MapSet.difference(MapSet.new(1..101), MapSet.new(2..100))
    assert MapSet.equal?(result, MapSet.new([1, 101]))
  end

  test "disjoint?/2" do
    assert MapSet.disjoint?(MapSet.new, MapSet.new)
    assert MapSet.disjoint?(MapSet.new(1..6), MapSet.new(8..20))
    refute MapSet.disjoint?(MapSet.new(1..6), MapSet.new(5..15))
    refute MapSet.disjoint?(MapSet.new(1..120), MapSet.new(1..6))
  end

  test "subset?/2" do
    assert MapSet.subset?(MapSet.new, MapSet.new)
    assert MapSet.subset?(MapSet.new(1..6), MapSet.new(1..10))
    assert MapSet.subset?(MapSet.new(1..6), MapSet.new(1..120))
    refute MapSet.subset?(MapSet.new(1..120), MapSet.new(1..6))
  end

  test "equal?/2" do
    assert MapSet.equal?(MapSet.new, MapSet.new)
    refute MapSet.equal?(MapSet.new(1..20), MapSet.new(2..21))
    assert MapSet.equal?(MapSet.new(1..120), MapSet.new(1..120))
  end

  test "delete/2" do
    result = MapSet.delete(MapSet.new, 1)
    assert MapSet.equal?(result, MapSet.new)

    result = MapSet.delete(MapSet.new(1..4), 5)
    assert MapSet.equal?(result, MapSet.new(1..4))

    result = MapSet.delete(MapSet.new(1..4), 1)
    assert MapSet.equal?(result, MapSet.new(2..4))

    result = MapSet.delete(MapSet.new(1..4), 2)
    assert MapSet.equal?(result, MapSet.new([1, 3, 4]))
  end

  test "size/1" do
    assert MapSet.size(MapSet.new) == 0
    assert MapSet.size(MapSet.new(5..15)) == 11
    assert MapSet.size(MapSet.new(2..100)) == 99
  end

  test "to_list/1" do
    assert MapSet.to_list(MapSet.new) == []

    list = MapSet.to_list(MapSet.new(1..20))
    assert Enum.sort(list) == Enum.to_list(1..20)

    list = MapSet.to_list(MapSet.new(5..120))
    assert Enum.sort(list) == Enum.to_list(5..120)
  end

  test "preserves the module type" do
    my_struct = struct(Deck)
    # IO.inspect my_struct, label: "my_struct"
    # IO.inspect my_struct.cards, label: "my_struct.cards"
    updated_struct = %Deck{my_struct | cards: Enum.filter(my_struct.cards, fn card -> card.colour != :black end)}
    # new_cards = updated_struct.cards
    # IO.inspect updated_struct, label: "updated_struct"
    # IO.inspect updated_struct.cards, label: "updated_struct.cards"
    # %Deck{cards: ^new_cards} = updated_struct
    assert my_struct.cards == updated_struct.cards
  end

  test "test 2" do
    map_set = MapSet.new()
    # IO.inspect map_set, label: "map_set"
    updated_map_set = Enum.filter(map_set, fn x -> x != 0 end)
    # IO.inspect updated_map_set, label: "updated_map_set"
    assert map_set == MapSet.new() # this works
    # assert %MapSet{} = updated_map_set # this fails
    %module_name{} = updated_map_set
    assert module_name == MapSet
  end

  test "test 3" do
    map_set = MapSet.new()
    # IO.inspect map_set, label: "map_set"
    updated_map_set = Enum.filter(map_set, fn x -> x != 0 end)
    # IO.inspect updated_map_set, label: "updated_map_set"
    assert updated_map_set == MapSet.new() # this should fail in theory
    # assert %MapSet{} = updated_map_set # this fails
    # %module_name{} = updated_map_set
    # assert module_name == MapSet
  end

  test "test 4" do
    map_set = MapSet.new()
    # IO.inspect map_set, label: "map_set"
    updated_map_set = Enum.filter(map_set, fn x -> x != 0 end)
    # IO.inspect updated_map_set, label: "updated_map_set"
    assert updated_map_set == MapSet.new() # this should fail in theory

    assert map_set.__struct__ == MapSet
    assert updated_map_set.__struct__ == MapSet
    # assert %MapSet{} = updated_map_set # this fails
    # %module_name{} = updated_map_set
    # assert module_name == MapSet
  end
end

