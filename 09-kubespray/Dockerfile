FROM centos:7.6.1810

RUN yum upgrade -y
RUN yum install epel-release -y 
RUN yum install ansible -y
RUN yum install python36 -y
RUN yum install python3-pip -y
RUN yum install git -y
RUN pip3 install jinja2

RUN pip3 install --upgrade pip
RUN git clone https://github.com/kubernetes-incubator/kubespray.git
WORKDIR kubespray

RUN pip3 install -r requirements.txt

RUN cp -rfp inventory/sample inventory/mycluster
RUN declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
RUN CONFIG_FILE=inventory/mycluster/hosts.yml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

RUN yum install tree -y
RUN tree ./inventory