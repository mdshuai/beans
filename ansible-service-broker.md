```
openshift_additional_repos: "[{'id': 'aos36-devel-install', 'name': 'aos36-devel-install', 'baseurl': 'http://download-node-02.eng.bos.redhat.com/rcm-guest/puddles/RHAOS/AtomicOpenShift/3.6/2017-07-16.2/x86_64/os/', 'enabled': 1, 'gpgcheck': 0}]"
qe_additional_repos: "[{'id': 'rhel7', 'name': 'rhel7', 'baseurl': 'http://download.eng.bos.redhat.com/rel-eng/RHEL-7.4-20170630.1/compose/Server/x86_64/os/', 'enabled': 1, 'gpgcheck': 0},{'id': 'rhel7-extra', 'name': 'rhel7-extra', 'baseurl': 'http://download-node-02.eng.bos.redhat.com/nightly/EXTRAS-RHEL-7.4/EXTRAS-7.4-RHEL-7-20170628.n.0/compose/Server/x86_64/os', 'enabled': 1, 'gpgcheck': 0},{'id': 'fast-datapath', 'name': 'fast-datapath', 'baseurl': 'http://pulp.dist.prod.ext.phx2.redhat.com/content/dist/rhel/server/7/7Server/x86_64/fast-datapath/os', 'enabled': 1, 'gpgcheck': 0}]"
os_sdn_network_plugin_name: redhat/openshift-ovs-multitenant
image: qe-rhel-74-20170630
openshift_playbook_rpm_repos: "[{'id': 'aos36-devel-install', 'name': 'aos36-devel-install', 'baseurl': 'http://download-node-02.eng.bos.redhat.com/rcm-guest/puddles/RHAOS/AtomicOpenShift/3.6/2017-07-16.2/x86_64/os/', 'enabled': 1, 'gpgcheck': 0}]"
openshift_ansible_vars:
  openshift_disable_check: disk_availability,memory_availability,package_availability,docker_image_availability,docker_storage,package_version
  openshift_enable_service_catalog: true
  openshift_service_catalog_image_prefix: brew-pulp-docker01.web.prod.ext.phx2.redhat.com:8888/openshift3/ose-
  openshift_service_catalog_image_version: latest
  ansible_service_broker_image_prefix: brew-pulp-docker01.web.prod.ext.phx2.redhat.com:8888/openshift3/
  ansible_service_broker_image_tag: latest
  ansible_service_broker_etcd_image_prefix: quay.io/coreos/
  ansible_service_broker_etcd_image_tag: latest
  ansible_service_broker_etcd_image_etcd_path: /usr/local/bin/etcd
  ansible_service_broker_registry_type: rhcc
  ansible_service_broker_registry_url: registry.access.stage.redhat.com
  ansible_service_broker_registry_organization: openshift3
  ansible_service_broker_registry_user: ""
  ansible_service_broker_registry_password: ""




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
