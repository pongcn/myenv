#!/bin/bash
source ../.config

if [ -d "${MYENV_ROOT_PATH}/build" ]; then
    sudo rm -rf "${MYENV_ROOT_PATH}/build"; mkdir "${MYENV_ROOT_PATH}/build"
    echo "y"
else
    sudo mkdir "${MYENV_ROOT_PATH}/build"
    echo "f"
fi

sudo -s touch "${MYENV_ROOT_PATH}/build/.${pj_name}"
sudo sh -c "cat ${MYENV_MYENV_ROOT_PATH}/.config > ${MYENV_ROOT_PATH}/build/.${pj_name}"

for i in ${search_components}; do
    sudo sh -c "cat ${i} >> ${MYENV_ROOT_PATH}/build/.${pj_name}"
done

# for i in "./modules/*.sh"; do
#     sudo sh -c "cat $i >> ${MYENV_ROOT_PATH}/build/.${pjname}"
# done
