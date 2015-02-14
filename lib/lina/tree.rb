module Lina
  class Tree
    attr_reader :root
    def initialize(routes)
      @routes = routes
      @size = 0
      @root = paths_to_tree
    end

    def to_tree
      ret = []
      @root.children.each do |child|
        ret << _to_tree(child)
      end
      ret
    end

    def _to_tree(root)
      ret = {}
      ret[:text] = root.path
      ret[:value] = root.value
      if ! root.children.empty?
        ret[:nodes] = root.children.collect { |child| _to_tree(child) }
      end
      ret
    end

    def self.parse(routes)
      self.new(routes).to_tree
    end

    def size
      @size
    end

    def paths_to_tree
      tree = TreeNode.new('/')
      @routes.each do |route|
        paths = route[:path].split("/")
        paths.shift
        paths_insert_tree(paths, tree, route)
      end
      tree
    end

    def paths_insert_tree(paths, tree, route)
      if paths.empty?
        @size += 1
        tree.value = route
        return
      end
      paths = paths.dup
      path = paths.shift
      path = path.gsub('(.:format)', '')

      endpoint = tree.find_child(path)
      if endpoint
        paths_insert_tree(paths, endpoint, route)
      else
        child = TreeNode.new(path, tree)
        tree.add_child(child)
        paths_insert_tree(paths, child, route)
      end
    end
  end

  class TreeNode # :nodoc:
    attr_reader :path, :children, :parent, :value
    attr_writer :value
    def initialize(path, parent =nil)
      @path = path
      @children = []
      @parent = parent
      @value = nil
    end

    def real_path
      ret_path = [ @path ]
      node = self
      while(node = node.parent)
        ret_path.unshift(node.path)
      end
      ret_path.join('/')
    end

    def root?
      @parent.nil?
    end

    def add_child(child)
      @children << child
      child
    end

    def find_child(path)
      @children.find { |child| child.path == path }
    end
  end
end
