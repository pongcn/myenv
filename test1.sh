echo $PWD
echo $OLDPWD

# su root
# sudo bash
# echo override=74 -1 ./src/test1.sh
# sed -i '7s/verride=74/verride=232/' ./src/test1.sh


# $ cat ./src/test1.sh

# sed -i -e 's/override=21/override=72/g' ./src/test1.sh

# grep override ./src/test1.sh
# echo "some text" >| ./src/test1.sh
 grep ${pj_name} $HOME/.profile

 sed -s '/.myenv/d' $HOME/.profile