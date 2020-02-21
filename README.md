# windowsgke
Windows GKE is a powershell module I created to enable the faster deployment of Windows GKE clusters.
Currently the module contains three functions which are:
- new-windowsgkecluster
- new-windowsgkenodepool
- remove-windowsgkenodepool

As you would expect the module is dependant on the underlying googlecloud and googlecloudbeta modules that Google supply. This code also assumes that you have already configured the gcloud config using the instructions [here](https://cloud.google.com/sdk/gcloud/reference/config/set).

## new-windowsgkecluster
The new-windowsgkecluster function is used to provision a regionally (as opposed to zonally) based GKE cluster with the required controller to support Windows node pools.

The function accepts the following parameters:
- clustername (string) - The name of the GKE cluster you wish to create.
- region (string) - The region in which you want to create the GKE cluster, the default value for this is europe-west1 (Belgium) if not specified.

Example:
```
new-windowsgkecluster -clustername "test" -region "us-central1"
```

## new-windowsgkenodepool
The new-windowsgkenodepool function is used to provision a Windows node pool within a cluster created with the new-windowsgkecluster command.

The function accepts the following parameters:
- nodepoolname (string) - The name of the pool you wish to create, this is a required value.
- clustername (string) - The name of the cluster in which you wish to create the node pool, this is also a required value.
- nodeimagetype (string) - The type of Windows image to use, the choices are either WINDOWS_SAC (Semi-Annual Channel) or WINDOWS_LTSC (Long Term Servicing Channel) with the former option set as the default if not specified.
- nodesize (string) - The GCE instance size you wish to use for the nodes, for Windows nodes this needs to be at least n1-standard-2 which is set as the default value if not specified.
- nodenumber (int16) - The number of nodes per zone, the minimum and default value is 1 (leading to 3 nodes in a region).

Example with minimal parameters:
```
new-windowsgkenodepool -nodepoolname "winpool" -clustername "test"
```

Example with all parameters:
```
new-windowsgkenodepool -nodepoolname "windowspool" -clustername "test" -nodeimagetype "WINDOWS_LTSC" -nodesize "n1-standard-4" -nodenumber 2
```

## remove-windowsgkenodepool
The new-windowsgkenodepool function is used to remove a Windows node pool within a GKE cluster.

The function accepts the following parameters:
- clustername (string) - The name of the cluster in the node pool resides, this is a required value.
- nodepoolname (string) - The name of the pool you wish to remove, if this isn't initially provided the function will list all node pools attached to the cluster to select from.

Example with minimal parameters:
```
remove-windowsgkenodepool -clustername "test"
```

Example with all parameters:
```
remove-windowsgkenodepool -clustername "test" -nodepoolname "windowspool"
```
