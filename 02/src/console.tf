##Этот файл для 7 задания!!
locals {

  test_list = ["develop", "staging", "production"]

    test_map = {
    admin = "John"
    user  = "Alex"
  }

  servers = {
    develop = {
      cpu   = 2
      ram   = 4
      image = "ubuntu-21-10"
      disks = ["vda", "vdb"]
    },
    stage = {
      cpu   = 4
      ram   = 8
      image = "ubuntu-20-04"
      disks = ["vda", "vdb"]
    },
    production = {
      cpu   = 10
      ram   = 40
      image = "ubuntu-20-04"
      disks = ["vda", "vdb", "vdc", "vdd"]
    }

  }

  user_server = keys(local.servers)[1]
  user_data = local.servers[local.user_server]
  interpol_phrase = "${local.test_map.admin} is ${keys(local.test_map)[0]} for ${local.user_server} server based on OS ${local.user_data.image} with ${local.user_data.cpu} VCPU ${local.user_data.ram} RAM and [${join(", ", local.user_data.disks)}] virtual disks"
}

