Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Ajuste conforme necessário para especificar quais domínios são permitidos
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Access-Control-Allow-Headers'], # Expondo cabeçalhos específicos
      max_age: 600 # Opcional: define o tempo de cache do preflight
  end
end