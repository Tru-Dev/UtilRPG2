import Config

config :logger,
  level: :info

config :nostrum,
  token: File.read!("token.txt")

config :utilrpg2,
  dev: true,
  # Test guild ID, used with dev: true; also acts as the guild for
  # control commands such as /refresh.
  guild: File.read!("guild.txt"),
  owner: File.read!("owner.txt")
