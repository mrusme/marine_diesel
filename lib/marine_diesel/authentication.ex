defmodule MarineDiesel.Authentication do
    @derive [Poison.Encoder]
    defstruct [
        :username,
        :password,
        :email,
        :serveraddress,
        :identitytoken
    ]

    def x_registry_auth(%MarineDiesel.Authentication{}=self) do
        %{ "X-Registry-Auth": self |> Poison.encode! |> Base.encode64 }
    end
end
