if defined?(ChefSpec)
  def create_tuned_profile(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:tuned_profile, :create, resource_name)
  end

  def enable_tuned_profile(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:tuned_profile, :enable, resource_name)
  end

  def recommended_tuned_profile(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:tuned_profile, :default, resource_name)
  end

  def disable_tuned_profile(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:tuned_profile, :disable, resource_name)
  end
end
