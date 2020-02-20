<# 
.SYNOPSIS
    Function to remove a Windows GKE node pool

.DESCRIPTION
    This function takes a series of parameters to remove a Windows GKE node pool

.PARAMETER clustername
Specify the name for the cluster you want to remove

.PARAMETER nodepoolname
Specify the name for the node pool you want to remove

.INPUTS
None. Objects can not be piped to this function

.OUTPUTS
None.
#>

function remove-windowsgkenodepool {

    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]         
        [string]$clustername,
        [Parameter(Position = 1, Mandatory = $false)]
        [string]$nodepoolname = "unspecified"
    )

    $cluster = get-gkecluster | Where-Object { $_.Name -eq $clustername }
    $region = $cluster.zone

    if ($nodepoolname -eq "unspecified") {
        Write-Verbose "Node Pool value is unspecified, pulling list of Node Pools within cluster."        
        $nodepools = $cluster.NodePools
        Write-Output "------------------------------------"
        Write-Output "List of node pools in $clustername :"
        Write-Output "------------------------------------"
        foreach ($nodepool in $nodepools) {
            $nodepoolname = $nodepool.Name
            Write-Output $nodepoolname
        }
        Write-Output "------------------------------------"
        $nodepoolname = Read-Host -Prompt "Which node pool would you like to remove?"
    }

    Write-Verbose "The input values were:"
    Write-Verbose "Cluster Name: $clustername"
    Write-Verbose "Node Pool Name: $nodepoolname"

    Write-Output "----------------------------------------"
    gcloud container node-pools delete --cluster=$clustername $nodepoolname --region $region --quiet

    Write-Output "----------------------------------------"
    Write-Output "Node Pool: $nodepoolname has been removed!"
    Write-Output "----------------------------------------"

    return
}