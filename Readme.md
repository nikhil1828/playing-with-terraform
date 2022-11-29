# playing-with-terraform

1. First clone the repository.
2. Initialize the modules ,backend and providers plugins by running command "terraform init".
3. Configure your AWS account credentials using "aws configure" command and add your access key and secret access key.
4. Change the Region in line 2 of "main.tf" file as per your needs(where you want to build your infratructure).
5. Change the Availability zone in line 11, 15 and 19 of "main.tf" file as per your needs(where you want to build your infratructure).
6. Ensure you have a key in the above given region and give the name of the key in line 65 of "main.tf" file.
7. Ensure to update the ami-id in line 63 of main.tf.
8. Create the infrastructure by running command "terraform apply"
9. Destroy the infrastructure by running command "terraform destroy"
