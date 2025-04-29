# -*- encoding: utf-8 -*-
# stub: mercadopago 2.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mercadopago".freeze
  s.version = "2.3.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kauplus Social Commerce".freeze, "Ombu Shop, Tu Tienda Online".freeze]
  s.date = "2017-05-22"
  s.description = "This gem allows developers to use the services available in the MercadoPago API (http://www.mercadopago.com)".freeze
  s.email = ["suporte@kauplus.com.br".freeze, "hola@ombushop.com".freeze]
  s.homepage = "https://github.com/kauplus/mercadopago".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.4.8".freeze
  s.summary = "Client for the MercadoPago API".freeze

  s.installed_by_version = "3.5.18".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<json>.freeze, [">= 1.4.6".freeze])
  s.add_runtime_dependency(%q<faraday>.freeze, [">= 0.9.0".freeze])
  s.add_development_dependency(%q<pry>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<byebug>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<test-unit>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<vcr>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<webmock>.freeze, [">= 0".freeze])
end
