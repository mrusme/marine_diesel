defmodule MarineDiesel.Error do
    @derive [Poison.Encoder]
    defstruct [
        :http_code,
        :message
    ]
end
