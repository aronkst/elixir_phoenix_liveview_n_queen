defmodule ElixirPhoenixLiveviewNQueenWeb.NQueenLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, number: 4, type: "text", one: false, loading: false, chess: queen(4, false))}
  end

  def handle_event("submit", %{"type" => type, "one" => _, "number" => number}, socket) do
    send(self(), %{"one" => true, "number" => number})
    {:noreply, assign(socket, form_values(type, true, number, true))}

  end

  def handle_event("submit", %{"type" => type, "number" => number}, socket) do
    send(self(), %{"one" => false, "number" => number})
    {:noreply, assign(socket, form_values(type, false, number, true))}
  end

  def handle_info(%{"one" => one, "number" => number}, socket) do
    {:noreply, assign(socket, chess: queen(convert_number(number), one), loading: false)}
  end

  def render(assigns) do
    ~L"""
    <h1>N Queens</h1>
    <form phx-change="submit">
      <input type="radio" id="text" name="type" value="text" <%= if @type == "text" do %>checked<% end %> />
      <label for="text">text</label>
      <input type="radio" id="graphic" name="type" value="graphic" <%= if @type == "graphic" do %>checked<% end %> />
      <label for="graphic">graphic</label>
      <br />
      <input type="checkbox" id="one" name="one" value="true" <%= if @one do %>checked<% end %> />
      <label for="one">show only one chessboard?</label>
      <br />
      <input type="number" min="4" name="number" value="<%= @number %>" />
    </form>
    <hr />
    <%= if @loading do %>
      <p>Loading...</p>
    <% else %>
      <%= if @type == "graphic" do %>
        <%= for t <- String.split(@chess, "\n") do %>
          <%= case t do %>
            <% "<" -> %>
              <table class="chessboard">  
            <% ">" -> %>
              </table>
            <% _ -> %>
              <tr class="chessboard">
                <%= for ta <- String.splitter(t, "", trim: true) do %>
                  <%= if ta == "." do %>
                    <td class="chessboard"></td>
                  <% else %>
                    <td class="chessboard">&#9813;</td>
                  <% end %>
                <% end %>
              </tr>
          <% end %>
        <% end %>
      <% else %>
        <pre><%= @chess |> String.replace("<", "") |> String.replace(">", "") %></pre>
      <% end %>
    <% end %>
    """
  end

  defp form_values(type, one, number, loading) do
    %{type: type, one: one, number: convert_number(number), loading: loading}
  end

  defp convert_number(number) do
    number = String.to_integer(number)
    if number < 4 do
      4
    else
      number
    end
  end

  defp queen(n, one) do
    solve(n, [], [], [], one)
  end
 
  defp solve(n, row, _, _, _) when n == length(row) do
    solve(n, row)
  end

  defp solve(n, row, add_list, sub_list, one) do
    Enum.reduce_while(Enum.to_list(0..n - 1) -- row, "", fn x, t ->
      if one && String.contains?(t, "<") do
        {:halt, t}
      else
        add = x + length(row)
        sub = x - length(row)
        if (add in add_list) or (sub in sub_list) do
          {:cont, t}
        else
          {:cont, t <> solve(n, [x|row], [add | add_list], [sub | sub_list], one)}
        end
      end
    end)
  end
 
  defp solve(n, row) do
    "<\n" <> Enum.reduce(row, "", fn x, t ->
      line = Enum.map_join(0..n - 1, fn i -> if x == i, do: "Q", else: "." end)
      t <> line <> "\n"
    end) <> ">\n"
  end
end