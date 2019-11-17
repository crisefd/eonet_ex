defmodule EonetEx.Client do
  @moduledoc """
  Internal module for API communication
  """
  defmacro __using__(opts) do
    quote do
      require EonetEx.Client
      import EonetEx.Client
      require Logger

      @name unquote(opts) |> Keyword.fetch!(:name) |> to_string()
      
      @base_url ~s(https://eonet.sci.gsfc.nasa.gov/api/v2.1)
      @headers ["User-Agent": "EonetEx"]

      @type data :: %{data: [t]}
      @type reason :: atom | binary
      @type error :: {:error, reason}
      @type success :: {:ok, struct} | {:ok, data}
      @type result :: success | error

      @spec fetch(keyword(), integer()) :: result

      def fetch(query, category_id \\ nil) do
        [@base_url, @name, category_id]
        |> full_url(query)
        |> HTTPoison.get(@headers)
        |> handle_response()
      end

      @spec full_url(binary(), keyword()) :: binary()

      defp full_url(url_parts, query) do
        url = join_url_parts(url_parts)
        query_params =
          query
          |> Enum.map(fn {k, w} -> "#{k}=#{w}" end)
          |> Enum.join("&")

        if query_params != "" do
          "#{url}?#{query_params}"
        else
          url
        end
      end

      defp join_url_parts(parts), do: join_url_parts(parts, "")

      defp join_url_parts([], url), do: url

      defp join_url_parts([nil | []], url), do: url

      defp join_url_parts([ part | parts], "") do
        join_url_parts(parts, "#{part}")
      end

      defp join_url_parts([ part | parts], url) do
        join_url_parts(parts, url <> "/#{part}")
      end

      @spec handle_response(response: map()) :: map()

      defp handle_response(response)

      defp handle_response({_, %{status_code: status_code, body: body}}) do
        data =
          case check_for_errors(status_code, body) do
            {:error, _} -> []
            data -> data
          end

        {:ok, data}
      end

      @spec check_for_errors(integer(), binary()) :: map()

      defp check_for_errors(status_code, body)

      defp check_for_errors(200, body), do: body |> parse_data()

      defp check_for_errors(_, body), do: {:error, body}

      @spec parse_data(binary()) :: map()

      defp parse_data(data) do
        data
        |> Poison.decode!(keys: :atoms)
      end

    end
  end
end
