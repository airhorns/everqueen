module Everqueen
  class Suite
    attr_reader :driver

    def initialize
      paths = [
        File.expand_path("config/everqueen.rb", root),
        File.expand_path(".everqueen", root),
        "#{ENV["HOME"]}/.everqueen"
      ]
      paths.each { |path| load(path) if File.exist?(path) }
    end

    def root
      Everqueen.root
    end

    def mounted_at
      Everqueen.mounted_at
    end

    def get_test(name)
      Test.new(self, name)
    end

    def tests
      Dir.glob(File.join(root, Everqueen.test_dir, '**/*_test.{js,coffee,js.coffee,js.erb,coffee.erb,js.coffee.erb}')).map do |path|
        Test.new(self, path.gsub(File.join(root, Everqueen.test_dir, ''), ''))
      end
    end
  end
end
