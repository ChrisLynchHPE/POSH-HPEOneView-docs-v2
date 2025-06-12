git checkout staging
$regex = "\s*(?'hashPart1'[0-9a-z]{7})..(?'hashPart2'[0-9a-z]{7})..staging -> staging"

# This will initiate a git push call, and not only capture the output but also display to console
& git push 2>&1 | tee -Variable output

$matches = [regex]::Match($output, $regex)
$HASH = $matches.Groups['hashPart2'].Value

If (-not [String]::IsNullOrEmpty($HASH)) {

    $branch = "staging-$HASH"
    git checkout -b $branch
    git push --set-upstream origin $branch
    hub pull-request -b master -h $branch -m "Updated user docs from commit $HASH" -o

    git checkout master
    git pull
    git checkout staging
    git branch $branch -d

}

