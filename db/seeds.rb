# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create email: 'admin@savvspace.com', password: 'password123'
admin.grant_role!("admin")

rets_v1 = RetsRabbitV1MlsAdapter.first_or_create
sb_mls = MlsServer.create(name: "sbaor", server_hash: "4ddfb54ef491a7a1d383c0aba813e2ee", mls_adapter: rets_v1)
