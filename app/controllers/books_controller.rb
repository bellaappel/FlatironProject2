class BooksController < ApplicationController

  # GET: /books
  get "/books" do
    @books = Book.all
    erb :"/books/index"
  end

  # GET: /books/new
  get "/books/new" do
    if Helper.is_logged_in?(session)
      erb :"/books/new"
    else
      "Please log in to add a book to your trade-library."
    end
  end

  # POST: /books
  post "/books" do
    # hash_to_pass = params[:book]
    # hash_to_pass["user_id"] = session[:user_id]
    # new_book = Book.create(hash_to_pass)
    Helper.current_user(session).books.build(params[:book]).save
    redirect "/books"
  end

  # GET: /books/5
  get "/books/:id" do
    @book = Book.find(params[:id])
    @owner = User.find(@book.user_id)
    erb :"/books/show"
  end

  # GET: /books/5/edit
  get "/books/:id/edit" do
    @book = Book.find(params[:id])
    if @book.user_id == Helper.current_user(session).id
      erb :"/books/edit"
    else
      "You can't edit books you don't own."
    end
  end

  # PATCH: /books/5
  patch "/books/:id" do
    Book.find(params[:id]).update(params[:book])
    redirect "/books/#{params[:id]}"
  end

  get "/books/:id/delete" do
    @book = Book.find(params[:id])
    if @book.user_id == Helper.current_user(session).id
      erb :"/books/delete"
    else
      "You cannot delete books you don't own."
    end

  end

  # DELETE: /books/5/delete
  delete "/books/:id" do
    redirect "/books"
  end
  
end
