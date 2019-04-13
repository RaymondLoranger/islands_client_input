defmodule Islands.Client.Input.Prompter do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.Input.{Getter, Parser}
  alias Islands.Client.{State, Summary}

  # Hopefully enough time to flush any unprompted input...
  @timeout_in_ms 2

  @spec accept_move(State.t(), ANSI.ansilist()) :: State.t() | no_return
  def accept_move(state, message \\ [])
  def accept_move(state, []), do: do_accept_move(state)

  def accept_move(state, message),
    do: state |> Summary.display(message) |> do_accept_move()

  # Private functions

  @spec do_accept_move(State.t()) :: State.t() | no_return
  defp do_accept_move(%State{player_name: player_name} = state) do
    true = flush_stdio(state)

    [:light_white, "#{player_name}, your move (or help):", :reset, " "]
    |> Getter.get_input(state)
    |> Parser.parse_input(state)
  end

  @spec flush_stdio(State.t()) :: true
  defp flush_stdio(%State{mode: mode, pause: pause} = _state)
       when mode == :manual or pause > 10 do
    pid = spawn(fn -> IO.read(:all) end)
    :ok = Process.sleep(@timeout_in_ms)
    true = Process.exit(pid, :kill)
  end

  defp flush_stdio(_state), do: true
end
