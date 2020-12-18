defmodule BkclbWeb.PostLive.Index do
  use BkclbWeb, :live_view

  alias Bkclb.BookClub
  alias Bkclb.BookClub.Post

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: BookClub.subscribe()
    {:ok, assign(socket, :posts, BuildTree.build_tree(list_posts()))}
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

  defp apply_action(socket, :new, %{"id" => parent_id}) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{parent_id: parent_id})
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = BookClub.get_post!(id)
    {:ok, _} = BookClub.delete_post(post)

    {:noreply, assign(socket, :posts, list_posts())}
  end

  defp list_posts do
    BookClub.list_posts()
  end

  @impl
  def handle_info({:post_created, post}, socket) do
    {:noreply, update(socket, :posts, fn posts -> BuildTree.build_tree([post | posts]) end)}
  end
end
