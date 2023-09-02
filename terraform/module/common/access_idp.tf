resource "cloudflare_access_identity_provider" "auth0" {
  name = "auth0"
  type = "oidc"
  account_id = local.account_id

  config {
    client_id = "Ghx3kMR7xeW7GDJwgL0LftJDDwgMKyEB"
    client_secret = "i7ZjnD13q1gqxpVRrB_5i60oS5Nm-g_WzdzwjAR3p9SK1iZY24EkOGqR7MzYR-Co"
    auth_url = "https://luciferous-private.jp.auth0.com/authorize"
    token_url = "https://luciferous-private.jp.auth0.com/oauth/token"
    certs_url = "https://luciferous-private.jp.auth0.com/.well-known/jwks.json"
  }
}
