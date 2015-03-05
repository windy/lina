require 'test_helper'

class Lina::ApidocControllerTest < ActionController::TestCase
  class ::OnesController < Lina::ApplicationController
    define_action :index, {
      name: 'index',
      params: {
      },
      return: {
      }
    } do
    end
  end

  class ::CrudController < Lina::ApplicationController
    [:index, :new, :update, :create, :destroy, :show, :edit].each do |name|
      define_action name, {
        name: name,
        params: {
        },
        return: {
        }
      } do
      end
    end
  end

  setup do
    @routes = Lina::Engine.routes
  end

  teardown do
    Rails.application.reload_routes!
  end

  test "only one controller" do
    Rails.application.routes.draw do
      resources :ones, only: [:index]
      mount Lina::Engine => '/lina'
    end

    Lina::BaseController.any_instance.stubs(:all_subclasses).returns([ 'ones' ])
    get :index
    assert_equal 1, assigns(:_tree).size
  end

  test "CRUD controller" do
    Rails.application.routes.draw do
      resources :crud
      mount Lina::Engine => '/lina'
    end

    Lina::BaseController.any_instance.stubs(:all_subclasses).returns([ 'crud' ])
    get :index
    assert_equal 8, assigns(:_tree).size
  end

  test "more controllers" do
    Rails.application.routes.draw do
      resources :crud
      resources :ones, only: [:index]
      mount Lina::Engine => '/lina'
    end

    Lina::BaseController.any_instance.stubs(:all_subclasses).returns([ 'crud', 'ones' ])
    get :index
    assert_equal 8 + 1, assigns(:_tree).size
  end
end
