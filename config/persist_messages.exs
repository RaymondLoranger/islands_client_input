use Mix.Config

config :islands_client_input,
  messages: %{
    auto_mode: [
      :free_speech_red_background,
      :light_white,
      "Switching to auto mode."
    ],
    bad_move: [
      :free_speech_red_background,
      :light_white,
      "Please enter a valid move (or help)."
    ],
    help: [
      :chartreuse_yellow,
      "● position island: ",
      :spring_green,
      "<code> <row> <col>",
      :chartreuse_yellow,
      "\n  where code is: ",
      :spring_green,
      "a",
      :chartreuse_yellow,
      "toll | ",
      :spring_green,
      "d",
      :chartreuse_yellow,
      "ot | ",
      :spring_green,
      "l",
      :chartreuse_yellow,
      "_shape | ",
      :spring_green,
      "s",
      :chartreuse_yellow,
      "_shape | s",
      :spring_green,
      "q",
      :chartreuse_yellow,
      "uare",
      :chartreuse_yellow,
      "\n● position all islands: ",
      :spring_green,
      "all",
      :chartreuse_yellow,
      "\n● set islands: ",
      :spring_green,
      "set",
      :chartreuse_yellow,
      "\n● make a guess: ",
      :spring_green,
      "<row> <col>",
      :chartreuse_yellow,
      "\n● random guess: ",
      :spring_green,
      "<Enter>",
      :chartreuse_yellow,
      "\n● auto mode: ",
      :spring_green,
      "auto <pause>",
      :chartreuse_yellow,
      "\n  where pause is: ",
      :spring_green,
      "0",
      :chartreuse_yellow,
      "..",
      :spring_green,
      "10000",
      :chartreuse_yellow,
      " (in ms)",
      :chartreuse_yellow,
      "\n● stop: ",
      :spring_green,
      "stop",
      :chartreuse_yellow,
      "\n● help: ",
      :spring_green,
      "help"
    ]
  }
