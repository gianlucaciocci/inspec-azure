
require 'azure_backend'

# Class to test the configuration and the resources in a virtual network
#
# @author Gianluca Ciocci
#
# @attr_reader [Hashtable] items List of items in the resource group
# @attr_reader [Azure::ARM::Resources::Models::ResourceGroup] rg Resource group under interrogation
# @attr_reader [Hashtable] counts Hashtable containing the counts of the different types in the resource group
class AzureVNet < Inspec.resource(1)
  name 'azure_virtual_network'

  desc "
    This resource returns information about the specified virtual network
  "

  example "
    describe azure_virtual_network(name: 'ACME') do
      its('cdir') { should eq 10.0.0.0/24 }
      its('sub_network_count) { should eq 2 }
    end
  "

  attr_reader :vnet

  def initialize(opts)
    opts = opts
    helpers = Helpers.new

    # resource group exist?
    raise format("Unable to find resource group '%s' in Azure subscription '%s'", opts[:name], helpers.azure.subscription_id) unless helpers.resource_mgmt.exists opts[:name]

    # helpers.network_mgmt.
    @vnet = helpers.network_mgmt.get_virtual_network(opts[:rg_name], opts[:name])

    raise format('VNet %s not found in Azure subscription %s', opts[:name], helpers.azure.subcription_id) if vnet.nil?
  end

  # Create a FilterTable so that items can be selected
  filter = FilterTable.create
  filter.add_accessor(:where)
        .add_accessor(:entries)
        .add_accessor(:count)
        .add_accessor(:contains)
        .add(:type, field: 'type')
        .add(:name, field: 'name')

  # Determine the location of the resource group
  #
  # @return [String Location of the resource group
  #
  def location
    vnet.location
  end
end
