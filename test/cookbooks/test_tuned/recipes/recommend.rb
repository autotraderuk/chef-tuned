include_recipe 'tuned::default'

tuned_profile 'default' do
  action [:default]
end
