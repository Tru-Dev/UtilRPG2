# UtilRPG2 <!-- omit in toc --> 

A bot that rolls dice for tabletop RPGs.

## Table of Contents <!-- omit in toc --> 
- [Setup](#setup)
- [Running the Bot](#running-the-bot)
- [Commands](#commands)
  - [Dice](#dice)
  - [Util](#util)
- [License](#license)

## Setup

```console
$ git clone https://github.com/Tru-Dev/UtilRPG2
```

In `config/config.exs`, under `config :utilrpg2`, is the `dev` option.
When this is enabled, all commands will be registered as guild commands
in the guild specified in `guild.txt` for testing purposes.  
Once you are ready to deploy, set `dev: false`.

Make sure you provide these files for the default config file to work:
- `token.txt`: The bot's token.
- `guild.txt`: A guild id. Used for:
  1. Testing commands when `dev: true`.
  2. Registering the bot's control commands.
- `owner.txt`: Your user id, to ensure you can use the bot's control commands.

## Running the Bot

In the UtilRPG2 directory, run `mix run --no-halt`:

## Commands

Commands will follow the notation below:  
/COMMAND arg [optional-arg]

### Dice

/check [advantage] [modifier]  
Makes a d20-based ability check.  
Arguments:
- advantage: Roll with advantage or disadvantage.  
  Choice of either `advantage` or `disadvantage`.
  Defaults to not applying either.
- modifier: Modifier applied to check.  
  Integer value, defaults at 0.

/roll kind [amount] [modifier]  
Rolls one or more dice of a kind.  
Arguments:
- kind: Kind of dice to roll. Required.  
  Integer value greater than 1.
- amount: Amount of dice to roll (default 1).  
  Integer value greater than 0, defaults at 1. 
- modifier: Amount to add or subtract from your roll(s).  
  Integer value, defaults at 0.

All dice commands composed of d*number* (/d100, /d20, /d12, /d10, /d8, /d6, /d4)
behave the same as /roll with the kind argument set to the number in the command.
They exist for shorthand purposes.

### Util

/refresh  
Owner-only, refreshes the bot's commands.

Internally, it retries registering/updating/deleting commands as necessary.

## License
This bot's source is licensed under [the MIT license](LICENSE).
