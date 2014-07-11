# Description

CentOS 6 [vbkick](https://github.com/wilas/vbkick) template. Help creates Vagrant base boxes. Vagrant SSH insecure keys are used.

## Howto

### change definition (change the target of a symlink)
```
    rm vbmachine.cfg
    ln -fs vbmachine-notgovready-centos-6.5-x86_64-noX-0.1.0.cfg vbmachine.cfg
```

### create new vagrant base box
```
    vbkick  build        CentOS_box
    vbkick  postinstall  CentOS_box
    vbkick  validate     CentOS_box
    vbkick  export       CentOS_box
```

### update existing vagrant base box
```
    vbkick  update       CentOS_box
    vbkick  validate     CentOS_box
    vbkick  export       CentOS_box
```
