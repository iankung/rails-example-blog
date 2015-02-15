class ArticlesController < ApplicationController
    
    http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

 
    ##most actions have a corresponding view, don't need a view if there is a redirect
 
    def index
        @articles = Article.all
    end

    
    def show
        @article = Article.find(params[:id])  ##rails passes all @instancevariables to the view
    end

    def new
        @article = Article.new   ##done so @article is an instance variable passed to 'new.html.erb'
    end

    def create
        @article = Article.new(article_params)

        if @article.save              ##@article.save returns boolean based on conditions in model file
            redirect_to @article      ##redirects to 'show' action which has a view
        else
            render 'new'              ##think 'new' is new.html.erb? here using 'render' instead of 'redirect_to'
                                      ##to pass @article variable back to 'new' template
        end

        ##render plain: params[:article].inspect
    end

    def edit
        @article = Article.find(params[:id])
    end
        
    def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path   ##redirecting to index action, therefore dont need view
    end



    private
        def article_params
            params.require(:article).permit(:title, :text)
        end
    
end
