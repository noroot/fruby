#!/usr/bin/env ruby
# frozen_string_literal: true

# PostController
class PostsController < Controller
  def index
    @posts = Post.all
  end
end
