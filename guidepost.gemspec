Gem::Specification.new do |s|
    s.name                  = 'guidepost'
    s.version               = '0.2.2'
    s.homepage              = "https://github.com/srinitude/guidepost"
    s.summary               = "Harness your knowledge base in your Rails applications"
    s.description           = "Harness your knowledge base in your Rails applications"
    s.authors               = ["Kiren Srinivasan"]
    s.email                 = 'srinitude@gmail.com'
    s.files                 = Dir["lib/**/*", "README.md", "LICENSE"]
    s.require_paths         = ["lib"]
    s.required_ruby_version = '>= 2.5.0'
    s.licenses              = ["MIT"]

    s.add_dependency("aws-sdk", "~> 2.0")
end