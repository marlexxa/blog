class ArticlesController < ApplicationController
  before_action :not_logged_in, only: :new
  before_action :not_found, :incorrect_user, only: %i[edit update destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
    if @article.save
      format.html {redirect_to @article, notice: 'Article was successfully created!'}
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    respond_to do |format|
    if @article.update(post_params)
      format.html { redirect_to article_url(@article), notice: "Article was successfully updated!" }
    else
      format.html { render :edit, status: :unprocessable_entity }
    end
  end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
    flash[:notice] = 'Article was successfully deleted!'
  end

  private
    def not_logged_in
      redirect_to log_in_path unless current_user
      flash[:notice] = 'You must be logged in to publish.'
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found') unless current_user
    end

    def incorrect_user
      @article = Article.find(params[:id])
      raise ActionController::RoutingError.new('Not Found') unless current_user && current_user == @article.user
    end

    def article_params
      params.require(:article).permit(:title, :body, :status, :user_id)
    end

end
