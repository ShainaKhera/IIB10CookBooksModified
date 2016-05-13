################################################################################
#
# Copyright (c) 2013 IBM Corporation and other Contributors
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#     IBM - initial implementation
#
#################################################################################
# Definition IBM_Integration_Bus::iib_create_user
# 
# Create a user account for running IIB
#
################################################################################
define :iib_remove_user do
  username   = node['ibm_integration_bus']['account_username'];
  password   = node['ibm_integration_bus']['account_password'];
  home  = "/home/#{username}"
  #
  # Install shadow ruby as chef requires this to handle passwords
  #
  if password
    gem_package "Install shadow ruby to support user name passwords" do
      package_name "ruby-shadow"
      retries 2
      retry_delay 10
    end
  end

  user "Delete IIB user #{username} used for administering IIB" do
    action :remove
    shell "/bin/bash"
    home "/home/#{username}"
    supports :manage_home=> true
    username "#{username}"
    if password
      password "#{password}"
    end
  end
end