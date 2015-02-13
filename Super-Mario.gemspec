Gem::Specification.new do |game|
  game.name     = 'Super-Mario'
  game.version  = '0.1'
  game.authors  = ['Georgi Pavlov']
  game.email    = ['georgipavlov at gmail.com']
  game.homepage = 'https://github.com/gvpavlov/Super-Mario'
  game.summary  = 'My Super Mario Ruby project'
  game.description = 'My attempt at a Super Mario game'
  game.files    = `git ls-files`.split("\n")
  game.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  game.executables = `git ls-files -- bin/*`.split("\n")
    .map { |f| File.basename(f) }
  game.require_paths = ['lib']
  game.license = 'GPLv3'
  game.add_runtime_dependency 'gosu', '~>0.8'
  game.add_development_dependency 'rspec', '~>3.1'
end