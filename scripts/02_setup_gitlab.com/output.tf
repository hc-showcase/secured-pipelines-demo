output "project-url" {
    description = "URL of the Gitlab project"
    value       = gitlab_project.secured_pipelines.web_url
}
