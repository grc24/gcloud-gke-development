# output "http_clone_url" {
#   value       = github_repository.main.http_clone_url
#   description = "URL to use when adding remote to local git repo"
# }

# output "tfe_worspace_id" {
#   value       = tfe_oauth_client.github.id
#   description = "ID of workspace"
# }


output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
  sensitive   = true
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
  sensitive   = true
}