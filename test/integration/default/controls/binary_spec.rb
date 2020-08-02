# frozen_string_literal: true

control 'asterisk executable' do
  title 'should be installed'

  describe file('/usr/sbin/asterisk') do
    it { should be_file }
    its('mode') { should cmp '0755' }
  end
end
