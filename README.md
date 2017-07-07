# one-profile-to-rule-them-all
 
# Usage
```
kitchen converge && kitchen verify
```

# Testing
Open up `recipes/default.rb` and change `'roles' => ["intranet-web"]` to `'roles' => ["dmz-web"]`
Then re-run `kitchen converge && kitchen verify`

# Problem Statement
As of [inspec](https://www.inspec.io) version 1.31.1, if you have the following meta profiles:

```
# meta profile: acme-server-level-1
include_controls 'cis-level-1' do

  control "cis-fs-2.7" do
    impact 1.0
  ...
  bunch of other overrides..

end
```

```
# meta profile: acme-server-level-2
include_controls 'cis-level-2' do

  control "cis-fs-2.7" do
    impact 1.0
  ...
  exact same overrides as above

end
```

There is not yet a built-in pattern for handling the above scenario where Acme org creates meta/wrapper profiles for the standard CIS ones but wants to use the same overrides in each wrapper profile, without having to maintain that duplicate override code across meta profiles.

A real-world example of this, for example, is the cis-rhel7-level1-server and cis-rhel7-level2-server profiles that have a bunch of control duplication that someone wants to override, yet maintain separate meta profiles for each.

# Solution A
Create only one meta-profile that depends on all upstream profiles and use ruby conditionals based on Ohai attribute data (like roles) to select the correct profile. See [here](test/smoke/profile_meta/controls/example.rb)
