### Command
#### atomic
```
[root@host-8-241-39 ~]# atomic --help
usage: atomic [-h] [-v] [--debug] [-i] [-y]
              
              {containers,diff,help,images,host,info,install,mount,pull,push,upload,run,scan,sign,stop,storage,migrate,top,trust,uninstall,unmount,umount,update,verify,version}
              ...

Atomic Management Tool

positional arguments:
  {containers,diff,help,images,host,info,install,mount,pull,push,upload,run,scan,sign,stop,storage,migrate,top,trust,uninstall,unmount,umount,update,verify,version}
                        commands
    containers          operate on containers
    diff                Show differences between two container images, file
                        diff or RPMS.
    images              operate on images
    host                execute Atomic host commands
    install             execute container image install method
    mount               mount container image to a specified directory
    pull                pull latest image from a repository
    push (upload)       push latest image to repository
    run                 execute container image run method
    scan                scan an image or container for CVEs
    sign                Sign an image
    stop                execute container image stop method
    storage (migrate)   manage container storage
    top                 Show top-like stats about processes running in
                        containers
    trust               Manage system container trust policy
    uninstall           execute container image uninstall method
    unmount (umount)    unmount container image

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show atomic version and exit
  --debug               show debug messages
  -i, --ignore          ignore install-first requirement
  -y, --assumeyes       automatically answer yes for all questions

```

#### runc
```
[root@host-8-241-39 ~]# runc --help
NAME:
   runc - Open Container Initiative runtime

runc is a command line client for running applications packaged according to
the Open Container Initiative (OCI) format and is a compliant implementation of the
Open Container Initiative specification.

runc integrates well with existing process supervisors to provide a production
container runtime environment for applications. It can be used with your
existing process monitoring tools and the container will be spawned as a
direct child of the process supervisor.

Containers are configured using bundles. A bundle for a container is a directory
that includes a specification file named "config.json" and a root filesystem.
The root filesystem contains the contents of the container.

To start a new instance of a container:

    # runc run [ -b bundle ] <container-id>

Where "<container-id>" is your name for the instance of the container that you
are starting. The name you provide for the container instance must be unique on
your host. Providing the bundle directory using "-b" is optional. The default
value for "bundle" is the current directory.

USAGE:
   runc [global options] command [command options] [arguments...]
   
VERSION:
   1.0.0-rc3
commit: 116f84106c7b571482a0a71ce7f857e134631619-dirty
spec: 1.0.0-rc5
   
COMMANDS:
     checkpoint  checkpoint a running container
     create      create a container
     delete      delete any resources held by the container often used with detached container
     events      display container events such as OOM notifications, cpu, memory, and IO usage statistics
     exec        execute new process inside the container
     init        initialize the namespaces and launch the process (do not call it outside of runc)
     kill        kill sends the specified signal (default: SIGTERM) to the container's init process
     list        lists containers started by runc with the given root
     pause       pause suspends all processes inside the container
     ps          ps displays the processes running inside a container
     restore     restore a container from a previous checkpoint
     resume      resumes all processes that have been previously paused
     run         create and run a container
     spec        create a new specification file
     start       executes the user defined process in a created container
     state       output the state of a container
     update      update container resource constraints
     help, h     Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --debug             enable debug output for logging
   --log value         set the log file path where internal debug information is written (default: "/dev/null")
   --log-format value  set the format used by logs ('text' (default), or 'json') (default: "text")
   --root value        root directory for storage of container state (this should be located in tmpfs) (default: "/run/runc-ctrs")
   --criu value        path to the criu binary used for checkpoint and restore (default: "criu")
   --systemd-cgroup    enable systemd cgroup support, expects cgroupsPath to be of form "slice:prefix:name" for e.g. "system.slice:runc:434234"
   --help, -h          show help
   --version, -v       print the version
```

#### crio
```
[root@dma cri-o]# ./crio --help
NAME:
   crio - crio server

USAGE:
   crio [global options] command [command options] [arguments...]

VERSION:
   1.0.0-beta.0

COMMANDS:
     config   generate crio configuration files
     help, h  Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --apparmor-profile value   default apparmor profile name (default: "crio-default")
   --cgroup-manager value     cgroup manager (cgroupfs or systemd)
   --cni-config-dir value     CNI configuration files directory
   --cni-plugin-dir value     CNI plugin binaries directory
   --config value             path to configuration file (default: "/etc/crio/crio.conf")
   --conmon value             path to the conmon executable
   --debug                    enable debug output for logging
   --default-transport value  default transport
   --enable-metrics           enable metrics endpoint for the servier on localhost:9090
   --file-locking             enable or disable file-based locking
   --image-volumes value      image volume handling ('mkdir' or 'ignore') (default: "mkdir")
   --insecure-registry value  whether to disable TLS verification for the given registry
   --listen value             path to crio socket
   --log value                set the log file path where internal debug information is written
   --log-format value         set the format used by logs ('text' (default), or 'json') (default: "text")
   --metrics-port value       port for the metrics endpoint (default: 9090)
   --pause-command value      name of the pause command in the pause image
   --pause-image value        name of the pause image
   --pids-limit value         maximum number of processes allowed in a container (default: 1024)
   --profile                  enable pprof remote profiler on localhost:6060
   --profile-port value       port for the pprof profiler (default: 6060)
   --registry value           registry to be prepended when pulling unqualified images, can be specified multiple times
   --root value               crio root dir
   --runroot value            crio state dir
   --runtime value            OCI runtime path
   --seccomp-profile value    default seccomp profile path
   --selinux                  enable selinux support
   --signature-policy value   path to signature policy file
   --storage-driver value     storage driver
   --storage-opt value        storage driver option
   --stream-address value     bind address for streaming socket
   --stream-port value        bind port for streaming socket (default: "10010")
   --help, -h                 show help
   --version, -v              print the version
```

#### crioctl  -> replaced by [crictl](https://github.com/kubernetes-incubator/cri-tools/blob/master/docs/crictl.md)
```
[root@dma cri-o]# ./crioctl -h
NAME:
   crioctl - client for crio

USAGE:
   crioctl [global options] command [command options] [arguments...]

VERSION:
   1.0.0-beta.0

COMMANDS:
     pod             
     container, ctr  
     runtimeversion  get runtime version information
     image           
     help, h         Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --connect value  Socket to connect to (default: "/var/run/crio.sock")
   --timeout value  Timeout of connecting to server (default: 10s)
   --help, -h       show help
   --version, -v    print the version
```

#### kpod
```
[root@dma cri-o]# ./kpod -h
NAME:
   kpod - manage pods and images

USAGE:
   kpod [global options] command [command options] [arguments...]

VERSION:
   0.0.1

COMMANDS:
     diff             Inspect changes on container's file systems
     export           Export container's filesystem contents as a tar archive
     history          Show history of a specified image
     images           list images in local storage
     info             display system information
     inspect          Displays the configuration of a container or image
     load             load an image from docker archive
     logs             Fetch the logs of a container
     mount            Mount a working container's root filesystem
     ps               List containers
     pull             pull an image from a registry
     push             push an image to a specified destination
     rename           rename a container
     rm               kpod rm will remove one or more containers from the host.  The container name or ID can be used.
                                  This does not remove images.  Running containers will not be removed without the -f option.
     rmi              removes one or more images from local storage
     save             Save image to an archive
     stats            Display percentage of CPU, memory, network I/O, block I/O and PIDs for one or more containers
     tag              Add an additional name to a local image
     umount, unmount  Unmount a working container's root filesystem
     version          Display the KPOD Version Information
     help, h          Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --config value, -c value          path of a config file detailing container server configuration options
   --debug                           print debugging information
   --root value                      path to the root directory in which data, including images, is stored
   --runroot value                   path to the 'run directory' where all state information is stored
   --runtime value                   path to the OCI-compatible binary used to run containers, default is /usr/bin/runc
   --storage-driver value, -s value  select which storage driver is used to manage storage of images and containers (default is overlay2)
   --storage-opt value               used to pass an option to the storage driver
   --help, -h                        show help
   --version, -v                     print the version
```
