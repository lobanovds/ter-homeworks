locals {
  yc_public_key     = jsondecode(file(".authorized_key.json")).public_key
 }
