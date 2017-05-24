# APB walkthrough

### Use catasb to setup the env
#https://github.com/fusor/catasb/blob/dev/local/README.md
#These playbooks will:
>
1. Setup Origin through oc cluster up
2. Install Service Catalog on Origin
2. Install Ansible Service Broker on Origin
```/bin/bash
yum install python-pip
pip install ansible
pip install docker-py
pip install six
#prepare: make docker daemon run with: "--insecure-registry 172.30.0.0/16"
git clone https://github.com/fusor/catasb.git
cd catasb/local/linux
./run_setup_local.sh
```

### Install APB from source code
git clone https://github.com/fusor/ansible-playbook-bundle.git
cd ansible-playbook-bundle
pip install -r src/requirements.txt
python setup.py install

### Test out your development environment using apb-examples
git clone https://github.com/fusor/apb-examples
cd apb-examples/hello-world-apb/




#Test out your development environment using apb-examples:

