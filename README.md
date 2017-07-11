# one-profile-to-rule-them-all
This example shows how to create an Inspec meta profile [profile_meta](test/smoke/profile_meta/inspec.yml) that depends on [profile_level_1](test/smoke/profile_level_1/controls/example.rb) and [profile_level_2](test/smoke/profile_level_2/controls/example.rb) but defines common overrides for both in only one location, and selects the correct one to run based on node attributes.

# Usage
```
kitchen converge && kitchen verify
```

# Testing
Open up `recipes/default.rb` and change `'roles' => ["intranet-web"]` to `'roles' => ["dmz-web"]`
Then re-run `kitchen converge && kitchen verify` watch the _different_ profiles being executed as a result.

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

A real-world example of this, for example, are these Inspec Compliance Profiles:
- `cis-rhel7-level1-server`
- `cis-rhel7-level2-server`
- `cis-rhel7-level1-workstation`
- `cis-rhel7-level2-workstation`

The above profiles have a _lot_ of control duplication that someone want may want to override.  If they choose to maintain separate meta profiles for each they will end up duplicating the profile overrides in meta profiles for each upstream profile.  They will have to maintain the exact same override code in up to 4 separate locations.  This violates DRY!

# Solution A
Create only one DRY meta-profile that depends on all upstream profiles and use ruby conditionals based on Ohai attribute data (like roles) to select the correct profile. See [here](test/smoke/profile_meta/controls/example.rb)
