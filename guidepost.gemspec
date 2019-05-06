Gem::Specification.new do |s|
    s.name                  = 'guidepost'
    s.version               = '0.1.1'
    s.summary               = "Harness your knowledge base in your Ruby applications"
    s.description           = "Harness your knowledge base in your Ruby applications"
    s.authors               = ["Kiren Srinivasan"]
    s.email                 = 'kiren.srinivasan@holbertonschool.com'
    s.files                 = Dir["lib/**/*", "README.md", "LICENSE"]
    s.require_paths         = ["lib"]
    s.required_ruby_version = '>= 2.5.0'

    s.add_dependency("aws-sdk", "~> 2.0")
end