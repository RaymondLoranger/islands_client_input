# ┌─────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Elixir for Programmers" by Dave Thomas. │
# └─────────────────────────────────────────────────────────────────┘
defmodule Islands.Client.Input do
  use PersistConfig

  @course_ref Application.get_env(@app, :course_ref)

  @moduledoc """
  Prompts for and accepts a move in the _Game of Islands_.
  \n##### #{@course_ref}
  """

  alias __MODULE__.Prompter
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State

  @type t :: IO.chardata() | IO.nodata()

  @spec accept_move(State.t(), ANSI.ansilist()) :: State.t() | no_return
  defdelegate accept_move(state, message \\ []), to: Prompter
end
