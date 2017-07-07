#
# Cookbook:: one-profile-to-rule-them-all
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# test changing role names here
roles = {
  # values checked for in inspec profile (meta_profile) are `dmz-web` and `intranet-web`
  'roles' => ["intranet-web"]
}

output = "#{Chef::JSONCompat.to_json_pretty(roles)}"

# comment out above and use below when not testing
# output = "#{Chef::JSONCompat.to_json_pretty(node.to_hash)}"

file '/tmp/node.json' do
  content output
end
