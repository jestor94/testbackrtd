defmodule TestResuelveWeb.PageLive do
  use TestResuelveWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket,
      error: init_error(),
      mins: init_mins(),
      json_result: "",
      edit_value: init_edit_value()
    )}
  end

  def handle_event("update_form", %{"json" => ""}, socket) do
    {:noreply, assign(socket, error: init_error(), json_result: "")}
  end

  def handle_event("update_form", %{"json" => json}, socket) do
    json
    |> Poison.decode
    |> validate_decode(socket)
  end

  def handle_event("change_value", %{"name" => name}, socket) do
    edit_value = socket.assigns.mins
    |> Enum.find(fn m -> m.name == name end)
    edit_value = edit_value
      |> Map.put(:original_name, edit_value.name)
    {:noreply, assign(socket,
      json_result: "",
      edit_value: edit_value,
      error: init_error()
    )}
  end

  def handle_event("exit_edit", _params, socket) do
    {:noreply, assign(socket, edit_value: init_edit_value())}
  end

  def handle_event("update_edit", %{"name" => name, "value" => ""}, socket) do
    edit_value = socket.assigns.edit_value
      |> Map.put(:name, name)
      |> Map.put(:value, 0)
    {:noreply, assign(socket, edit_value: edit_value )}
  end

  def handle_event("update_edit", %{"name" => name, "value" => value}, socket) do
    edit_value = socket.assigns.edit_value
      |> Map.put(:name, name)
      |> Map.put(:value, value |> String.to_integer)
    {:noreply, assign(socket, edit_value: edit_value )}
  end

  def handle_event("save_edit", _params, socket) do
    edit_value = socket.assigns.edit_value
    mins = socket.assigns.mins
    |> Enum.map(fn m -> if m.name == edit_value.original_name,
      do: %{name: edit_value.name, value: edit_value.value},
      else: m
    end)
    {:noreply, assign(socket, mins: mins, edit_value: init_edit_value())}
  end

  defp validate_decode({:error, _error}, socket) do
    {:noreply, assign(socket, error: init_error("Ingresa un Json válido, por favor"))}
  end

  defp validate_decode({:ok, value}, socket) do
    arr_team = value["jugadores"]
    |> Enum.group_by(fn v -> v["equipo"] end)
    |> Enum.map(fn {_k,  v} -> v |> calcule(socket.assigns.mins) end)
    arr = arr_team
    |> List.flatten
    {:noreply, assign(socket,
      error: init_error(),
      arr_team: arr_team,
      json_result: %{"jugadores" => arr} |> Poison.encode!
    )}
  end

  def calcule(arr, mins) do
    goal_total_team = arr
    |> get_goal_total_team
    goal_total_team_ideal = arr
    |> get_goal_total_team_ideal(mins)
    total_team = goal_total_team / goal_total_team_ideal
    arr
    |> calcule_individual(total_team, mins, [])
  end

  defp calcule_individual([player | others], total_team, mins, new_arr) do
    total_individual = player["goles"] / (player["nivel"] |> get_mins_value(mins))
    bond = ((total_team + total_individual) / 2) * player["bono"]
    player = player
    |> Map.put("sueldo_completo", bond + player["sueldo"])
    calcule_individual(others, total_team, mins, new_arr ++ [player])
  end

  defp calcule_individual([], _total_team, _mins, new_arr), do: new_arr

  defp get_goal_total_team(arr) do
    arr
    |> Enum.map(fn g -> g["goles"] end)
    |> Enum.sum
  end

  defp get_goal_total_team_ideal(arr, mins) do
    arr
    |> Enum.map(fn g -> g["nivel"] |> get_mins_value(mins) end)
    |> Enum.sum
  end

  defp get_mins_value(name, mins) do
    mins
    |> Enum.find(fn m -> m.name == name end)
    |> case do
      nil -> 0
      val -> val.value
    end
  end

  def init_edit_value() do
    Map.new
    |> Map.put(:name, nil)
    |> Map.put(:value, 0)
  end

  defp init_error(), do:
    Map.new
    |> Map.put(:status, false)
    |> Map.put(:message, "")

  defp init_error(message), do:
    Map.new
    |> Map.put(:status, true)
    |> Map.put(:message, message)

  defp init_mins() do
    [
      Map.new
      |> Map.put(:name, "A")
      |> Map.put(:value, 5),
      Map.new
      |> Map.put(:name, "B")
      |> Map.put(:value, 10),
      Map.new
      |> Map.put(:name, "C")
      |> Map.put(:value, 15),
      Map.new
      |> Map.put(:name, "Cuauh")
      |> Map.put(:value, 20),
    ]
  end

end