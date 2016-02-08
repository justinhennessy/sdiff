require 'spec_helper'

describe 'sdiff' do
  let(:params) { { :ensure => 'present' } }
  context 'Check compile with dependancies' do
    let(:facts) { { :operatingsystem => 'Redhat' } }
    it {
      should compile.with_all_deps
    }
  end
  context 'Check class exists' do
    it { should contain_class('sdiff') }
  end
  context '/usr/local/bin/sdiff' do
    context 'is present and is a file' do
      it do
        is_expected.to contain_file('/usr/local/bin/sdiff')
          .with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0755',
          ).with_content(/^.*\/usr\/bin\/diff \$\@.*$/)
      end
    end
    context 'has correct content in script when file_pattern and line_pattern are not supplied' do
      it do
        is_expected.to contain_file('/usr/local/bin/sdiff')
          .with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0755',
          ).with_content(/^.*\/usr\/bin\/diff \$\@.*$/)
      end
    end
    context 'has supression text when file_pattern is supplied' do
      let(:params) { { :line_pattern => false, :ensure => 'present' } }
      it do
        is_expected.to contain_file('/usr/local/bin/sdiff')
          .with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0755',
          ).with_content(/^.*echo.*Suppressing potentially sensitive diff of.*$/)
      end
    end
    context 'has supression text when line_pattern is supplied' do
      let(:params) { { :file_pattern => false, :ensure => 'present' } }
      it do
        is_expected.to contain_file('/usr/local/bin/sdiff')
          .with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0755',
          ).with_content(/^sed.*Suppressing potentially sensitive diff.*$/)
      end
    end
  end
  context 'Check file is absent' do
    let(:params) { { :ensure => 'absent' } }
    it do
      is_expected.to contain_file('/usr/local/bin/sdiff')
        .with(
          'ensure' => 'absent',
        )
    end
  end
  context 'Check if ensure is not present or absent there is an error' do
    let(:params) { { :ensure => 'blah' } }
    it do
      should compile.and_raise_error(/No matching entry for selector parameter/)
    end
  end
end

