control 'V-102593' do
  title 'ENFORCE_ENCODING_IN_GET_WRITER must be set to true.'
  desc  "Some clients try to guess the character encoding of text media when
the mandated default of ISO-8859-1 should be used. Some browsers will interpret
as UTF-7 when the characters are safe for ISO-8859-1. This can create the
potential for a XSS attack. To defend against this,
enforce_encoding_in_get_writer must be set to true."
  desc  'rationale', ''
  desc  'check', "
    From the Tomcat server as a privileged user, run the following command:

    sudo grep -i  enforce_encoding /etc/systemd/system/tomcat.service

    If there are no results, or if the
org.apache.catalina.connector.response.ENFORCE_ENCODING_IN_GET_WRITER is not
=\"true\", this is a finding.
  "
  desc 'fix', "
    From the Tomcat server as a privileged user:

    Edit the /etc/systemd/system/tomcat.service file, and either add or edit
the org.apache.catalina.connector.response.ENFORCE_ENCODING_IN_GET_WRITER
setting.

    Set the
org.apache.catalina.connector.response.ENFORCE_ENCODING_IN_GET_WRITER=true

    EXAMPLE:
    Environment='CATALINA_OPTS
-Dorg.apache.catalina.connector.response.ENFORCE_ENCODING_IN_GET_WRITER=true'

    Restart the Tomcat server:
    sudo systemctl restart tomcat
    sudo systemctl daemon-reload
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000516-AS-000237'
  tag gid: 'V-102593'
  tag rid: 'SV-111533r1_rule'
  tag stig_id: 'TCAT-AS-001690'
  tag fix_id: 'F-108125r1_fix'
  tag cci: ['CCI-000366']
  tag nist: ['CM-6 b']

  describe 'The systemd startup file must exist' do
    subject { service('tomcat') }
    it { should be_installed }
  end

  unless service('tomcat').params.empty?
    describe service('tomcat').params['Environment'] do
      it { should match '-Dorg.apache.catalina.connector.response.ENFORCE_ENCODING_IN_GET_WRITER=true' }
    end
  end
end
