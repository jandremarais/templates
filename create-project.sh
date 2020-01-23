# while getopts n: option
# do
# case "${option}"
# in
# n) PROJECTNAME=${OPTARG};;
# esac
# done

PROJECTNAME=$1
mkdir $PROJECTNAME && cd $PROJECTNAME
mkdir tmp
git clone https://github.com/jandremarais/templates.git tmp
cp -r tmp/vscode-python/* .
rm -rf tmp
sed -i 's/name = ".*"/name = "'"${PROJECTNAME}"'"/' pyproject.toml
sed -i 's/user: user/user: '"$USER"'/' .devcontainer/docker-compose.yml