<# 
.SYNOPSIS
    Function to create a Windows capable GKE cluster

.DESCRIPTION
    This function takes a series of parameters to build a regional GKE cluster

.PARAMETER clustername
Specify the name for the cluster you want to create

.PARAMETER region
Specify the region you wish to create the cluster in, if none is provided a default selection of europe-west1 is made

.INPUTS
None. Objects can not be piped to this function

.OUTPUTS
None.
#>

function new-windowsgkecluster {

    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]         
        [string]$clustername,
        [Parameter(Position = 1, Mandatory = $false)]
        [string]$region = "europe-west1"
    )

    Write-Verbose "The input values were:"
    Write-Verbose "Cluster Name: $clustername"
    Write-Verbose "Cluster Region: $region"

    Write-Output "----------------------------------------"
    Write-Output "Provisioning Cluster: $clustername"
    Write-Output "----------------------------------------"
    gcloud beta container clusters create $clustername --region $region --enable-ip-alias --num-nodes=1 --release-channel=rapid

    Write-Output "----------------------------------------"
    Write-Output "Cluster: $clustername has been created!"
    Write-Output "----------------------------------------"

    return
}