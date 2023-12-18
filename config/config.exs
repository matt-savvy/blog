import Config

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.6",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../output/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]
