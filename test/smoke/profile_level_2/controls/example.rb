# encoding: utf-8
# copyright: 2015, The Authors

control 'level-2' do
  describe file('/tmp/level-2') do
    it { should_not exist }
  end
end

# control also included in level1
control 'tmp-1.0' do
  describe file('/tmp') do
    it { should be_directory }
  end
end
