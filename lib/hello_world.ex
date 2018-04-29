defmodule HelloWorld do
  @webhook_url Application.fetch_env!(:hello_world, :webhook_url)

  def speak(message) when is_binary(message) do
    message 
    |> encode_body
    |> make_request
  end
  def speak(_), do: IO.puts "You did it wrong, bro!"
  def speak, do: IO.puts "What do you want me to say?"

  defp make_request(data) do
    HTTPoison.post @webhook_url, data, [{"Content-Type", "application/json"}]
  end

  defp encode_body(message) do
    Poison.encode! %{ text: message }
  end
end
