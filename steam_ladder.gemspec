# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name          = 'steam_ladder'
  gem.version       = '1.0.1'
  gem.licenses      = ['MIT']
  gem.summary       = 'Ruby wrapper for the Steam Ladder API.'
  gem.description   = 'Ruby wrapper to access the Steam Ladder API at https://steamladder.com/api/.'
  gem.authors       = ['Melvin Lammerts']
  gem.email         = 'hi@melv.in'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- spec/*`.split("\n")
  gem.require_paths = ['lib']

  gem.homepage      = 'https://rubygems.org/gems/steam_ladder'
  gem.metadata      = { 'source_code_uri' => 'https://github.com/melvinsh/steam_ladder' }

  gem.add_runtime_dependency 'http', '~> 5.0', '>= 5.0.1'

  gem.add_development_dependency 'coveralls', '~> 0.8.23'
  gem.add_development_dependency 'rspec', '~> 3.5'
end
