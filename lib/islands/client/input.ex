# ┌─────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Elixir for Programmers" by Dave Thomas. │
# └─────────────────────────────────────────────────────────────────┘
defmodule Islands.Client.Input do
  @moduledoc """
  Prompts and accepts a move in the _Game of Islands_.

  ##### Inspired by the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  alias __MODULE__.Prompter
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State

  @typedoc "Prompted input"
  @type t :: IO.chardata() | IO.nodata()

  @doc """
  Prompts and accepts a move.
  """
  @spec accept_move(State.t(), ANSI.ansilist()) :: State.t() | no_return
  defdelegate accept_move(state, message \\ []), to: Prompter
end
