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

    def get_spec(name)
      Spec.new(self, name)
    end

    def specs
      Dir.glob(File.join(root, Everblue.spec_dir, '**/*_spec.{js,coffee}')).map do |path|
        Spec.new(self, path.gsub(File.join(root, Everblue.spec_dir, ''), ''))
      end
    end

    def templates
      Dir.glob(File.join(root, Everblue.template_dir, '*')).map do |path|
        Template.new(self, File.basename(path))
      end
    end
  end
end
