recent_tag=$(git tag --sort=-creatordate | grep -E 'v[0-9]{1,}.[0-9]{1,}.[0-9]{1,}' | head -1)
echo "recent release tag"
echo $recent_tag