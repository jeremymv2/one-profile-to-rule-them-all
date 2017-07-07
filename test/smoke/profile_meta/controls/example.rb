# encoding: utf-8
# copyright: 2015, The Authors

roles = json('/tmp/node.json').value(['roles'])
puts "Parsed Roles: #{roles}"

profile = if roles.include?('intranet-web')
            'profile_level_1'
          elsif roles.include?('dmz-web')
            'profile_level_2'
          else
            'profile_level_1'
          end

puts "Selected Profile: #{profile}"

include_controls profile do
  # common overrides here
  control 'tmp-1.0' do
    describe file('/tmp') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end
  end

  if profile == 'profile_level_1'
    # specific to level_1
    control 'abc' do
      describe 'abc' do
        it { should eq 'abc' }
      end
    end
  elsif profile == 'profile_level_2'
    # specific to level_2
    control 'xyz' do
      describe 'xyz' do
        it { should eq 'xyz' }
      end
    end
  end
end
