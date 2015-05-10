defmodule Portal.Door do
  @doc ~S"""
  Starts a door given a `color`

  Color is given by a name so we can identify the door
  """
  def start_link(color) do
    Agent.start_link(fn -> [] end, name: color)
  end

  @doc """
  Get data currently in door
  """
  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  @doc """
  Pushes `value` into door
  """
  def push(door, value) do
    Agent.update(door, fn list -> [value|list] end)
  end

  @doc """
  Pops `value` from door

  Returns {:ok, value} if present, {:error} otherwise
  """
  def pop(door) do
    Agent.get_and_update(door, fn
      [] -> {:error, []}
      [h|t]end -> {{:ok, h}, t}
    )
  end
end
