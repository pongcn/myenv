# myenv
 
 development environment for wsl&linux

 ## directory struture
- build # ti's compiled to here
- install.sh # request in .profile by it
- main.sh # forloop moduels directory
- src # directroy for source code
  - inti_modules # directroy that's include other resources be used install
  - components # directory 
    - set_proxy # proxy wsl host
    - mk8senv # fix bug for wsl install microk8s

## execute sequences of install.sh:
- install modules from [init_modules].
- cp buld/* to $HOME 

## development scheme
- add ctl