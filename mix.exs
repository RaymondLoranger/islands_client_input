defmodule Islands.Client.Input.MixProject do
  use Mix.Project

  def project do
    [
      app: :islands_client_input,
      version: "0.1.41",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "Islands Client Input",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/islands_client_input"
  end

  defp description do
    """
    Prompts and accepts a move in the Game of Islands.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "config/persist*.exs"],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:io_ansi_plus, "~> 0.1"},
      {:islands_client_game_over, "~> 0.1"},
      {:islands_client_random_guess, "~> 0.1"},
      {:islands_client_state, "~> 0.1"},
      {:islands_tally, "~> 0.1"},
      {:persist_config, "~> 0.4", runtime: false}
    ]
  end
end
