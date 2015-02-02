module Lina
  module Utils
    class <<self
      def routes_to_tree(routes)
        tree = []
        routes.each do |route|
          paths = route[:path].split("/")
          paths.shift
          paths_insert_tree(paths, tree)
        end
        tree
      end

      def paths_insert_tree(paths, tree)
        #puts "call it:"
        #puts "paths: #{paths}"
        #puts "tree: #{tree}"
        return if paths.empty?
        paths = paths.dup
        path = paths.shift

        endpoint = tree.find { |t| t[path].present? }
        if endpoint
          paths_insert_tree(paths, endpoint[path])
        else
          sub_tree = { path => [] }
          tree << sub_tree
          paths_insert_tree(paths, sub_tree[path])
        end

      end
    end
  end
end
