#!/usr/bin/env bash

set -u

REPO="/vagrant/linux-devops-labs"
LAB_NAME="${1:-general-lab}"

if [[ ! -d "$REPO/.git" ]]; then
    echo "ERROR: Git repository not found at $REPO"
    exit 1
fi

SAFE_NAME=$(printf '%s' "$LAB_NAME" |
    sed 's/[^A-Za-z0-9._-]/-/g')

STAMP=$(date +%Y%m%d-%H%M%S)
LOG="$REPO/sessions/${STAMP}-${SAFE_NAME}.log"

mkdir -p "$REPO/sessions" "$REPO/labs" "$REPO/scripts"

echo "Starting recorded lab: $LAB_NAME"
echo "Transcript: $LOG"
echo "Perform your lab inside the shell that opens."
echo "Type exit when the lab is finished."

script -q -f -c 'bash --noprofile --norc -i' "$LOG"
SESSION_STATUS=$?

cd "$REPO" || exit 1

git add -- sessions/ labs/ scripts/ README.md .gitignore

if ! git diff --cached --quiet; then
    if ! git commit -m "Record Linux lab: ${SAFE_NAME}"; then
        echo "Commit failed. Review git status."
        exit 1
    fi

    BRANCH=$(git branch --show-current)

    if ! git push -u origin "$BRANCH"; then
        echo "Push failed. Your commit remains local."
        echo "Resolve the issue, then run: git push"
        exit 1
    fi

    echo "Lab committed and pushed to GitHub."
else
    echo "No changes to commit."
fi

exit "$SESSION_STATUS"
