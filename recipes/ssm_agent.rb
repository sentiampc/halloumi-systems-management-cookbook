# AWS Systems Manager (formerly Amazon EC2 Systems Manager) is a unified
# interface that allows you to easily centralize operational data and automate
# tasks across your AWS resources. Systems Manager shortens the time to detect
# and resolve operational problems in your infrastructure. Systems Manager gives
# you a complete view of your infrastructure performance and configuration,
# simplifies resource and application management, and makes it easy to operate
# and manage your infrastructure at scale.
#
# https://docs.aws.amazon.com/systems-manager/latest/userguide/what-is-systems-manager.html

# Windows
# -------
# SSM Agent is installed by default on Windows Server 2016 instances and
# instances created from Windows Server 2003-2012 R2 AMIs published in November
# 2016 or later.

# Amazon Linux
# ------------
# SSM Agent is installed, by default, on Amazon Linux AMIs dated 2017.09 and
# later. You must manually install SSM Agent on other versions of Linux.

# Supporting Functions
def _platform_type
  case node["platform_family"]
    when /rhel/, /fedora/, /suse/
      "redhat"
    else
      node["platform_family"]
  end.to_s
end

amazon_ssm_agent_package_url = -> do
  platform = _platform_type
  arch = node["kernel"]["machine"].to_s

  # return
  node["halloumi_systems_management"]["ssm_agent"]["package"][platform][arch]
end

on_debian = _platform_type == "debian"
on_redhat = _platform_type == "redhat"

# Install Package from URL
remote_file "/tmp/amazon-ssm-agent" do
  only_if { on_debian || on_redhat }
  source lazy { amazon_ssm_agent_package_url.call }
end

dpkg_package "amazon-ssm-agent" do
  only_if { on_debian }
  source "/tmp/amazon-ssm-agent"
end

rpm_package "amazon-ssm-agent" do
  only_if { on_redhat }
  source "/tmp/amazon-ssm-agent"
end

file "/tmp/amazon-ssm-agent" do
  only_if { on_debian || on_redhat }
  action :delete
end
