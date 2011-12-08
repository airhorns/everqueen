module Everblue
  class Suite
    attr_reader :driver

    def initialize
      paths = [
        File.expand_path("config/everblue.rb", root),
        File.expand_path(".everblue", root),
        "#{ENV["HOME"]}/.everblue"
      ]
      paths.each { |path| load(path) if File.exist?(path) }
    end

    def root
      Everblue.root
    end

    def mounted_at
      Everblue.mounted_at
    end

    def get_test(name)
      Test.new(self, name)
    end

    def tests
      Dir.glob(File.join(root, Everblue.test_dir, '**/*_test.{js,coffee}')).map do |path|
        Test.new(self, path.gsub(File.join(root, Everblue.test_dir, ''), ''))
      end
    end
  end
end
