import boto3
from botocore.exceptions import ClientError

def get_eks_clusters(region_name='us-east-1'):
    eks_client = boto3.client('eks', region_name=region_name)

    try:
        clusters = eks_client.list_clusters()['clusters']

        if not clusters:
            print("No EKS clusters found.")
            return

        for cluster_name in clusters:
            response = eks_client.describe_cluster(name=cluster_name)
            cluster = response['cluster']

            print("=" * 80)
            print(f"Cluster Name      : {cluster['name']}")
            print(f"Version           : {cluster['version']}")
            print(f"Status            : {cluster['status']}")
            print(f"ARN               : {cluster['arn']}")
            print(f"Endpoint          : {cluster['endpoint']}")
            print(f"Platform Version  : {cluster.get('platformVersion', 'N/A')}")
            print(f"Created At        : {cluster['createdAt']}")
            print(f"IAM Role ARN      : {cluster['roleArn']}")

            print("\nVPC Configuration:")
            vpc_config = cluster['resourcesVpcConfig']
            print(f"  VPC ID          : {vpc_config.get('vpcId')}")
            print(f"  Subnet IDs      : {', '.join(vpc_config.get('subnetIds', []))}")
            print(f"  Security Groups : {', '.join(vpc_config.get('securityGroupIds', []))}")

            print("\nLogging:")
            for log in cluster.get('logging', {}).get('clusterLogging', []):
                print(f"  Types: {log['types']} Enabled: {log['enabled']}")

            print("\nKubernetes Network:")
            print(f"  Service CIDR    : {cluster.get('kubernetesNetworkConfig', {}).get('serviceIpv4Cidr', 'N/A')}")

    except ClientError as e:
        print(f"AWS Error: {e}")

if __name__ == "__main__":
    get_eks_clusters("us-east-1")