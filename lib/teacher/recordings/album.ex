defmodule Teacher.Recordings.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :artist, :string
    field :summary, :string
    field :title, :string
    field :year, :string
    belongs_to :category, Teacher.Recordings.Category

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:artist, :title, :summary, :year, :category_id])
    |> validate_required([:artist, :title, :summary, :year, :category_id])
    |> validate_length(:summary, min: 3)
  end
end
