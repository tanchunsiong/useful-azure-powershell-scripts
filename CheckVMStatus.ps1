workflow checkforprimarydown
{
    
    $credentialName = "your email address"
    $subName = "your subscription ID"
    $subId="your subscription ID"
    $serviceName1 = "wpninjavm"
    $serviceName2 = "wpninjavm2"
    $VMName1 = "wpninjavm1"
    $VMName2 = "wpninjavm2"
    
    $Cred = Get-AutomationPSCredential -Name $credentialName
    Add-AzureAccount -Credential $Cred
    
    Select-AzureSubscription -SubscriptionName $subName
    Set-AzureSubscription -SubscriptionName $subName
    $VMStatus = Get-AzureVM -ServiceName $serviceName1 -name $vmName1
    $VM2Status = Get-AzureVM -ServiceName $serviceName2 -name $VMName2
    #VM1 is running
    if ($VMStatus.InstanceStatus -eq "ReadyRole") 
    { 
  
    
     if ($VM2Status.InstanceStatus -eq "ReadyRole") 
            { 
                 Stop-AzureVM –Name $VMName2 -ServiceName $serviceName2 -force
                 Write-Output "VM1 and VM2 is up, shutting down VM2"
            }
    }
    #VM1 is dead
    else
    {
         if ($VM2Status.InstanceStatus -ne "ReadyRole") 
            { 
                Start-AzureVM –Name $VMName2 -ServiceName $serviceName2
                  Write-Output "VM1 and VM2 is down. Starting up VM2 is up"
            }
    }
  

    
}