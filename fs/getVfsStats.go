package main
import (
    "fmt"
    "syscall"
)

func getVfsStats(path string) (total uint64, free uint64, avail uint64, inodes uint64, inodesFree uint64, err error) {
    var s syscall.Statfs_t
    if err = syscall.Statfs(path, &s); err != nil {
        return 0, 0, 0, 0, 0, err
    }
    total = uint64(s.Frsize) * s.Blocks
    free = uint64(s.Frsize) * s.Bfree
    avail = uint64(s.Frsize) * s.Bavail
    inodes = uint64(s.Files)
    inodesFree = uint64(s.Ffree)
    return total, free, avail, inodes, inodesFree, nil
}

func main() {
    total, free, avail, inodes, inodesFree, _ := getVfsStats("/")
    fmt.Println("total fs size is : ", total)
    fmt.Println("free  fs size is : ", free)
    fmt.Println("avail fs size is : ", avail)
    fmt.Println("total inodes  is : ", inodes)
    fmt.Println("free inodes   is : ", inodesFree)
}
