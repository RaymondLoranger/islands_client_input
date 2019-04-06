# ┌─────────────────────────────────────────────────────────────────┐
# │ Inspired by the course "Elixir for Programmers" by Dave Thomas. │
# └─────────────────────────────────────────────────────────────────┘
defmodule Islands.Client.Input do
  use PersistConfig

  @course_ref Application.get_env(@app, :course_ref)

  @moduledoc """
  Prompts for and processes input in the _Game of Islands_.
  \n##### #{@course_ref}
  """

  alias __MODULE__.{Checker, Getter, Prompter}
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.State

  @type t :: IO.chardata() | IO.nodata()

  @spec get_input(ANSI.ansilist(), State.t()) :: t()
  defdelegate get_input(prompt, state), to: Getter

  @spec check_input(t, State.t()) :: State.t() | no_return
  defdelegate check_input(input, state), to: Checker

  @spec accept_move(State.t(), ANSI.ansilist()) :: State.t() | no_return
  defdelegate accept_move(state, message \\ []), to: Prompter
end
