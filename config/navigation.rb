# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :products, 'Products', products_path
    primary.item :clients, 'Clients', clients_path
    primary.item :clients, 'Employees', clients_path
  end
end