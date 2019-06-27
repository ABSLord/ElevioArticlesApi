defmodule Server.Router do
  use Plug.Router
  use Plug.Debugger
  use Application
  require Logger
  require HTTPoison
  plug(Plug.Logger, log: :debug)

  plug(:match)

  plug(:dispatch)

  @api_url "https://api.elev.io/v1"
  @api_key Application.get_env(:server, :api_key)
  @token Application.get_env(:server, :token)
  @headers  ["Authorization": "Bearer #{@token}", "x-api-key": "#{@api_key}", "Content-type": "application/json"]

  get "/articles" do
    conn = fetch_query_params(conn)
    page_num = Map.get(conn.query_params, "page_num")
    page_size = Map.get(conn.query_params, "page_size")
    keyword = Map.get(conn.query_params, "keyword")
    @api_url <> "/articles?page=#{page_num}&page_size=#{page_size}"
    |> HTTPoison.get(@headers, options: %{page: page_num, page_size: page_size})
    |> case do
         {:ok, %{body: data, status_code: code}} -> #send_resp(conn, code, data)
            if keyword do
              parse_data = Poison.decode!(data)
              result = Enum.filter(parse_data["articles"], fn(article) ->
                Enum.member?(article["keywords"], keyword)
              end)
              #IO.inspect parse_data
              send_resp(conn, code, Poison.encode!(result))
            else
              send_resp(conn, code, data)
            end
         _ -> send_resp(conn, 400, "Unknown error")
       end
  end

  get "/articles/:id" do
    @api_url <> "/articles/" <> id
    |> HTTPoison.get(@headers)
    |> case do
         {:ok, %{body: data, status_code: code}} -> send_resp(conn, code, data)
         _ -> send_resp(conn, "400", "Unknown error")
       end
  end

  match _ do

    send_resp(conn, 404, "not found")

  end

end