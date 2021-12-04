defmodule UtilRPG2.Interactions do
  use Bitwise

  require Logger

  alias Nostrum.Api
  alias Nostrum.Struct.Interaction

  alias UtilRPG2.Commands.Util, as: UtilCmds
  alias UtilRPG2.Commands.Dice

  @ctrl_cmds %{
    "refresh" => UtilCmds.Refresh,
  }

  @ctrl_perms [
    %{
      id: Application.get_env(:utilrpg2, :owner),
      type: 2,
      permission: true
    }
  ]

  @commands %{
    "check" => Dice.Check,
    "d100" => Dice.D100,
    "d20" => Dice.D20,
    "d12" => Dice.D12,
    "d10" => Dice.D10,
    "d8" => Dice.D8,
    "d6" => Dice.D6,
    "d4" => Dice.D4,
    "roll" => Dice.Roll,
  }

  def register_cmds do
    gid = Application.get_env(:utilrpg2, :guild)
    if Application.get_env(:utilrpg2, :dev) do
      update_cmds_guild(@commands, gid)|>register_cmds_guild(gid)
    else
      update_cmds_global(@commands)|>register_cmds_global()
    end
    update_cmds_guild(@ctrl_cmds, gid)|>register_cmds_guild(gid)|>apply_perms(@ctrl_perms, gid)
  end

  defp apply_perms(cmds, perms, gid) do
    Enum.each(cmds, fn %{id: cid} ->
      Api.edit_application_command_permissions(gid, cid, perms)
    end)
  end

  defp register_cmds_guild(cmds, gid) do
    Enum.map(cmds, fn {_name, cmd} ->
      {:ok, r} = Api.create_guild_application_command(gid, cmd.get)
      r
    end)
  end

  defp register_cmds_global(cmds) do
    Enum.map(cmds, fn {_name, cmd} ->
      {:ok, r} = Api.create_global_application_command(cmd.get)
      r
    end)
  end

  defp update_cmds_guild(cmds, gid) do
    remaining_cmds = cmds
    {:ok, ocmds} = Api.get_guild_application_commands(gid)

    Enum.reduce(
      ocmds, remaining_cmds,
      fn %{
        id: cid,
        name: name,
        description: odesc,
        default_permission: operm
      } = ocmd, rcmds ->
        oopts = Map.get(ocmd, :options)
        case Map.get(@commands, name) do
          nil ->
            Api.delete_guild_application_command(gid, cid)
            rcmds
          ncmd_mod ->
            upd_map = %{}
            ncmd = ncmd_mod.get
            ndesc = ncmd.description
            upd_map = if ndesc != odesc, do: Map.put(upd_map, :description, ndesc), else: upd_map
            nopts = Map.get(ncmd, :options)
            upd_map = if nopts != oopts, do: Map.put(upd_map, :options, nopts), else: upd_map
            nperm = Map.get(ncmd, :default_permission, true)
            upd_map = if nperm != operm, do: Map.put(upd_map, :default_permission, nperm), else: upd_map
            if upd_map != %{}, do: Api.edit_guild_application_command(
              gid, cid, upd_map
            )
            Map.delete(rcmds, name)
        end
      end
    )
  end

  defp update_cmds_global(cmds) do
    remaining_cmds = cmds
    {:ok, ocmds} = Api.get_global_application_commands()

    Enum.reduce(
      ocmds, remaining_cmds,
      fn %{
        id: cid,
        name: name,
        description: odesc,
        default_permission: operm
      } = ocmd, rcmds ->
        oopts = Map.get(ocmd, :options)
        case Map.get(@commands, name) do
          nil ->
            Api.delete_global_application_command(cid)
            rcmds
          ncmd_mod ->
            upd_map = %{}
            ncmd = ncmd_mod.get
            ndesc = ncmd.description
            upd_map = if ndesc != odesc, do: Map.put(upd_map, :description, ndesc), else: upd_map
            nopts = Map.get(ncmd, :options)
            upd_map = if nopts != oopts, do: Map.put(upd_map, :options, nopts), else: upd_map
            nperm = Map.get(ncmd, :default_permission, true)
            upd_map = if nperm != operm, do: Map.put(upd_map, :default_permission, nperm), else: upd_map
            if upd_map != %{}, do: Api.edit_global_application_command(
              cid, upd_map
            )
            Map.delete(rcmds, name)
        end
      end
    )
  end

  def handle_cmd(%Interaction{data: %{name: name}} = interaction) do
    all_cmd = Map.merge(@commands, @ctrl_cmds)
    case Map.get(all_cmd, name) do
      nil -> Api.create_interaction_response(interaction, %{
        type: 4,
        data: %{
          content: "> The command entered was not recognized.",
          flags: 1 <<< 6
        }
      })
      cmd -> Api.create_interaction_response(interaction, %{
        type: 4,
        data: cmd.run(interaction)
      })
    end
  end
end
