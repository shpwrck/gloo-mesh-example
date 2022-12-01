export AWS_REGION=us-east-1
export AWS_ACCESS_KEY_ID={{ AKID }}
export AWS_SECRET_ACCESS_KEY={{ SKID }}
export AWS_NODE_MACHINE_TYPE=m5.large
export AWS_CONTROL_PLANE_MACHINE_TYPE=m5.large
export AWS_SSH_KEY_NAME=skrzypek-wsl
export KUBERNETES_VERSION=1.24.7
export CLUSTER_NAME=jskrzypek

clusterawsadm bootstrap iam create-cloudformation-stack --config bootstrap-config.yaml -v 1

export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile -v 1)

clusterctl init --infrastructure aws

clusterctl generate cluster $CLUSTER_NAME --kubernetes-version $KUBERNETES_VERSION --flavor eks
