# 
# This docker file will load a kubespray container
# 
# Darumatic container for using kubespray
# Use imutable image tags rather than mutable tags (like ubuntu:18.04)
FROM centos:7.6.1810

# Install required libraries
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y ansible 
RUN yum install -y python36 
RUN yum install -y python-pip 
RUN yum install -y git
RUN pip install --upgrade pip
RUN pip install Jinja2


# Install kubespray
RUN git clone https://github.com/kubernetes-incubator/kubespray.git
WORKDIR /kubespray
RUN pip install -r requirements.txt

# Configure Kubespray
RUN cp -rfp inventory/sample inventory/my-cluster
RUN declare -a IPS=(10.0.0.210 10.0.0.12 10.0.0.213)