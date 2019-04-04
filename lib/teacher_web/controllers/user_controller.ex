defmodule TeacherWeb.UserController do
  use TeacherWeb, :controller

  alias Teacher.Auth

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    render(conn, "show.html", user: user)
  end
end
