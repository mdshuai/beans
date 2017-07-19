```
1. create storageclass then redeploy asb service.
oc create -f https://raw.githubusercontent.com/mdshuai/testfile-openshift/master/storageclass/cinder-default.json
oc create -f https://raw.githubusercontent.com/mdshuai/testfile-openshift/master/storageclass/pvc-cinder.json -n openshift-ansible-service-broker

2. Bootstrap
export svc=172.30.73.70
curl -H 'X-Broker-API-Version: 2.9' -X POST http://${svc}:1338/v2/bootstrap

3. Recreate broker
oc delete broker ansible-service-broker
oc create -f https://raw.githubusercontent.com/mdshuai/testfile-openshift/master/ansible-service-broker/broker.yaml

4. 
oadm policy add-cluster-role-to-user cluster-admin system:serviceaccount:kube-service-catalog:service-catalog-controller   -> can't delete broker,serviceclass;
oadm policy add-cluster-role-to-user cluster-admin system:serviceaccount:openshift-ansible-service-broker:asb
oadm pod-network join-projects --to=openshift-ansible-service-broker kube-service-catalog  (no need)

5. Enalbe catalog-console & template-service-broker in "/etc/origin/master/master-config.yaml"
admissionConfig:
  pluginConfig:
    PodPreset:
      configuration:
        kind: DefaultAdmissionConfig
        apiVersion: v1
        disable: false
assetConfig:
  extensionScripts:
  - /etc/origin/master/openshift-ansible-catalog-console.js
kubernetesMasterConfig:
  apiServerArguments:
    runtime-config:
    - apis/settings.k8s.io/v1alpha1=true
templateServiceBrokerConfig:
  - templateNamespaces: openshift


# cat /etc/origin/master/openshift-ansible-catalog-console.js
window.OPENSHIFT_CONSTANTS.ENABLE_TECH_PREVIEW_FEATURE.service_catalog_landing_page = true;
window.OPENSHIFT_CONSTANTS.ENABLE_TECH_PREVIEW_FEATURE.pod_presets = true;

5. Create template-service-broker
oadm policy add-cluster-role-to-user cluster-admin dma
curl -k -H "X-Broker-API-Version: 2.12" -H "Authorization: Bearer oLHF6t2o6reGO-O4UjsPeALItFtSlACjh8YlbF0eUrE" https://host-8-175-186.host.centralci.eng.rdu2.redhat.com:8443/brokers/template.openshift.io
curl -k -H "X-Broker-API-Version: 2.12" https://dma:dma@host-8-175-186.host.centralci.eng.rdu2.redhat.com:8443/brokers/template.openshift.io/v2/catalog

//
sudo oc cluster up --image=brew-pulp-docker01.web.prod.ext.phx2.redhat.com:8888/openshift3/ose --version=v3.6 --service-catalog
```
