defmodule EonetEx do
	@moduledoc """
  Main mondule to interact with EONET service
  """

alias EonetEx.{
  Resource.Event,
  Resource.Category,
  Resource.Layers
}

	@doc """
	 Fetches data from https://eonet.sci.gsfc.nasa.gov/api/v2.1/events
	 You can pass in the query params

	 ## Examples
			iex(1)> EonetEx.events [status: "open"]
				{:ok,
				 %{
				   description: "Natural events from EONET.",
				   events: [
				     %{
				       categories: [%{id: 8, title: "Wildfires"}],
				       description: "",
				       id: "EONET_4503",
				       link: "https://eonet.sci.gsfc.nasa.gov/api/v2.1/events/EONET_4503",
				       sources: [
		         		%{id: "PDC", url: "http://emops.pdc.org/emops/?hazard_id=97871"}
		       			],
		       		 title: "Wildfires - Valparaiso and Casablanca Communes, Chile"
				       geometries: [
				         %{
				           coordinates: [-71.518788439, -33.200859147],
				           date: "2019-11-15T16:58:00Z",
				           type: "Point"
				         }
				       ]
			   			}
			   		...
			   	]
			  }
	"""

  defdelegate events(query \\ []), to: Event, as: :fetch

  @doc """
  	Fetches data from https://eonet.sci.gsfc.nasa.gov/api/v2.1/category
		You can pass in query params and the category id
  	## Examples
  	iex(2)> EonetEx.categories [status: "open"], 8
		{:ok,
		 %{
		   description: "Wildfires includes all nature of fire...",
		   events: [
		     %{
		       categories: [%{id: 8, title: "Wildfires"}],
		       description: "",
		       geometries: [
		         %{
		           coordinates: [-71.518788439, -33.200859147],
		           date: "2019-11-15T16:58:00Z",
		           type: "Point"
		         }
		       ],
		       id: "EONET_4503",
		       link: "https://eonet.sci.gsfc.nasa.gov/api/v2.1/events/EONET_4503",
		       sources: [
		         %{id: "PDC", url: "http://emops.pdc.org/emops/?hazard_id=97871"}
		       ],
		       title: "Wildfires - Valparaiso and Casablanca Communes, Chile"
		     },
  """
  defdelegate categories(query \\ [], category_id), to: Category, as: :fetch


  @doc """
  	Fetches data from https://eonet.sci.gsfc.nasa.gov/api/v2.1/layers/
		You can pass in the category id

  	## Examples:
  	iex(1)> EonetEx.layers 8
		{:ok,
		 %{
		   categories: [
		     %{
		       id: 8,
		       layers: [
		         %{
		           name: "AIRS_CO_Total_Column_Day",
		           parameters: [%{FORMAT: "image/png", TILEMATRIXSET: "2km"}],
		           serviceTypeId: "WMTS_1_0_0",
		           serviceUrl: "https://gibs.earthdata.nasa.gov/wmts/epsg4326/best/wmts.cgi"
		         },
		         ...
		       ]
		  }
  """

  defdelegate layers(query \\ [], category_id), to: Layers, as: :fetch 

end
