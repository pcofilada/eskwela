defmodule Eskwela.Router do
  use Eskwela.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug Eskwela.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Eskwela do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/levels", LevelController do
      resources "/subjects", SubjectController, except: [:index, :show]
    end
    resources "/questions", QuestionController do
      resources "/choices", ChoiceController, except: [:index, :show] do
        patch "/set_answer", ChoiceController, :set_answer, as: :set_answer
      end
    end
    resources "/choices", ChoiceController

    get "/sign_up", RegistrationController, :new
    post "/sign_up", RegistrationController, :create
    get "/sign_in", SessionController, :new
    post "/sign_in", SessionController, :create
    delete "/sign_out", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Eskwela do
  #   pipe_through :api
  # end
end
