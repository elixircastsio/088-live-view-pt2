defmodule TeacherWeb.AlbumLive.Index do
  use Phoenix.LiveView

  alias Teacher.Recordings
  alias TeacherWeb.AlbumView
  alias TeacherWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    albums = Recordings.list_albums()
    {:ok, assign(socket, albums: albums, editable_id: nil)}
  end

  def render(assigns) do
    AlbumView.render("index.html", assigns)
  end

  def handle_event("edit" <> album_id, _, socket) do
    album_id = String.to_integer(album_id)
    changeset = socket.assigns.albums
      |> Enum.find(&(&1.id == album_id))
      |> Recordings.change_album()
      |> Map.put(:action, :update)
    {:noreply, assign(socket, changeset: changeset, editable_id: album_id)}
  end

  def handle_event("save", %{"id" => album_id, "album" => album_params}, socket) do
    album_id = String.to_integer(album_id)
    album = Enum.find(socket.assigns.albums, &(&1.id == album_id))
    case Recordings.update_album(album, album_params) do
      {:ok, _album} ->
        {:stop,
          socket
          |> put_flash(:info, "Album updated successfully")
          |> redirect(to: Routes.album_path(socket, :index))}
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
