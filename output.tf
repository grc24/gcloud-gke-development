output "http_clone_url" {
  value = github_repository.main.http_clone_url
  description = "URL to use when adding remote to local git repository"
}

output "tfe_worspace_id" {
  value = tfe_oauth_client.github.id
  description = "ID of workspace"
}