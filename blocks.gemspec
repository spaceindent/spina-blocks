$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spina/blocks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spina-blocks"
  s.version     = Spina::Blocks::VERSION
  s.authors     = ["Michael Wawra"]
  s.email       = ["michael@spaceindent.com"]
  s.homepage    = "http://www.spaceindent.com/spina/plugins/blocks"
  s.summary     = "Reusable Content Blocks for Spina CMS"
  s.description = <<-EOF
This plugin extends Spina CMS to allow it to use a new type called a `block`. Blocks
are basically the same as pages, but cannot be rendered themselves as pages. Instead
they are intended to be used on lots of other pages.
  EOF

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "spina"
end
