module ActionDispatch::Routing
  class Mapper
    def api_for(path)
      mount Lina::Engine => path
    end
  end
end
