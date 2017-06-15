
title 'Check VNets'

control 'azure-vnets-1.0' do

  impact 1.0
  title 'Check that the vnet has the correct subnets'

  # Ensure that the expected resources have been deployed
  describe azure_virtual_network(name: 'Inspec-VNet', rg_name: 'Inspec-Azure') do
    its('location') {should eq 'uksouth'}
    # its('total') { should eq 7 }
    # its('vm_count') { should eq 2 }
    # its('nic_count') { should eq 2 }
    # its('public_ip_count') { should eq 1 }
    # its('sa_count') { should eq 1 }
    # its('vnet_count') { should eq 1 }
  end

end