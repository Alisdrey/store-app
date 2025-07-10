# lib/store_api_web/controllers/error_json.ex
defmodule StoreApiWeb.ErrorJSON do
  def render("401.json", _assigns) do
    %{error: "Unauthorized"}
  end

  def render("404.json", _assigns) do
    %{error: "Not found"}
  end

  def render("500.json", _assigns) do
    %{error: "Internal server error"}
  end
end
