# windowsgke
Windows GKE is a powershell module I created to enable the faster deployment of Windows GKE clusters.
Currently the module contains two functions which are:
- new-windowsgkecluster
- new-windowsgkenodepool

# new-windowsgkecluster
The new-windowsgkecluster function is used to provision a regionally (as opposed to zonally) based GKE cluster with the required controller to support Windows node pools.

The function accepts the following parameters:
- clustername (string) - The name of the GKE cluster you wish to create.
- region (string) - The region in which you want to create the GKE cluster, the default value for this is europe-west-1 (Belgium) if not specified.

# new-windowsgkenodepool
The new-windowsgkenodepool function is used to provision a Windows node pool within a cluster created with the new-windowsgkecluster command.

The function accepts the following parameters:
- nodepoolname (string) - The name of the pool you wish to create, this is a required value.
- clustername (string) - The name of the cluster in which you wish to create the node pool, this is also a required value.
- nodeimagetype (string) - The type of Windows image to use, the choices are either WINDOWS_SAC (Semi-Annual Channel) or WINDOWS_LTSC (Long Term Servicing Channel) with the former option set as the default if not specified.
- nodesize (string) - The GCE instance size you wish to use for the nodes, for Windows nodes this needs to be at least n1-standard-2 which is set as the default value if not specified.
- nodenumber (int16) - The number of nodes per zone, the minimum and default value is 1 (leading to 3 nodes in a region).
