control 'V-102503' do
  title 'Documentation must be removed.'
  desc  "Tomcat provides documentation and other directories in the default
installation which do not serve a production use. These files must be deleted."
  desc  'rationale', ''
  desc  'check', "
    From the Tomcat server OS type the following command:

    sudo ls -l $CATALINA_BASE/webapps/docs.

    If the docs folder exists or contains any content, this is a finding.
  "
  desc 'fix', "
    From the Tomcat server OS type the following command:

    sudo rm -rf $CATALINA_BASE/webapps/docs
  "
  impact 0.3
  tag severity: 'low'
  tag gtitle: 'SRG-APP-000141-AS-000095'
  tag gid: 'V-102503'
  tag rid: 'SV-111445r1_rule'
  tag stig_id: 'TCAT-AS-000580'
  tag fix_id: 'F-108037r1_fix'
  tag cci: ['CCI-000381']
  tag nist: ['CM-7 a']

  catalina_base = input('catalina_base')
  describe file("#{catalina_base}/webapps/docs") do
    it { should_not exist }
  end
end
