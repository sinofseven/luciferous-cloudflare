resource "cloudflare_pages_project" "ryza" {
  account_id        = local.account_id
  name              = "ryza"
  production_branch = "master"

  build_config {
    build_command = "npm run build"
    destination_dir = "dist"
  }

  source {
    type = "github"
    config {
      production_branch = "master"
      owner = "sinofseven"
      repo_name = "tools-of-atelier-of-ryza"
      deployments_enabled = true
    }
  }
  deployment_configs {
    production {}
  }
}
