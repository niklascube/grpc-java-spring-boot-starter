#!/usr/bin/env bash

############
RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'
PURPLE='\033[01;35m'
WHITE='\033[00m'
GREEN='\033[01;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
CLR_RESET='\033[0m'

echo -n "Enter the name of your new app and press enter? "
read answer

regex="^([a-z]{2,20})$"
if [[ $answer =~ $regex ]]; then
  echo "The name of your new app is: $answer"
  sleep 1
else
  echo "ERROR: Your app name '$answer' does not match syntax requirements!";
  echo "  *** Must match this regex: $regex"
  exit 1
fi

NAME=$answer
source_folder='src'

folder_list=($source_folder/main/java/com/pwc/myapp/*.java
             $source_folder/main/proto/*.proto
             $source_folder/test/java/com/pwc/myapp/*.java
             )

file_list=(Makefile
           Dockerfile
           build.gradle
           src/main/resources/application.properties
           src/test/resources/application.properties
           settings.gradle)

replace_string_in_file()
{
    FILE=$1
    STRING_REPLACE=$2
    ORIGIN_STRING=$3
    sed "s/$ORIGIN_STRING/$STRING_REPLACE/g" $FILE > $FILE.new
    mv $FILE.new $FILE && rm -rf $FILE.new
}

first_char_to_uppercase()
{
    STRING=$1
    echo `echo ${STRING:0:1} | tr  '[a-z]' '[A-Z]'`${STRING:1}
}

for folder in "${folder_list[@]}"
  do
    for file in $folder
      do
        replace_string_in_file $file $NAME myapp
      done
  done

for file in "${file_list[@]}"
  do
    replace_string_in_file $file $NAME myapp
  done

NAME_IN_UPPERCASE=$(first_char_to_uppercase $NAME)

# rename main java class file
mv src/main/java/com/pwc/myapp/MyAppApplication.java src/main/java/com/pwc/myapp/${NAME_IN_UPPERCASE}Application.java
mv src/test/java/com/pwc/myapp/MyAppTest.java src/test/java/com/pwc/myapp/${NAME_IN_UPPERCASE}Test.java
mv src/main/proto/MyApp.proto src/main/proto/${NAME_IN_UPPERCASE}.proto

# rename main class
replace_string_in_file src/main/java/com/pwc/myapp/${NAME_IN_UPPERCASE}Application.java $NAME_IN_UPPERCASE MyApp
replace_string_in_file src/main/java/com/pwc/myapp/HelloService.java $NAME_IN_UPPERCASE MyApp
replace_string_in_file src/test/java/com/pwc/myapp/${NAME_IN_UPPERCASE}Test.java $NAME_IN_UPPERCASE MyApp

# rename  folder
mv src/main/java/com/pwc/myapp src/main/java/com/pwc/$NAME
mv src/test/java/com/pwc/myapp src/test/java/com/pwc/$NAME

#overwrite manifests for grpc


echo -e "${GREEN} SUCCESSFULLY DONE!"
echo -e "${PURPLE} >>> You can run 'make' now to build and run image locally!"
echo -e "${PURPLE} >>> Besides that, you can use 'BloomRPC' or 'grpcurl' from Github for testing your services!"
echo -e "${CLR_RESET}"
