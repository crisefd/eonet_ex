defmodule EonetEx.Resource.Layers do
	@moduledoc false

@keys ~w(id title layers)a

defstruct @keys

use EonetEx.Client, name: :layers
@type t :: %__MODULE__{
        id: integer(),
        title: binary(),
        layers: [map()],
      }

end