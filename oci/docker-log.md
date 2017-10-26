1. if docker "--log-driver=json-file" every container has one log file:
/var/lib/docker/containers/${containerid}/${containerid}-json.log

2. kubelet will create symbolic link for those log file under "/var/log/pods/" as pod log
3. kubelet will create symbolic link in "/var/log/containers/"

```
    [root@ip-172-18-13-24 containers]# pwd
    /var/lib/docker/containers
    [root@ip-172-18-13-24 containers]# ls -l `find ./ -name *.log`
    -rw-r-----. 1 root root    3730 Oct 24 22:52 ./3fdf481ea6475e11e639c5e92dd1605897662c959347014c6b071804a4253c44/3fdf481ea6475e11e639c5e92dd1605897662c959347014c6b071804a4253c44-json.log
    -rw-r-----. 1 root root 3036553 Oct 24 23:12 ./4f714611c90d251d7361efa4dd84095aa729bb21426bed7518da350c87b23a1f/4f714611c90d251d7361efa4dd84095aa729bb21426bed7518da350c87b23a1f-json.log
    -rw-r-----. 1 root root   10410 Oct 24 23:11 ./5f2eb1592258ca6ccfb79853ccf7f02b5c3cf538301df378b561480827fcb535/5f2eb1592258ca6ccfb79853ccf7f02b5c3cf538301df378b561480827fcb535-json.log
    -rw-r-----. 1 root root     356 Oct 24 23:02 ./676f74ea8314721ccbc03685ef74c72e4c1f5192757121297b612e3f1fc4e006/676f74ea8314721ccbc03685ef74c72e4c1f5192757121297b612e3f1fc4e006-json.log
    -rw-r-----. 1 root root       0 Oct 24 22:47 ./6b16992ad046a27db649fe98fcdcb67b3ab433df3849e92b9874c158dfbf2f6b/6b16992ad046a27db649fe98fcdcb67b3ab433df3849e92b9874c158dfbf2f6b-json.log
    -rw-r-----. 1 root root       0 Oct 24 22:52 ./70a909f9afa3c82b52f6c1ac4ad86b655c8296c58d5cf576684118c5985a2b46/70a909f9afa3c82b52f6c1ac4ad86b655c8296c58d5cf576684118c5985a2b46-json.log
    -rw-r-----. 1 root root    3180 Oct 24 22:52 ./7d5d768127a3d851da8dfbc6ab84636a1dfba3218519725431ce48d9ad049537/7d5d768127a3d851da8dfbc6ab84636a1dfba3218519725431ce48d9ad049537-json.log
    -rw-r-----. 1 root root    1581 Oct 24 23:07 ./a6965e665ad29c0c2b3a8357133505136ba23626675fa341996a34ead7618e71/a6965e665ad29c0c2b3a8357133505136ba23626675fa341996a34ead7618e71-json.log
    -rw-r-----. 1 root root       0 Oct 24 22:50 ./aa97a364e5359706e32cf996c8e2f94bd2217b40b7fbf7730e7bf6dfffce743e/aa97a364e5359706e32cf996c8e2f94bd2217b40b7fbf7730e7bf6dfffce743e-json.log
    -rw-r-----. 1 root root   15056 Oct 24 23:10 ./fdaa29a4ff4d182b52b0dbfa50fe0c673144d0e81497d51d54fbb97491043746/fdaa29a4ff4d182b52b0dbfa50fe0c673144d0e81497d51d54fbb97491043746-json.log
    [root@ip-172-18-13-24 containers]# cd /var/log/pods/
    [root@ip-172-18-13-24 pods]# ls -l
    total 0
    drwxr-xr-x. 2 root root  28 Oct 24 22:50 4cc1675e-b92f-11e7-aebd-0e74bc4dd0d2
    drwxr-xr-x. 2 root root 132 Oct 24 22:52 6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2
    drwxr-xr-x. 2 root root  26 Oct 24 22:48 bb9c66c5-b92e-11e7-aebd-0e74bc4dd0d2
    [root@ip-172-18-13-24 pods]# ls -l `find ./ -name *.log`
    lrwxrwxrwx. 1 root root 165 Oct 24 22:50 ./4cc1675e-b92f-11e7-aebd-0e74bc4dd0d2/registry_0.log -> /var/lib/docker/containers/4f714611c90d251d7361efa4dd84095aa729bb21426bed7518da350c87b23a1f/4f714611c90d251d7361efa4dd84095aa729bb21426bed7518da350c87b23a1f-json.log
    lrwxrwxrwx. 1 root root 165 Oct 24 22:52 ./6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2/alert-buffer_0.log -> /var/lib/docker/containers/676f74ea8314721ccbc03685ef74c72e4c1f5192757121297b612e3f1fc4e006/676f74ea8314721ccbc03685ef74c72e4c1f5192757121297b612e3f1fc4e006-json.log
    lrwxrwxrwx. 1 root root 165 Oct 24 22:52 ./6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2/alertmanager_0.log -> /var/lib/docker/containers/a6965e665ad29c0c2b3a8357133505136ba23626675fa341996a34ead7618e71/a6965e665ad29c0c2b3a8357133505136ba23626675fa341996a34ead7618e71-json.log
    lrwxrwxrwx. 1 root root 165 Oct 24 22:52 ./6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2/alerts-proxy_0.log -> /var/lib/docker/containers/5f2eb1592258ca6ccfb79853ccf7f02b5c3cf538301df378b561480827fcb535/5f2eb1592258ca6ccfb79853ccf7f02b5c3cf538301df378b561480827fcb535-json.log
    lrwxrwxrwx. 1 root root 165 Oct 24 22:52 ./6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2/prometheus_0.log -> /var/lib/docker/containers/7d5d768127a3d851da8dfbc6ab84636a1dfba3218519725431ce48d9ad049537/7d5d768127a3d851da8dfbc6ab84636a1dfba3218519725431ce48d9ad049537-json.log
    lrwxrwxrwx. 1 root root 165 Oct 24 22:52 ./6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2/prom-proxy_0.log -> /var/lib/docker/containers/3fdf481ea6475e11e639c5e92dd1605897662c959347014c6b071804a4253c44/3fdf481ea6475e11e639c5e92dd1605897662c959347014c6b071804a4253c44-json.log
    lrwxrwxrwx. 1 root root 165 Oct 24 22:48 ./bb9c66c5-b92e-11e7-aebd-0e74bc4dd0d2/router_0.log -> /var/lib/docker/containers/fdaa29a4ff4d182b52b0dbfa50fe0c673144d0e81497d51d54fbb97491043746/fdaa29a4ff4d182b52b0dbfa50fe0c673144d0e81497d51d54fbb97491043746-json.log
    [root@ip-172-18-13-24 pods]#
    [root@ip-172-18-13-24 pods]# cd /var/log/containers/
    [root@ip-172-18-13-24 containers]# ls
    docker-registry-1-gxwwb_default_registry-4f714611c90d251d7361efa4dd84095aa729bb21426bed7518da350c87b23a1f.log
    prometheus-2081252548-zf7kg_prometheus_alert-buffer-676f74ea8314721ccbc03685ef74c72e4c1f5192757121297b612e3f1fc4e006.log
    prometheus-2081252548-zf7kg_prometheus_alertmanager-a6965e665ad29c0c2b3a8357133505136ba23626675fa341996a34ead7618e71.log
    prometheus-2081252548-zf7kg_prometheus_alerts-proxy-5f2eb1592258ca6ccfb79853ccf7f02b5c3cf538301df378b561480827fcb535.log
    prometheus-2081252548-zf7kg_prometheus_prometheus-7d5d768127a3d851da8dfbc6ab84636a1dfba3218519725431ce48d9ad049537.log
    prometheus-2081252548-zf7kg_prometheus_prom-proxy-3fdf481ea6475e11e639c5e92dd1605897662c959347014c6b071804a4253c44.log
    router-1-k5r2h_default_router-fdaa29a4ff4d182b52b0dbfa50fe0c673144d0e81497d51d54fbb97491043746.log
    [root@ip-172-18-13-24 containers]# ls -l
    total 0
    lrwxrwxrwx. 1 root root 65 Oct 24 22:50 docker-registry-1-gxwwb_default_registry-4f714611c90d251d7361efa4dd84095aa729bb21426bed7518da350c87b23a1f.log -> /var/log/pods/4cc1675e-b92f-11e7-aebd-0e74bc4dd0d2/registry_0.log
    lrwxrwxrwx. 1 root root 69 Oct 24 22:52 prometheus-2081252548-zf7kg_prometheus_alert-buffer-676f74ea8314721ccbc03685ef74c72e4c1f5192757121297b612e3f1fc4e006.log -> /var/log/pods/6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2/alert-buffer_0.log
    lrwxrwxrwx. 1 root root 69 Oct 24 22:52 prometheus-2081252548-zf7kg_prometheus_alertmanager-a6965e665ad29c0c2b3a8357133505136ba23626675fa341996a34ead7618e71.log -> /var/log/pods/6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2/alertmanager_0.log
    lrwxrwxrwx. 1 root root 69 Oct 24 22:52 prometheus-2081252548-zf7kg_prometheus_alerts-proxy-5f2eb1592258ca6ccfb79853ccf7f02b5c3cf538301df378b561480827fcb535.log -> /var/log/pods/6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2/alerts-proxy_0.log
    lrwxrwxrwx. 1 root root 67 Oct 24 22:52 prometheus-2081252548-zf7kg_prometheus_prometheus-7d5d768127a3d851da8dfbc6ab84636a1dfba3218519725431ce48d9ad049537.log -> /var/log/pods/6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2/prometheus_0.log
    lrwxrwxrwx. 1 root root 67 Oct 24 22:52 prometheus-2081252548-zf7kg_prometheus_prom-proxy-3fdf481ea6475e11e639c5e92dd1605897662c959347014c6b071804a4253c44.log -> /var/log/pods/6faf62dd-b92f-11e7-aebd-0e74bc4dd0d2/prom-proxy_0.log
    lrwxrwxrwx. 1 root root 63 Oct 24 22:48 router-1-k5r2h_default_router-fdaa29a4ff4d182b52b0dbfa50fe0c673144d0e81497d51d54fbb97491043746.log -> /var/log/pods/bb9c66c5-b92e-11e7-aebd-0e74bc4dd0d2/router_0.log
```



4. If docker "--log-driver=journald", The journald logging driver sends container logs to the systemd journal. 
so kubelet no need create symbolic link under "/var/log/containers/" ; we can get the container log by `journalctl CONTAINER_NAME=xxx`

```
[root@ip-172-18-14-252 ~]# journalctl CONTAINER_NAME=k8s_hello-pod_hello-pod_test_bfc9c41f-b944-11e7-a3e7-0e2f10c80876_0
-- Logs begin at Tue 2017-10-24 22:26:22 EDT, end at Wed 2017-10-25 01:25:43 EDT. --
Oct 25 01:25:05 ip-172-18-14-252.ec2.internal dockerd-current[9328]: serving on 8888
Oct 25 01:25:05 ip-172-18-14-252.ec2.internal dockerd-current[9328]: serving on 8080
```
