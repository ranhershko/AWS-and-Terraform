#!/bin/bash
export done_ok=0
command -v az
if [ "$?" -ne 0 ]; then
  echo "Azure cli isn't installed - please install and add to the shell path environment variable"
  exit 404
fi
echo "Use the next info for Azure cloud login"
az login
while read -p 'Please supply uniq Azure Service principal name: ' service_prinicipal; do
  if [ -z ${service_prinicipal} ]; then
    echo "The input you supplied ${service_prinicipal} isn't uniq"
  else
    sp_cmd_output=`az ad sp create-for-rbac --name ${service_prinicipal}`
    if [ `echo -n ${sp_cmd_output}|grep appId|wc -l` != 1 ]; then
      if [ ${sp_cmd_output} ] ; then
        echo "The input you supplied \"${service_prinicipal}\" is Illegal"
      else
        app_id=`echo $sp_cmd_output|sed 's/\"//g'|awk -F"' '|\,|{" '{print $2}'|awk '{print $2}'`
        app_secret=`echo $sp_cmd_output|sed 's/\"//g'|awk -F"' '|\,|{" '{print $5}'|awk '{print $2}'`
        tenant_id=`echo $sp_cmd_output|sed 's/\"//g'|awk -F"' '|\,|{" '{print $6}'|awk '{print $2}'`
        break
        #exit ${done_ok}
      fi
    else
      echo ${sp_cmd_output}
    fi
  fi
done
echo appid: $app_id
echo appsecret: $app_secret
echo tenantid: $tenant_id

