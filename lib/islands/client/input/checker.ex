defmodule Islands.Client.Input.Checker do
  use PersistConfig

  alias Islands.Client.Input.Prompter
  alias Islands.Client.{GameOver, Input, RandomGuess, State}

  @board_range 1..10
  @island_type_codes ["a", "d", "l", "s", "q"]
  @messages Application.get_env(@app, :messages)
  @pause_range 0..10_000

  @spec check_input(Input.t(), State.t()) :: State.t() | no_return
  def check_input({:error, reason} = _input, state),
    do: GameOver.end_game(["Game ended: #{inspect(reason)}"], state)

  def check_input(:eof = input, state),
    do: GameOver.end_game(["Game ended: #{inspect(input)}"], state)

  def check_input(input, %State{} = state) do
    input
    |> String.split()
    |> case do
      [code, row, col] when code in @island_type_codes ->
        with {row, ""} when row in @board_range <- Integer.parse(row),
             {col, ""} when col in @board_range <- Integer.parse(col) do
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
        with {row, ""} when row in @board_range <- Integer.parse(row),
             {col, ""} when col in @board_range <- Integer.parse(col) do
          put_in(state.move, [row, col])
        else
          _ -> Prompter.accept_move(state, @messages.bad_move)
        end

      [] ->
        check_input(RandomGuess.new(state), state)

      [move] when move in ["all", "set", "stop"] ->
        put_in(state.move, [move])

      ["help"] ->
        Prompter.accept_move(state, @messages.help)

      _other ->
        Prompter.accept_move(state, @messages.bad_move)
    end
  end
end
