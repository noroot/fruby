# frozen_string_literal: true

# MainController
class MainController < Controller
  def index
    @test = 'test'
    @arr = %w[one two three]
    @posts = Post.all
  end
end
