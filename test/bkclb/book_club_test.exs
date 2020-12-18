defmodule Bkclb.BookClubTest do
  use Bkclb.DataCase

  alias Bkclb.BookClub

  describe "posts" do
    alias Bkclb.BookClub.Post

    @valid_attrs %{body: "some body", parent_id: 42, username: "some username"}
    @update_attrs %{body: "some updated body", parent_id: 43, username: "some updated username"}
    @invalid_attrs %{body: nil, parent_id: nil, username: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BookClub.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert BookClub.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert BookClub.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = BookClub.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.parent_id == 42
      assert post.username == "some username"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BookClub.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = BookClub.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.parent_id == 43
      assert post.username == "some updated username"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = BookClub.update_post(post, @invalid_attrs)
      assert post == BookClub.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = BookClub.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> BookClub.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = BookClub.change_post(post)
    end
  end
end
