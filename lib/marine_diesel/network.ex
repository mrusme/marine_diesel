defmodule MarineDiesel.Network do
    @apiUrlBase "/networks"

    @derive [Poison.Encoder]
    defstruct [
        :Id,
        :Name,
        :Created,
        :Scope,
        :CheckDuplicate,
        :Driver,
        :EnableIPv6,
        :IPAM,
        :Internal,
        :Attachable,
        :Containers,
        :Options,
        :Labels,
        :Warning
    ]

    def index do
        case MarineDiesel.http_get("#{@apiUrlBase}") do
            {:ok, resp} ->
                respSelf = Poison.decode!(resp.body, as: [%MarineDiesel.Network{}])
                {:ok, respSelf}
            other -> other
        end
    end

    def show(%MarineDiesel.Network{}=self) do
        case MarineDiesel.http_get("#{@apiUrlBase}/#{Map.get(self, :Id)}") do
            {:ok, resp} ->
                respSelf = Poison.decode!(resp.body, as: %MarineDiesel.Network{})
                {:ok, respSelf}
            other -> other
        end
    end

    def create(%MarineDiesel.Network{}=self) do
        case MarineDiesel.http_post("#{@apiUrlBase}/create", self) do
            {:ok, resp} ->
                respSelf = Poison.decode!(resp.body, as: %MarineDiesel.Network{})
                {:ok, self |> Map.put(:Id, Map.get(respSelf, :Id)) |> Map.put(:Warning, Map.get(respSelf, :Warning))}
            other -> other
        end
    end

    def destroy(%MarineDiesel.Network{}=self) do
        case MarineDiesel.http_delete("#{@apiUrlBase}/#{Map.get(self, :Id)}") do
            {:ok, resp} ->
                {:ok, nil}
            other -> other
        end
    end
end
