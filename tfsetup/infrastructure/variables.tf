 variable "region" {
  default = "eu-central-1"
}

variable "vpcip" {
  default = "170.30.0.0/16"
}
variable "subnet-azs-ips"{
  type = object({
    az-a-public = string
    az-b-public = string
    az-a-private = string
    az-b-private = string
  })
  default = {
      az-a-public = "170.30.0.0/24"
      az-b-public = "170.30.1.0/24"
      az-a-private = "170.30.16.0/20"
      az-b-private = "170.30.32.0/20"
    }
  
} 

//{
 // az_a = "170.30.0.0/24"
 // az_b = "170.30.1.0/24"
//}

