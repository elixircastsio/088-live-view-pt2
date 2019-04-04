defmodule TeacherWeb.Api.AlbumView do
  use TeacherWeb, :view

  def render("index.json", %{albums: albums}) do
    %{data: render_many(albums, TeacherWeb.Api.AlbumView, "album.json")}
  end

  def render("show.json", %{album: album}) do
    %{data: render_one(album, TeacherWeb.Api.AlbumView, "album.json")}
  end

  def render("album.json", %{album: album}) do
    %{
      id: album.id,
      artist: album.artist,
      title: album.title,
      category: render_one(album.category, TeacherWeb.Api.CategoryView, "category.json")
    }
  end
end
