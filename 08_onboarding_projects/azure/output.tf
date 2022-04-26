output "project-url" {
    description = "URL of the Gitlab project"
    value       = gitlab_project.secured-pipeline-project.web_url
}
