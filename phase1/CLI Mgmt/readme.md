# Cloud CLI Instance Management Project

**Author:** RaShunda Williams
**Date:** 3/10/25

## Project Overview

This project focuses on using the Google Cloud CLI (gcloud) to automate basic Compute Engine instance management tasks. The goal was to gain practical experience with `gcloud` commands for creating, starting, stopping, and deleting instances.

## Objectives

* Become familiar with the `gcloud` command-line tool.
* Learn to create, start, stop, and delete Compute Engine instances using `gcloud`.
* Practice using `gcloud` flags and options to customize instance configurations.
* Understand basic scripting concepts for automating repetitive tasks.
* Gain experience in capturing and interpreting `gcloud` output.
* Document the process and commands used.

## Steps Taken

1. **Project Setup:**
* Ensured the Google Cloud SDK (gcloud CLI) was installed and configured.
  
  **Windows**
    ```bash
    (New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe", "$env:Temp\GoogleCloudSDKInstaller.exe")

    & $env:Temp\GoogleCloudSDKInstaller.exe
  ```
  **Linux**
    
  - Download file
  ```bash
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
  ```
  - Extract contents
  ```bash
  tar -xf google-cloud-cli-linux-x86_64.tar.gz
  ```
  - Add gcloud CLI to PATH
  ```bash
  ./google-cloud-sdk/install.sh
  ```
* Selected a Google Cloud Platform project with the Compute Engine API enabled.
* Set the project and zone using the following commands:
    ```bash
    gcloud config set project [PROJECT_ID]
    gcloud config set compute/zone us-central1-a
    ```

2. **Instance Creation:**
* Create a Compute Engine instance named `web-server-dev`.
* Use the `us-central1-a` zone.
  - Zone of the instances to create.
* Use the `e2-micro` machine type.
  - Specifies the machine type used for the instances. To get a list of available machine types, run 'gcloud compute machine-types list'. If unspecified, the default type is n1-standard-1.
* Use the `debian-11` operating system image.
  - To get a list of images run `gcloud compute images list`
  - Using the exact image requires the image project flag
  - If you don't have the exact image, you should use the image project and image family
* Utilize gcloud compute instances create with relevant flags.
    ```bash
    gcloud compute instances create web-server-dev --zone=us-central1-a --machine-type=e2-micro --image-family=debian-11 --image-project=debian-cloud
    ```

3. **Instance Status Management:**
* Develop commands to start and stop the web-server-dev instance.
    ```bash
    gcloud compute instances start web-server-dev
    gcloud compute instances stop web-server-dev
    ```
* Demonstrate how to check the instance's status using `gcloud compute instances describe web-server-dev`

4. **Instance Deletion:**
* Create a command to delete the web-server-dev instance.
    ```bash
    gcloud compute instances delete web-server-dev
    ```
* Understand the implications of deleting an instance.
  - The virtual machine (VM) will be permanently deleted.
  - All data on the boot disk is lost (by default).
  - The instance IP address (if ephemeral) will be released.
  - The instance will stop incurring charges.
  - Firewall rules, static IP, or external disks are not deleted.
  - You can preview what will be deleted by running:
    ```BASH
    gcloud compute instances describe web-server-dev
    ```
  - To preview what will be deleted:
    ```bash
    gcloud compute instances describe web-server-dev
    ```
    - Boot disk → Check if it will be deleted or not.
    - IP Address → Check if it's ephemeral (it will be lost).
    - Persistent Disks → Check if they will be preserved.

5. **Basic Scripting**