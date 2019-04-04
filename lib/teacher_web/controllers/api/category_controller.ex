defmodule TeacherWeb.Api.CategoryController do
  use TeacherWeb, :controller

  alias Teacher.Recordings

  def index(conn, %{"album_id" => album_id}) do
    album = Recordings.get_album!(album_id)
    render(conn, "show.json", category: album.category)
  end
end
