defmodule EonetEx.Resource.Event do
	@moduledoc false
	
@keys ~w(id title description link categories sources geometries)a

defstruct @keys

use EonetEx.Client, name: :events

@type t :: %__MODULE__ {
        id: integer(),
        title: binary(),
        description: binary(),
        link: binary(),
        categories: [map()],
        sources: [map()],
        geometries: [map()]
      }

end