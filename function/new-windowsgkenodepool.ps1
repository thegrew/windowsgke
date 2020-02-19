<# 
.SYNOPSIS
    Function to create a Windows GKE node pool

.DESCRIPTION
    This function takes a series of parameters to build a Windows GKE node pool

.PARAMETER nodepoolname
Specify the name for the node pool you want to create

.PARAMETER clustername
Specify the name of the cluster in which the node pool is to be created

.PARAMETER nodeimagetype
Specify type of Windows image, the options are WINDOWS_SAC (Default) or WINDOWS_LTSC

.PARAMETER nodesize
Specify the size of a the node, the default value is n1-standard-2 as this is the smallest size GCP recommends

.PARAMETER nodenumber
Specify the number of nodes in each zone in a region, the default value is 1

.INPUTS
None. Objects can not be piped to this function

.OUTPUTS
None.
#>

function new-windowsgkenodepool {

    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$nodepoolname,  
        [Parameter(Position = 1, Mandatory = $true)]         
        [string]$clustername,
        [Parameter(Position = 2, Mandatory = $false)]
        [ValidateSet("WINDOWS_SAC", "WINDOWS_LTSC")]
        [string]$nodeimagetype = "WINDOWS_SAC",
        [Parameter(Position = 3, Mandatory = $false)]
        [string]$nodesize = "n1-standard-2",
        [Parameter(Position = 3, Mandatory = $false)]
        [int16]$nodenumber = 1
    )

    $cluster = get-gkecluster | Where-Object { $_.Name -eq $clustername }
    $region = $cluster.zone

    Write-Verbose "The input values were:"
    Write-Verbose "Node Pool Name: $nodepoolname"
    Write-Verbose "Cluster Name: $clustername"
    Write-Verbose "Region is: $region"
    Write-Verbose "Node Image Type: $nodeimagetype"
    Write-Verbose "Node Size: $nodesize"
    Write-Verbose "Number of Nodes in Each Zone: $nodenumber"

    Write-Output "----------------------------------------"
    Write-Output "Provisioning Node Pool: $nodepoolname"
    Write-Output "----------------------------------------"
    gcloud container node-pools create $nodepoolname --region $region --cluster=$clustername --image-type=$nodeimagetype --enable-autoupgrade --machine-type=$nodesize --num-nodes=$nodenumber

    Write-Output "----------------------------------------"
    Write-Output "Node Pool: $nodepoolname has been created!"
    Write-Output "----------------------------------------"

    return
}