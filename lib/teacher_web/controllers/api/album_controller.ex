defmodule TeacherWeb.Api.AlbumController do
  use TeacherWeb, :controller

  alias Teacher.Recordings

  def index(conn, _params) do
    albums = Recordings.list_albums()
    render(conn, "index.json", albums: albums)
  end

  def show(conn, %{"id" => id}) do
    album = Recordings.get_album!(id)
    render(conn, "show.json", album: album)
  end
end
