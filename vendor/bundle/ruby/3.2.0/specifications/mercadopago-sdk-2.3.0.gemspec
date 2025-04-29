# -*- encoding: utf-8 -*-
# stub: mercadopago-sdk 2.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mercadopago-sdk".freeze
  s.version = "2.3.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mercado Pago".freeze]
  s.date = "2025-01-22"
  s.description = "Mercado Pago Ruby SDK".freeze
  s.homepage = "http://github.com/mercadopago/sdk-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.1.6".freeze)
  s.rubygems_version = "3.3.27".freeze
  s.summary = "Mercado Pago Ruby SDK".freeze

  s.installed_by_version = "3.5.18".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<json>.freeze, ["~> 2.5".freeze])
  s.add_runtime_dependency(%q<rest-client>.freeze, ["~> 2.1".freeze])
  s.add_development_dependency(%q<pry>.freeze, ["~> 0.14".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 13.0".freeze])
end
