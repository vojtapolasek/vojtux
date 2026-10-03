# Tasks

## 1. Update the packit test target

- [x] 1.1 Change the `tests` job target in `.packit.yaml` from `fedora-42` to `fedora-44`; verify with `grep -n "fedora-44" .packit.yaml` that the target line now reads `- fedora-44`
- [x] 1.2 Confirm no stale `fedora-42` reference remains anywhere in the repo; verify `grep -rn "fedora-42" . --exclude-dir=.git` returns no matches

## 2. Verify the change behaves as specified

- [x] 2.1 Validate the change artifacts; verify `openspec validate bump-packit-target-to-fedora-44 --strict` passes
- [x] 2.2 Confirm the Vojtux base is untouched by this change; verify `grep -n "43" ks/repos.ks` still shows Fedora 43 repositories and the Readme still states Fedora 43 as the base
- [ ] 2.3 Trigger the packit pull-request job (open/push a PR) and confirm the Testing Farm run is scheduled on a Fedora 44 executor; verify the run metadata names `fedora-44` and the tmt plan still provisions the Vojtux VM
