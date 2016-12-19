Gem::Specification.new do |s|
  s.name        = 'gh_repo_stats'
  s.version     = '0.0.0'
  s.executables = ["gh_repo_stats"]
  s.date        = '2016-12-15'
  s.summary     = "A command-line program that lists the most active repositories for a given time range"
  s.description = s.summary
  s.authors     = ["Weng Sin"]
  s.email       = 'wengcheong.sin@gmail.com'
  s.homepage    = ""
  s.files       = %w(lib/gh_repo_stats.rb lib/time_service.rb)
  s.license       = 'MIT'
  s.required_ruby_version = '~> 2.2.4'
  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency 'rspec', '~> 0'
  s.add_development_dependency 'yajl-ruby', '~> 0'
end