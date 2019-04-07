defmodule Islands.Client.Input.Getter do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Client.{Input, RandomGuess, State}
  alias Islands.Tally

  @spec get_input(ANSI.ansilist(), State.t()) :: Input.t()
  def get_input(prompt, %State{mode: :manual} = _state), do: ANSI.gets(prompt)

  def get_input(
        prompt,
        %State{
          mode: :auto,
          pause: pause,
          tally: %Tally{game_state: :players_set, request: request}
        } = _state
      ) do
    ANSI.write(prompt)
    Process.sleep(pause)

    move =
      case request do
        {:add_player, _, _, _} -> "all"
        {:position_all_islands, _} -> "set"
        {:position_island, _, _, _, _} -> "set"
      end

    IO.puts(move)
    move
  end

  def get_input(prompt, %State{mode: :auto, pause: pause} = state) do
    ANSI.write(prompt)
    Process.sleep(pause)
    guess = RandomGuess.new(state)
    IO.puts(guess)
    guess
  end
end
