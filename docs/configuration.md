# SolaKube configuration

In this page, we discuss all of the configuration files that are typically needed to be modified by the user and the kinds of configuration variables / attributes that are found in these files.

The first part of the cluster building process (initial creation and provision) uses Terraform and Ansible, so the settings go into their configuration files (**terraform.tfvars**, **vault.yaml**).

The second part of the provisioning process is Bash, Helm and KubeCtl based, these are mainly configured by **variables.sh**.


# terraform.tfvars (Terraform)

This is the main descriptor file for parameterizing the Kubernetes cluster itself but it also has effect on the OS-level provisioning of the virtual machines (VMs) we use on Hetzner cloud as cluster nodes.

This is found on the **terraform/clusters/<cluster-name>/terraform.tfvars** path and is defined per-cluster.

See detailed documentation about the attributes that can be used in terraform.tfvars in the file called variables.tf in the same folder. This also contains the default values for attributes that you are not required to specify in the tfvars file.

This is intended to be under version control.

The secret variables described in **variables.tf** are set via the TF_VAR_xxx variables defined in **variables.sh**.

# Ansible Vault password file

This is a file that contains the password for the Ansible vault for the processes that need to decrypt that file for secrets.

It is placed on the ~/.solakube/ansible-vault-pass path and its only content is the password in plain text.

It is shared among all clusters.

# Ansible Vault file - vault.yml

This contains variables that are needed for the Ansible-based provisioning process of the virtual machines (cluster nodes). Typically contains variables needed to configure OS-level services (e.g.: parameters of the SMTP server for sending emails from Linux system services via Postfix)

This is an encrypted file and may be placed under version control.

The variables and structure is documented in templates/vault.yml

Use **create_vault.sh** for creating an empty vault file (you need to remove the one coming with SolaKube/Andromeda). 

Use **edit_vault.sh** for easily make/change sensitive settings in the Ansible vault (tokens, passwords). These are only used for secrets that will be passed to Ansible.

It is shared among all clusters.


# variables.sh (shared)

This contains secret and normal configuration variables for a cluster. 

Automatically loaded when the "sk" script is executed with any sub-commands so that all Bash scripts, sub-scripts automatically have access to them.

Placed on the ~/.solakube/<cluster>/variables.sh path and is defined per-cluster.

A template for it can be found in the **templates** folder

The "TF_VAR_" variable definitions define variables for the Terraform execution. See documentation about them in the variables.tf file belonging to terraform.tfvars (above in the docs).  

SK_DEPLOY_XXX variables control which applications/components should be installed when the unified cluster-builder process runs.

This is not intended to be under version control.