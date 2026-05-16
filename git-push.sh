git pull
git add .
git commit -m "$(date '+%Y/%m/%d %H:%M:%S')"

if [ "$1" == "--force" ]; then
    git push --force origin main
else
    git push
fi