defmodule BkclbWeb.PostLive.Index do
  use BkclbWeb, :live_view

  alias Bkclb.BookClub
  alias Bkclb.BookClub.Post

  @impl true
  def mount(%{"room" => room}, _session, socket) do
    if connected?(socket), do: BookClub.subscribe(room)

    socket =
      socket
      |> assign(:posts, BuildTree.build_tree(list_posts(room)))
      |> assign(:room, room)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, BookClub.get_post!(id))
  end

  defp apply_action(socket, :new, %{"id" => parent_id, "room" => room}) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{parent_id: parent_id, room_id: room})
  end

  defp apply_action(socket, :new, %{"room" => room}) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{room_id: room})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = BookClub.get_post!(id)
    room = post.room_id
    {:ok, _} = BookClub.delete_post(post)

    {:noreply, assign(socket, :posts, list_posts(room))}
  end

  defp list_posts(room) do
    BookClub.list_posts(room)
  end

  @impl true
  @spec handle_info({:post_created, any}, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_info({:post_created, room}, socket) do
    {:noreply, assign(socket, :posts, BuildTree.build_tree(list_posts(room)))}
  end
end
