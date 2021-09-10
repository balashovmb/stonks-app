server "51.15.67.2", user: "deployer", roles: %w{app db web}, primary: true
set :rails_env, :production

set :ssh_options, {
  keys: %w(/home/muxa/.ssh/ror_rsa),
  forward_agent: true,
  auth_methods: %w(publickey password),
  port: 4321
 }