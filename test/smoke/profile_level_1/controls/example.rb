# encoding: utf-8
# copyright: 2015, The Authors

control 'level-1' do
  describe file('/tmp/level-1') do
    it { should_not exist }
  end
end

control 'tmp-1.0' do
  describe file('/tmp') do
    it { should be_directory }
  end
end
