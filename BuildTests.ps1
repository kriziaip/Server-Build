
#Disks
$disks = Get-WmiObject Win32_LogicalDisk
$diskPartitions = Get-WmiObject -Class Win32_DiskPartition


#Local Accounts

Function Get-LocalAccount ($LocalAccount) {
Get-WmiObject Win32_UserAccount -ComputerName localhost -Filter "LocalAccount=True and Name = '$localaccount'" | Select-Object -ExpandProperty name

}

Function Check-RegistryValues {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        $RegistryPath,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=1)]
        $RegistryKey
    )

    Try {
        (Get-ItemProperty -Path $RegistryPath -name $RegistryKey -ErrorAction Stop).$RegistryKey
    }

    Catch {
        $Error[0].CategoryInfo.ToString()
    }
}


#Check that UAC is Disabled

Function Check-UACStatus {

$DesiredValue= "0"

$EnableLUA = (Get-ItemProperty HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system).EnableLUA

If ($EnableLUA -eq $DesiredValue){
    "Compliant"
} else {
    "Non-Compliant"
}

}

#Legal Notice

Function Check-LegalNotice {
$DesiredValue=" to logging in to this systemplease be advised that this is a private system to be used only for authorized purposes. All information viewed or printed using this system is confidential."

$LegalNoticeText = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System).legalnoticetext -replace "\r\n",""



If ($LegalNoticeText -like $DesiredValue){
    "Compliant"
} else {
    "Non-Compliant"
}
}

#This is a test for Network adapter name
Function check-NIC {

}
