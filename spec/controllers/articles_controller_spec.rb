require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Article. As you add validations to Article, be sure to
  # adjust the attributes here as well.
  let(:author) do
    user = FactoryGirl.create(:user)
    user.grant_role!("author")
    user
  end

  let(:valid_attributes) {
    { title: "Test Article", body: "Test Article Content", user_id: author.id, feature_photo_url: "spec/fixtures/images/cat.jpg" }
  }

  let(:invalid_attributes) {
    { title: "", body: "Test Article Content", user_id: author.id }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ArticlesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all articles as @articles" do
      article = Article.create! valid_attributes
      get :index, {}
      expect(assigns(:articles)).to eq([article])
    end
  end

  describe "GET #show" do
    it "assigns the requested article as @article" do
      article = Article.create! valid_attributes
      get :show, {id: article.to_param}
      expect(assigns(:article)).to eq(article)
    end
  end

  describe "GET #new" do
    context "when not authorized" do
      it "redirects to the login_url" do
        get :new, {}
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when authorized as an author" do
      before { sign_in(author) }

      it "assigns a new article as @article" do
        get :new, {}
        expect(assigns(:article)).to be_a_new(Article)
      end
    end
  end

  describe "GET #edit" do
    context "when authorized as an author" do
      before { sign_in(author) }

      it "assigns the requested article as @article" do
        article = Article.create! valid_attributes
        get :edit, {id: article.to_param}
        expect(assigns(:article)).to eq(article)
      end
    end
  end

  describe "POST #create" do
    context "when not authorized as an author" do
      before { sign_in(FactoryGirl.create(:user)) }

      it "does not create a new Article" do
        expect {
          post :create, {article: valid_attributes}
        }.not_to change(Article, :count)
      end

      it "redirects to the created article" do
        post :create, {article: valid_attributes}
        expect(response).to redirect_to(root_url)
      end
    end

    context "when authorized as an author" do
      before { sign_in(author) }

      context "with valid params" do
        it "creates a new Article" do
          expect {
            post :create, {article: valid_attributes}
          }.to change(Article, :count).by(1)
        end

        it "assigns a newly created article as @article" do
          post :create, {article: valid_attributes}
          expect(assigns(:article)).to be_a(Article)
          expect(assigns(:article)).to be_persisted
        end

        it "redirects to the created article" do
          post :create, {article: valid_attributes}
          expect(response).to redirect_to(Article.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved article as @article" do
          post :create, {article: invalid_attributes}
          expect(assigns(:article)).to be_a_new(Article)
        end

        it "re-renders the 'new' template" do
          post :create, {article: invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end
  end

  describe "PUT #update" do
    context "when authorized as an author" do
      before { sign_in(author) }

      context "with valid params" do
        let(:new_attributes) {
          skip("Add a hash of attributes valid for your model")
        }

        it "updates the requested article" do
          article = Article.create! valid_attributes
          put :update, {id: article.to_param, article: new_attributes}
          article.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested article as @article" do
          article = Article.create! valid_attributes
          put :update, {id: article.to_param, article: valid_attributes}
          expect(assigns(:article)).to eq(article)
        end

        it "redirects to the article" do
          article = Article.create! valid_attributes
          put :update, {id: article.to_param, article: valid_attributes}
          expect(response).to redirect_to(article)
        end
      end

      context "with invalid params" do
        it "assigns the article as @article" do
          article = Article.create! valid_attributes
          put :update, {id: article.to_param, article: invalid_attributes}
          expect(assigns(:article)).to eq(article)
        end

        it "re-renders the 'edit' template" do
          article = Article.create! valid_attributes
          put :update, {id: article.to_param, article: invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "when authorized as an author" do
      before { sign_in(author) }

      it "destroys the requested article" do
        article = Article.create! valid_attributes
        expect {
          delete :destroy, {id: article.to_param}
        }.to change(Article, :count).by(-1)
      end

      it "redirects to the articles list" do
        article = Article.create! valid_attributes
        delete :destroy, {id: article.to_param}
        expect(response).to redirect_to(articles_url)
      end
    end
  end
end
