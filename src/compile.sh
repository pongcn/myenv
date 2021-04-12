#!/bin/bash
source ../.config

if [ -d "${root_path}/build" ]; then
    sudo rm -rf "${root_path}/build"; mkdir "${root_path}/build"
    echo "y"
else
    sudo mkdir "${root_path}/build"
    echo "f"
fi

sudo -s touch "${root_path}/build/.${pj_name}"
sudo sh -c "cat ${root_path}/.config > ${root_path}/build/.${pj_name}"

for i in ${search_components}; do
    sudo sh -c "cat ${i} >> ${root_path}/build/.${pj_name}"
done

# for i in "./modules/*.sh"; do
#     sudo sh -c "cat $i >> ${root_path}/build/.${pjname}"
# done
