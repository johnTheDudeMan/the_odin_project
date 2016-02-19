class ArticlesController < ApplicationController
	include ArticlesHelper

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comment.article_id = @article.id
		
	end

	def new
		@article = Article.new
	end

	def create
# 	best - You need to go to helper.rb to set article_params
# 			you will need to use 'include ArticlesHelper'
		@article = Article.new(article_params)
		@article.save

		flash.notice = "'#{@article.title}' was created!"

		redirect_to article_path(@article)
# 	better - above version even better
#		@article = Article.new(
#			title: params[:article][:title]
#			body: params[:article][:body])
#		@article.save
#		redirect_to article_path(@article)
#	okay - Use above syntax instead of below version
#		@article = Article.new
#		@article.title = params[:article][:title]
#		@article.body = params[:article][:body]
#		@article.save
#		redirect_to article_path(@article)
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		@article.update(article_params)

		flash.notice = "Article '#{@article.title}' Updated!"

		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		deletedTitle = @article.title
		flash.notice = "'#{deletedTitle}' was deleted!"

		redirect_to articles_path
	end
end
