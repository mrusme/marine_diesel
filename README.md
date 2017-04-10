# MarineDiesel

Elixir client library for the Docker API.
Currently supported API versions:

- 1.27

## Supported Docker API features

- [x] [Versioning](https://docs.docker.com/engine/api/v1.27/#section/Versioning)
- [ ] [Containers](https://docs.docker.com/engine/api/v1.27/#tag/Container)
	- [x] [List containers](https://docs.docker.com/engine/api/v1.27/#operation/ContainerList):
	- [x] [Create container](https://docs.docker.com/engine/api/v1.27/#operation/ContainerCreate)
		- [x] Query parameter: `name`
	- [x] [Inspect container](https://docs.docker.com/engine/api/v1.27/#operation/ContainerInspect)
- [ ] Query parameter: `size`
	- [x] [Remove a container](https://docs.docker.com/engine/api/v1.27/#operation/ContainerDelete)
		- [ ] Query parameter: `v`
		- [ ] Query parameter: `force`
		- [ ] Query parameter: `link`
- [ ] [Images](https://docs.docker.com/engine/api/v1.27/#tag/Image)
- [x] [Networks](https://docs.docker.com/engine/api/v1.27/#tag/Network)
	- [x] [List Networks](https://docs.docker.com/engine/api/v1.27/#operation/NetworkList)
		- [ ] Query parameter: `filters`
	- [x] [Inspect network](https://docs.docker.com/engine/api/v1.27/#operation/NetworkInspect)
	- [x] [Remove network](https://docs.docker.com/engine/api/v1.27/#operation/NetworkDelete)
	- [x] [Create network](https://docs.docker.com/engine/api/v1.27/#operation/NetworkCreate)
	- [ ] [Connect a container to a network](https://docs.docker.com/engine/api/v1.27/#operation/NetworkConnect)
	- [ ] [Disconnect a container from a network](https://docs.docker.com/engine/api/v1.27/#operation/NetworkDisconnect)
	- [ ] [Delete unused networks](https://docs.docker.com/engine/api/v1.27/#operation/NetworkPrune)
		- [ ] Query parameter: `filters`
- [ ] [Volumes](https://docs.docker.com/engine/api/v1.27/#tag/Volume)
- [ ] [Exec](https://docs.docker.com/engine/api/v1.27/#tag/Exec)
- [ ] [Swam](https://docs.docker.com/engine/api/v1.27/#tag/Swarm)
- [ ] [Nodes](https://docs.docker.com/engine/api/v1.27/#tag/Node)
- [x] [Services](https://docs.docker.com/engine/api/v1.27/#tag/Service)
	- [x] [List services](https://docs.docker.com/engine/api/v1.27/#operation/ServiceList)
		- [ ] Query parameter: `filters`
	- [x] [Create service](https://docs.docker.com/engine/api/v1.27/#operation/ServiceCreate)
		- [x] Header: `X-Registry-Auth`
	- [x] [Inspect service](https://docs.docker.com/engine/api/v1.27/#operation/ServiceInspect)
	- [x] [Delete service](https://docs.docker.com/engine/api/v1.27/#operation/ServiceDelete)
	- [ ] [Update service](https://docs.docker.com/engine/api/v1.27/#operation/ServiceUpdate)
		- [ ] Query parameter: `version`
		- [ ] Query parameter: `registryAuthFrom`
		- [x] Header: `X-Registry-Auth`
	- [ ] [Get service logs](https://docs.docker.com/engine/api/v1.27/#operation/ServiceLogs)
		- [ ] Query parameter: `details`
		- [ ] Query parameter: `follow`
		- [ ] Query parameter: `stdout`
		- [ ] Query parameter: `stderr`
		- [ ] Query parameter: `since`
		- [ ] Query parameter: `timestamps`
		- [ ] Query parameter: `tail`
- [ ] [Tasks](https://docs.docker.com/engine/api/v1.27/#tag/Task)
- [ ] [Secrets](https://docs.docker.com/engine/api/v1.27/#tag/Secret)
- [ ] [Plugins](https://docs.docker.com/engine/api/v1.27/#tag/Plugin)
- [ ] [System](https://docs.docker.com/engine/api/v1.27/#tag/System)

## Other todos

- [ ] [Write proper documentation](http://yos.io/2016/04/28/writing-and-publishing-elixir-libraries/#write-documentation)
- [ ] [Add doctests](http://yos.io/2016/04/28/writing-and-publishing-elixir-libraries/#add-doctests)
- [ ] [Add type annotations](http://yos.io/2016/04/28/writing-and-publishing-elixir-libraries/#add-type-annotations)

## Installation

Add `marine_diesel` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:marine_diesel, "~> 0.1.0"}]
end
```

Add `marine_diesel` to your `applications`:

```elixir
def application do
  [applications: [:marine_diesel]]
end
```

Configure `marine_diesel` in your `config/config.exs`:

```elixir
config :marine_diesel,
	docker: [
		host: "192.168.99.100",
		port: 2376
	],
	ssl: [
		cacertfile: "certs/ca.crt",
		certfile: "certs/client.crt",
		keyfile: "certs/client.key",
		password: 'test'
	]
```

If you don't want to use SSL (although you really should), you can simply leave the `ssl:` portion away (although you really shouldn't).

## Example usage

```elixir
    import MarineDiesel.Network

    ...

    IO.inspect MarineDiesel.Network.index()

    net = %MarineDiesel.Network{
        Name: "isolated_nw",
        CheckDuplicate: false,
        Driver: "bridge",
        EnableIPv6: false,
        IPAM: %{
            Driver: "default",
            Config: [
                %{
                    Subnet: "172.24.0.0/16",
                    IPRange: "172.24.11.0/24",
                    Gateway: "172.24.11.11"
                }
            ]
        },
        Internal: true,
        Attachable: false,
        Options: %{
            "com.docker.network.bridge.default_bridge": "false",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.name": "docker5",
            "com.docker.network.driver.mtu": "1500"
        },
        Labels: %{}
    }

    createdNet = net 
    |> create

    IO.inspect createdNet

    IO.inspect createdNet 
    |> show

    IO.inspect createdNet
    |> destroy

    ...

```
