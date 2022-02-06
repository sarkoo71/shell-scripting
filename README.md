# shell-scripting
##

## Sed Editor

```bash

#sed wit -i will edit the file
#sed without -i will print the change on output

#-e is for multiple conditions in sed commands
#-e cond1 -e cond2


#search and replace / substitute
sed -i -e 's/root/ROOT/g' 's/admin/ADMIN/g' sample.txt

#delete lines
sed -i -e '1d' '/root/ d' sample.txt

#Add lines
sed -i -e '1 i hello world' sample.txt
sed -i -e '/root/ i hello world' sample.txt
sed -i -e '1 a Hello World' sample.txt
sed -i -e '1 c Hello World' sample.txt
```