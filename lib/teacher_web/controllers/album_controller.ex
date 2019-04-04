defmodule TeacherWeb.AlbumController do
  use TeacherWeb, :controller

  alias Teacher.Recordings
  alias Teacher.Recordings.Album
  alias Phoenix.LiveView
  alias TeacherWeb.AlbumLive.Index

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, Index, session: %{})
  end

  def new(conn, _params) do
    changeset = Recordings.change_album(%Album{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"album" => album_params}) do
    case Recordings.create_album(album_params) do
      {:ok, album} ->
        conn
        |> put_flash(:info, "Album created successfully.")
        |> redirect(to: Routes.album_path(conn, :show, album))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    album = Recordings.get_album!(id)
    render(conn, "show.html", album: album)
  end

  def edit(conn, %{"id" => id}) do
    album = Recordings.get_album!(id)
    changeset = Recordings.change_album(album)
    render(conn, "edit.html", album: album, changeset: changeset)
  end

  def update(conn, %{"id" => id, "album" => album_params}) do
    album = Recordings.get_album!(id)

    case Recordings.update_album(album, album_params) do
      {:ok, album} ->
        conn
        |> put_flash(:info, "Album updated successfully.")
        |> redirect(to: Routes.album_path(conn, :show, album))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", album: album, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    album = Recordings.get_album!(id)
    {:ok, _album} = Recordings.delete_album(album)

    conn
    |> put_flash(:info, "Album deleted successfully.")
    |> redirect(to: Routes.album_path(conn, :index))
  end
end
