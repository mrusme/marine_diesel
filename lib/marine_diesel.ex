defmodule MarineDiesel do
    @moduledoc """
    MarineDiesel Elixir Docker API client library.
    """

    use HTTPoison.Base

    @apiVersion "v1.27"
    @apiHeaders %{
        "Content-Type": "application/json; Charset=utf-8",
        "Accept": "application/json; Charset=utf-8"
    }

    defp config_docker, do: Application.get_env(:marine_diesel, :docker)
    defp config_ssl, do: Application.get_env(:marine_diesel, :ssl)

    defp proto do
        case is_nil(config_ssl()) do
            true -> "http"
            false -> "https"
        end
    end

    defp baseurl do
        docker = config_docker()
        "#{proto()}://#{docker[:host]}:#{docker[:port]}/#{@apiVersion}"
    end

    defp hackney_options do
        ssl = config_ssl()

        case is_nil(ssl) do
            true -> [:insecure]
            false -> [ssl_options: ssl]
        end
    end

    defp http_response_converter(resp) do
        case resp.status_code do
            x when x >= 200 and x <= 299 ->
                {:ok, resp}
            _ ->
                respErr = Poison.decode!(resp.body, as: %MarineDiesel.Error{})
                {:error, respErr |> Map.put(:http_code, resp.status_code)}
        end
    end

    def http_get(url, headers \\ %{}, parameters \\ %{}) do
        case get "#{baseurl()}#{url}", Map.merge(@apiHeaders, headers), [hackney: hackney_options(), params: parameters] do
            {:ok, resp} -> http_response_converter(resp)
            other -> other
        end
    end

    def http_post(url, data, headers \\ %{}, parameters \\ %{}) do
        case post "#{baseurl()}#{url}", data |> Poison.encode!, Map.merge(@apiHeaders, headers), [hackney: hackney_options()] do
            {:ok, resp} -> http_response_converter(resp)
            other -> other
        end
    end

    def http_delete(url, headers \\ %{}, parameters \\ %{}) do
        case delete "#{baseurl()}#{url}", Map.merge(@apiHeaders, headers), [hackney: hackney_options(), params: parameters] do
            {:ok, resp} -> http_response_converter(resp)
            other -> other
        end
    end
end
