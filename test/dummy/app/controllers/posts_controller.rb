class PostsController < ApplicationController
  def index
    render json: { name: 'post name' }
  end
end
