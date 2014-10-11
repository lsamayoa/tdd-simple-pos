# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'nav nav-pills'
    primary.item :products, 'Products', products_path
    primary.item :clients, 'Clients', clients_path
    primary.item :clients, 'Employees', employees_path
  end
end