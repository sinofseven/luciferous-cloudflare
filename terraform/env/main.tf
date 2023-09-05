terraform {
  required_version = "1.5.4"

  backend "remote" {
    organization = "luciferous-cloudflare"

    workspaces {
      name = "luciferous-cloudflare"
    }
  }

  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4.13.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
  api_client_logging = true
}

module "common" {
  source = "../module/common"
}


variable "CLOUDFLARE_API_TOKEN" {
  sensitive = true
}

variable "CLOUDFLARE_EMAIL" {
  sensitive = true
}
