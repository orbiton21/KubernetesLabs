- The Kustomization re-order the `Kind` by the following order:
  Source: https://github.com/kubernetes-sigs/kustomize/blob/master/api/resid/gvk.go

```go
// An attempt to order things to help k8s, e.g.
// a Service should come before things that refer to it.
// Namespace should be first.
// In some cases order just specified to provide determinism.
var orderFirst = []string{
	"Namespace",
	"ResourceQuota",
	"StorageClass",
	"CustomResourceDefinition",
	"ServiceAccount",
	"PodSecurityPolicy",
	"Role",
	"ClusterRole",
	"RoleBinding",
	"ClusterRoleBinding",
	"ConfigMap",
	"Secret",
	"Endpoints",
	"Service",
	"LimitRange",
	"PriorityClass",
	"PersistentVolume",
	"PersistentVolumeClaim",
	"Deployment",
	"StatefulSet",
	"CronJob",
	"PodDisruptionBudget",
}

var orderLast = []string{
	"MutatingWebhookConfiguration",
	"ValidatingWebhookConfiguration",
}
```

---

<div align="center">  
    <img src="../../resources/prev.png"><img src="../../resources/prev.png"><img src="../../resources/prev.png">&nbsp;
    <a href="../07-nginx-Ingress">07-nginx-Ingress</a>
    &nbsp;&nbsp;||&nbsp;&nbsp;
    <a href="../09-StatefulSet">09-StatefulSet</a>
    &nbsp;<img src="../../resources/next.png"><img src="../../resources/next.png"><img src="../../resources/next.png">
    <br/>
</div>

---

<div align="center">  
    <small>&copy;CodeWizard LTD</small>
</div>