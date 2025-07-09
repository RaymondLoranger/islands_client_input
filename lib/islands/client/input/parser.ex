defmodule Islands.Client.Input.Parser do
  @moduledoc """
  Parses the prompted input and, if valid, updates the client state struct.
  """

  use PersistConfig

  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.Input.Prompter
  alias Islands.Client.{GameOver, Input, RandomGuess, State}

  @coord_range 1..10
  @island_type_codes ["a", "d", "l", "s", "q"]
  @messages get_env(:messages)
  @pause_range 0..10_000

  @doc """
  Parses the prompted input and, if valid, updates the client state struct.
  """
  @spec parse_input(Input.t(), State.t()) :: State.t() | no_return
  def parse_input({:error, reason} = _input, state) do
    ANSI.puts([:aqua, "Game stopping: ", :light_white, "#{inspect(reason)}"])
    force_stop(state)
  end

  def parse_input(input = :eof, state) do
    ANSI.puts([:aqua, "Game stopping: ", :light_white, "#{inspect(input)}"])
    force_stop(state)
  end

  def parse_input(input, %State{} = state) do
    input
    |> String.split()
    |> case do
      [code, row, col] when code in @island_type_codes ->
        with {row, ""} when row in @coord_range <- Integer.parse(row),
             {col, ""} when col in @coord_range <- Integer.parse(col) do
          put_in(state.move, [code, row, col])
        else
          _ -> Prompter.accept_move(state, @messages.bad_move)
        end

      ["auto", pause] ->
        with {pause, ""} when pause in @pause_range <- Integer.parse(pause) do
          %State{state | mode: :auto, pause: pause}
          |> Prompter.accept_move(@messages.auto_mode)
        else
          _ -> Prompter.accept_move(state, @messages.bad_move)
        end

      [row, col] ->
        with {row, ""} when row in @coord_range <- Integer.parse(row),
             {col, ""} when col in @coord_range <- Integer.parse(col) do
          put_in(state.move, [row, col])
        else
          _ -> Prompter.accept_move(state, @messages.bad_move)
        end

      [] ->
        parse_input(RandomGuess.new(state), state)

      [move] when move in ["all", "set", "stop"] ->
        put_in(state.move, [move])

      ["help"] ->
        Prompter.accept_move(state, @messages.help)

      [":eof"] ->
        parse_input(:eof, state)

      [":error" | reason] ->
        # E.g. :error 'whatever the reason'
        reason = Enum.join(reason, " ")
        {reason, []} = Code.eval_string(reason)
        parse_input({:error, reason}, state)

      _other ->
        Prompter.accept_move(state, @messages.bad_move)
    end
  end

  ## Private functions

  @spec force_stop(State.t()) :: State.t() | no_return
  defp force_stop(state) when state.tally.game_state == :players_set do
    state = put_in(state.tally.request, {:stop, state.player_id})
    put_in(state.tally.response, {:ok, :stopping}) |> GameOver.exit()
  end

  defp force_stop(state) do
    parse_input("stop", state)
  end
end
