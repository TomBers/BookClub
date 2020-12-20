defmodule BuildTree do
  def build_tree(msgs) do
    msgs
    |> Enum.reduce([], fn msg, acc -> calc_depth(msg, acc) end)
    |> Enum.map(fn msg -> Map.put(msg, :ultimate_parent, get_ultimate_parent_id(msg, msgs)) end)
    |> Enum.sort(&(&1.ultimate_parent <= &2.ultimate_parent))
    |> Enum.map(fn msg -> Map.put(msg, :has_children, has_children?(msg, msgs)) end)
  end

  def has_children?(msg, all) do
    Enum.any?(all, fn x -> x.parent_id == msg.id end)
  end

  def calc_depth(msg, acc) do
    parent = get_parent(msg, acc)
    acc ++ [Map.put(msg, :depth, parent.depth + 1)]
  end

  def get_ultimate_parent_id(msg, all) do
    if is_nil(msg.parent_id) do
      msg.id
    else
      get_ultimate_parent_id(get_parent(msg, all), all)
    end
  end

  def get_parent(msg, all) do
    Enum.find(all, %{depth: 0}, fn ele -> ele.id == msg.parent_id end)
  end
end
