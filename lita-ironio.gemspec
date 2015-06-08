Gem::Specification.new do |spec|
  spec.name          = "lita-ironio"
  spec.version       = "0.2.1-beta"
  spec.authors       = ["Jurnell Cockhren"]
  spec.email         = ["jurnell.cockhren@sophicware.com"]
  spec.description   = "IronIO handler for Lita Bot"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/sophicware/lita-ironio"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", "~> 4.3"
  spec.add_runtime_dependency "iron_worker_ng", "~> 1.6"
  spec.add_runtime_dependency "iron_mq", "~> 5.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
