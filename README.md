# myenv
 
 development environment for wsl&linux

 ## directory struture
- build # ti is compiled to here
- install.sh
- inti_modules # directroy that's include other resources be used install
- src # directroy of source code
  - main.sh # forloop components directory
  - components # directory 
    - set_proxy # proxy wsl host
    - mk8senv # fix bug for wsl install microk8s

## execute sequences of install.sh:
- install modules from [init_modules].
- cp buld/* to $HOME 

## development scheme
- add ctl