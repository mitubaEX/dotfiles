# !/bin/bash
cat './script/vscode_data.txt' | while read extension
do
  code --install-extension $extension
done
