include_recipe 'tuned::default'

tuned_profile 'default' do
  action [:create, :enable]
end
