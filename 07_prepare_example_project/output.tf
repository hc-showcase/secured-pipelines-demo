output "project-url" {
    description = "URL of the Gitlab project"
    value       = gitlab_project.secured-pipeline-project1.web_url
}
