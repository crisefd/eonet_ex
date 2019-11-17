defmodule EonetEx.Resource.Category do
	@moduledoc false

@keys ~w(id title description link layers)a

defstruct @keys

use EonetEx.Client, name: :categories

@type t :: %__MODULE__{
        id: integer(),
        title: binary(),
        description: binary(),
        link: binary(),
        layers: binary(),
      }

end