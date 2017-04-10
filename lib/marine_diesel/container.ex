defmodule MarineDiesel.Container do
    @apiUrlBase "/containers"

    @derive [Poison.Encoder]
    defstruct [
        :Id,
        :Names,
        :Image,
        :ImageID,
        :Command,
        :Created,
        :State,
        :Status,
        :Ports,
        :Labels,
        :SizeRw,
        :SizeRootFs,
        :HostConfig,
        :NetworkSettings,
        :Mounts,
        :Hostname,
        :Domainname,
        :User,
        :AttachStdin,
        :AttachStdout,
        :AttachStderr,
        :ExposedPorts,
        :Tty,
        :OpenStdin,
        :StdinOnce,
        :Env,
        :Cmd,
        :Healthcheck,
        :ArgsEscaped,
        :Volumes,
        :WorkingDir,
        :Entrypoint,
        :NetworkDisabled,
        :MacAddress,
        :OnBuild,
        :Labels,
        :StopSignal,
        :StopTimeout,
        :Shell,
        :NetworkingConfig,
        :Warnings
    ]

    def index do
        case MarineDiesel.http_get("#{@apiUrlBase}/json") do
            {:ok, resp} ->
                respSelf = Poison.decode!(resp.body, as: [%MarineDiesel.Container{}])
                {:ok, respSelf}
            other -> other
        end
    end

    def show(%MarineDiesel.Container{}=self) do
        case MarineDiesel.http_get("#{@apiUrlBase}/#{Map.get(self, :Id)}/json") do
            {:ok, resp} ->
                respSelf = Poison.decode!(resp.body, as: %MarineDiesel.Container{})
                {:ok, respSelf}
            other -> other
        end
    end

    def create(%MarineDiesel.Container{}=self, name) do
        case MarineDiesel.http_post("#{@apiUrlBase}/create", self, %{}, %{ "name": name }) do
            {:ok, resp} ->
                respSelf = Poison.decode!(resp.body, as: %MarineDiesel.Container{})
                {:ok, self |> Map.put(:Id, Map.get(respSelf, :Id)) |> Map.put(:Warning, Map.get(respSelf, :Warning))}
            other -> other
        end
    end

    def destroy(%MarineDiesel.Container{}=self) do
        case MarineDiesel.http_delete("#{@apiUrlBase}/#{Map.get(self, :Id)}") do
            {:ok, resp} ->
                {:ok, nil}
            other -> other
        end
    end
end
