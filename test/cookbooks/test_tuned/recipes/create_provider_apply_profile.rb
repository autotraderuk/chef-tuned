tuned_profile 'provider' do
  main include: 'latency-performance'
  plugins(cpu: {
            governor: 'performance',
            energy_perf_bias: 'performance'
          })
  action [:create, :enable]
end
