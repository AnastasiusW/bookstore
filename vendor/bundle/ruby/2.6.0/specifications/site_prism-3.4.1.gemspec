# -*- encoding: utf-8 -*-
# stub: site_prism 3.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "site_prism".freeze
  s.version = "3.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/site-prism/site_prism/issues", "changelog_uri" => "https://github.com/site-prism/site_prism/blob/master/CHANGELOG.md", "source_code_uri" => "https://github.com/site-prism/site_prism" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Luke Hill".freeze, "Nat Ritmeyer".freeze]
  s.date = "2019-09-26"
  s.description = "SitePrism gives you a simple,\nclean and semantic DSL for describing your site.\nSitePrism implements the Page Object Model pattern on top of Capybara.".freeze
  s.email = ["lukehill_uk@hotmail.com".freeze, "nat@natontesting.com".freeze]
  s.homepage = "https://github.com/site-prism/site_prism".freeze
  s.licenses = ["BSD-3-Clause".freeze]
  s.post_install_message = "site_prism has now moved to a new organisation to facilitate better\nmanagement of the codebase. The new organisation link is available at www.github.com/site-prism\nand will house the site_prism gem plus new associated co-dependent gems.\n\nNB: The old repo will soon be discontinued and all existing issues will be moved over to the new\nrepo.".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A Page Object Model DSL for Capybara".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2.5"])
      s.add_runtime_dependency(%q<capybara>.freeze, ["~> 3.3"])
      s.add_runtime_dependency(%q<site_prism-all_there>.freeze, ["~> 0.3"])
      s.add_development_dependency(%q<cucumber>.freeze, ["~> 3.1"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.3"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.8"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.73.0"])
      s.add_development_dependency(%q<rubocop-performance>.freeze, ["~> 1.4.0"])
      s.add_development_dependency(%q<rubocop-rspec>.freeze, ["~> 1.33.0"])
      s.add_development_dependency(%q<selenium-webdriver>.freeze, ["~> 3.7"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.17"])
      s.add_development_dependency(%q<webdrivers>.freeze, ["~> 4.0"])
    else
      s.add_dependency(%q<addressable>.freeze, ["~> 2.5"])
      s.add_dependency(%q<capybara>.freeze, ["~> 3.3"])
      s.add_dependency(%q<site_prism-all_there>.freeze, ["~> 0.3"])
      s.add_dependency(%q<cucumber>.freeze, ["~> 3.1"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.73.0"])
      s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.4.0"])
      s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.33.0"])
      s.add_dependency(%q<selenium-webdriver>.freeze, ["~> 3.7"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.17"])
      s.add_dependency(%q<webdrivers>.freeze, ["~> 4.0"])
    end
  else
    s.add_dependency(%q<addressable>.freeze, ["~> 2.5"])
    s.add_dependency(%q<capybara>.freeze, ["~> 3.3"])
    s.add_dependency(%q<site_prism-all_there>.freeze, ["~> 0.3"])
    s.add_dependency(%q<cucumber>.freeze, ["~> 3.1"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.8"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.73.0"])
    s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.4.0"])
    s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.33.0"])
    s.add_dependency(%q<selenium-webdriver>.freeze, ["~> 3.7"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.17"])
    s.add_dependency(%q<webdrivers>.freeze, ["~> 4.0"])
  end
end
