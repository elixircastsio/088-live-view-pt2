defmodule TeacherWeb.Api.CategoryView do
  use TeacherWeb, :view

  def render("show.json", %{category: category}) do
    render_one(category, TeacherWeb.Api.CategoryView, "category.json")
  end

  def render("category.json", %{category: category}) do
    %{id: category.id, name: category.name}
  end
end
