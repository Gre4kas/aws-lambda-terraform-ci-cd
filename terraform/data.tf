data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/../app/"
  output_path = "${path.module}/../app/hello-python.zip"
}