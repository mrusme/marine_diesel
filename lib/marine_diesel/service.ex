defmodule MarineDiesel.Service do
    @apiUrlBase "/services"

    @derive [Poison.Encoder]
    defstruct [
        :Id,
        :Name,
        :Version,
        :CreatedAt,
        :UpdatedAt,
        :Spec,
        :Endpoint,
        :UpdateStatus,
        :Labels,
        :TaskTemplate,
        :Mode,
        :UpdateConfig,
        :Networks,
        :EndpointSpec,
        :Warning
    ]

    def index do
        case MarineDiesel.http_get("#{@apiUrlBase}") do
            {:ok, resp} ->
                respSelf = Poison.decode!(resp.body, as: [%MarineDiesel.Service{}])
                {:ok, respSelf}
            other -> other
        end
    end

    def show(%MarineDiesel.Service{}=self) do
        case MarineDiesel.http_get("#{@apiUrlBase}/#{Map.get(self, :Id)}") do
            {:ok, resp} ->
                respSelf = Poison.decode!(resp.body, as: %MarineDiesel.Service{})
                {:ok, respSelf}
            other -> other
        end
    end

    def create(%MarineDiesel.Service{}=self, x_registry_auth) do
        case MarineDiesel.http_post("#{@apiUrlBase}/create", self, x_registry_auth) do
            {:ok, resp} ->
                respSelf = Poison.decode!(resp.body, as: %MarineDiesel.Service{})
                {:ok, self |> Map.put(:Id, Map.get(respSelf, :Id)) |> Map.put(:Warning, Map.get(respSelf, :Warning))}
            other -> other
        end
    end

    def destroy(%MarineDiesel.Service{}=self) do
        case MarineDiesel.http_delete("#{@apiUrlBase}/#{Map.get(self, :Id)}") do
            {:ok, resp} ->
                {:ok, nil}
            other -> other
        end
    end
end
