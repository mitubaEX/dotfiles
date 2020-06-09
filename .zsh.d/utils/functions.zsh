# unset aws env
function unsetaws() {
  env | grep -E 'aws|AWS' | awk -F '=' '{print $1}' | while read env ; do unset $env ;done
}

# create_vim_plugin
function create_vim_plugin() {
  git clone https://github.com/mitubaEX/create_vim_plugin.git
  rm create_vim_plugin/.git
  mv create_vim_plugin/* . && mv create_vim_plugin/.* .
  rm create_vim_plugin

  find . -name "*sampleapp*" -type f | while read filename
  do
    dirname=$(dirname $filename)
    extension="${filename##*.}"

    # rename include file string
    sed -i '' "s/sampleapp/$1/g" $filename

    # rename file name
    mv $filename "$dirname/$1.$extension"
  done
}
