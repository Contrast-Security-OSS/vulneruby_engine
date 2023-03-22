#!/usr/bin/env bash

source "scripts/colors.sh"

PAT_VALID=false
GH_USERNAME_VALID=false

# Validates that both PAT and GH username are exported:

validate_pat() {
  if [ -z ${CR_PAT+x} ]; then
  echo -e "$RED[ERROR] $WHITE Github Personal Access Token is not set!"
  echo -e
  echo -e "        $BLUE Export:$WHITE ENV variable$YELLOW CR_PAT$WHITE with Token value."
  echo -e "        $BLUE Privileges:$WHITE — delete:packages, repo, write:packages."
  echo -e "        $BLUE SSO:$WHITE Authorize$BLUE Contrast-Security-OSS$WHITE."
  echo -e
  echo -e "        $LIGHT_BLUE Do not share your token with anyone.$WHITE"
  echo -e
else
  PAT_VALID=true
  echo -e "        $BLUE PAT:    $LIGHT_BLUE$PAT_VALID"
fi
}

validate_gh_user() {
  if [ -z ${GH_USERNAME+x} ]; then
  echo -e "$RED[ERROR] $WHITE Github username not set!"
  echo -e
  echo -e "        $BLUE Export:$WHITE ENV variable$YELLOW GH_USERNAME$WHITE with you github username."
  echo -e
else
  GH_USERNAME_VALID=true
  echo -e "        $BLUE USER:   $LIGHT_BLUE$GH_USERNAME_VALID"
fi
}
