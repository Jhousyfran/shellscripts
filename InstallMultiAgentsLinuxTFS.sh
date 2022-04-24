#! /bin/sh

dirTFS="/tfs"
linkDownloadInstaller="https://vstsagentpackage.azureedge.net/agent/2.181.2/vsts-agent-linux-x64-2.181.2.tar.gz"
urlTFS=""
userAuthTFS=""
userPassTFS=""
poolAgent="Azure Servers"
agentName="agent_0"
machineName="_svrvm01"
countAgents=9
currentAgent=1

echo "--- --- --- --- --- --- --- --- --- ---Start Script --- --- --- --- --- --- --- --- --- --- ---"
echo "."
echo "."
echo "."
echo "."
echo "--- --- --- --- --- --- --- --- ---  Download Installer --- --- --- --- --- --- --- --- --- ---"

#stty -echo
#printf "sudo password: "
#read PASSWORD
#stty echo

cd /tmp
wget -O InstallerAgentsTFS $linkDownloadInstaller


while [ ${currentAgent} -le ${countAgents} ];
do
       
    echo "==== Start Install Agent -> [ 0$currentAgent ] =========== \n \n \n \n"
    cd $dirTFS
    mkdir agent_0$currentAgent
    cd $dirTFS/agent_0$currentAgent
    cp /tmp/InstallerAgentsTFS ./

    echo "==== Unzip installer -> [ 0$currentAgent ] ==============="
    tar zxvf InstallerAgentsTFS
    rm -f InstallerAgentsTFS

    echo "==== Permissions in Directory -> [ 0$currentAgent ] ======"
    sudo chown -R $USER:$USER $dirTFS/agent_0$currentAgent

    echo "==== Config Agent -> [ 0$currentAgent ] =================="
    ./config.sh --unattended --url $urlTFS $ur --auth negotiate --userName $userAuthTFS --password $userPassTFS --pool "$poolAgent" --agent $agentName$currentAgent$machineName --acceptTeeEula

    echo "==== Config Service on Agent -> [ 0$currentAgent ] ======"
    sudo ./svc.sh install
    sudo ./svc.sh start


    currentAgent=$((currentAgent+1))
done