# Spec Delta

## ADDED Requirements

### Requirement: CI test executor release

The packit pull-request test job SHALL execute on a Fedora 44 executor, decoupled from the Vojtux base release, so acceptance tests are not run on an aging or end-of-life executor. Delivered by `.packit.yaml` (`jobs[tests].targets`). Verified by: none (verified by the packit/Testing Farm run result on pull requests).

#### Scenario: Pull request test job runs

- **WHEN** a pull request triggers the packit `tests` job
- **THEN** Testing Farm schedules the run on a Fedora 44 executor and provisions the Vojtux VM from there

#### Scenario: Executor release does not change the distro

- **WHEN** the CI executor target is Fedora 44
- **THEN** the built Vojtux image and kickstart repository definitions still reference the base release Fedora 43
