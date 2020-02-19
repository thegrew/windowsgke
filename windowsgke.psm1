#Requires -version 5
#Requires -Modules @{ ModuleName="googlecloud";  ModuleVersion="1.0.1.10" }
#Requires -Modules @{ ModuleName="googlecloudbeta";  ModuleVersion="1.0.1.10" }
<# 

.SYNOPSIS
    A module that enables the deployment of Windows Clusters and Workloads on GKE
.DESCRIPTION
    This module is formed of a collection of functions used to manipulate Windows Clusters and Workloads on GKE

#>

#Set path to the functions
$functionpath = $PSScriptRoot + "\function\"

#Pull list of all the functions within the path
$functionlist = Get-ChildItem -Path $functionpath -Name

#Bring all the functions into memory
foreach ($function in $functionlist) {
    . ($functionpath + $function)
}