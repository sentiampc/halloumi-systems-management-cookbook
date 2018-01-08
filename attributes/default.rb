default["halloumi_systems_management"].tap do |security|
  # SSM Agent
  # See: https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-install-startup-linux.html
  security["ssm_agent"].tap do |ssm_agent|
    ssm_agent["package"].tap do |pkg|
      region = "eu-west-1"
      pkg["redhat"]["x86_64"] = "https://s3-#{region}.amazonaws.com/amazon-ssm-#{region}/latest/linux_amd64/amazon-ssm-agent.rpm"
      pkg["redhat"]["x86_32"] = "https://s3-#{region}.amazonaws.com/amazon-ssm-#{region}/latest/linux_386/amazon-ssm-agent.rpm"
      pkg["debian"]["x86_64"] = "https://s3-#{region}.amazonaws.com/amazon-ssm-#{region}/latest/debian_amd64/amazon-ssm-agent.deb"
      pkg["debian"]["x86_32"] = "https://s3-#{region}.amazonaws.com/amazon-ssm-#{region}/latest/debian_386/amazon-ssm-agent.deb"
      pkg["debian"]["arm"]    = "https://s3-#{region}.amazonaws.com/amazon-ssm-#{region}/latest/debian_arm/amazon-ssm-agent.deb"
    end
  end
end