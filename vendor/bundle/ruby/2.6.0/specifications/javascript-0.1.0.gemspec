# -*- encoding: utf-8 -*-
# stub: javascript 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "javascript".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Godfrey Chan".freeze]
  s.date = "2018-10-05"
  s.description = "With this gem, Rubyists can finally get really close to the metal by programming in JavaScript syntax right within their Ruby applications.".freeze
  s.email = ["godfreykfc@gmail.com".freeze]
  s.homepage = "https://github.com/chancancode/javascript".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Harness the raw power of your machine with JavaScript".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<binding_of_caller>.freeze, ["~> 0.7.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
    else
      s.add_dependency(%q<binding_of_caller>.freeze, ["~> 0.7.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    end
  else
    s.add_dependency(%q<binding_of_caller>.freeze, ["~> 0.7.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
  end
end
