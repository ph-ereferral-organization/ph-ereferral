# PH eReferral — End-to-End Test Harness

This directory contains the end-to-end test infrastructure for the PH eReferral IG. Tests are generated automatically from the workflow state machine and executed against a containerised HAPI FHIR server.

---

## Architecture overview

The test pipeline is split into two workflows — one to generate, one to run:

```
State machine YAML
  └─► [Workflow 1: Generate] ──► generated/json/*.json  (committed to repo)
                                  generated/tsh/*.tsh   (committed to repo)
                                          │
                              [Workflow 2: Run Tests]
                                          │
                                    sushi .  (FSH → fsh-generated/resources/)
                                          │
                                    HAPI FHIR server (Docker)
                                          │
                                    fhirtest × N  (TestScript runner)
                                          │
                                    JUnit XML → HTML report
```

**Workflow 1 — Generate TestScripts** (`generate-testscripts.yml`):
Clones the `fhir-frog` repository, builds `fhir-frog-mbt`, runs `TestScriptGenerator` against the state machine model, and commits the generated JSON and TSH files back to the branch. This is a manual (`workflow_dispatch`) trigger so that generation is an intentional act — the generated files are version-controlled and serve as the stable test suite.

**Workflow 2 — Run Tests** (`run-workflow-tests.yml`):
Triggered automatically on push to `80-workflow-state-machine` and `main`, and also manually. Assumes the generated JSON files are already present. Runs SUSHI, bootstraps a HAPI FHIR server with the IG pre-loaded, runs all TestScripts, and publishes a GitHub check with the results.

---

## Prerequisites (local development)

| Tool | Version | Install |
|------|---------|---------|
| Java | 21+ | `sdk install java 21-tem` or OS package |
| Docker | any recent | <https://docs.docker.com/engine/install/> |
| Ant | 1.10+ | `sudo apt install ant ant-optional` / `brew install ant` |
| ant-contrib | 1.0b3 | see [First-time setup](#first-time-setup) |
| Node.js / npm | 18+ | <https://nodejs.org/> |
| fsh-sushi | latest | `npm install -g fsh-sushi` |
| fpl | latest | `npm install -g fhir-package-loader` |
| fhir-frog Ant JAR | 0.1.1-main-SNAPSHOT | `ant fetch-jar` (see below) |
| fhir-frog-mbt JAR | 0-SNAPSHOT | built locally (see below) |

---

## First-time setup

### 1. Download the fhir-frog Ant JAR

From inside the `tests/` directory:

```bash
ant fetch-jar
```

This downloads the fat JAR to `~/.fhir-frog/lib/` and caches it for future runs.

### 2. Build the fhir-frog-mbt JAR

`fhir-frog-mbt` is not yet published to Maven Central; build it from source:

```bash
git clone https://github.com/aehrc/fhir-frog.git /tmp/fhir-frog
cd /tmp/fhir-frog
mvn install -pl fhir-frog-mbt -am -DskipTests
```

The JAR will be installed to your local Maven repository at:

```
~/.m2/repository/au/csiro/fhir/fhir-frog-mbt/0-SNAPSHOT/fhir-frog-mbt-0-SNAPSHOT.jar
```

The `fhir.frog.mbt.jar` property in `build.properties` points to this path.

### 3. Install ant-contrib

ant-contrib provides `<trycatch>` and `<for>`, which are used by the `test` target.

```bash
# Debian/Ubuntu
wget -O /tmp/ant-contrib.jar \
  https://repo1.maven.org/maven2/ant-contrib/ant-contrib/1.0b3/ant-contrib-1.0b3.jar
sudo cp /tmp/ant-contrib.jar /usr/share/java/ant-contrib.jar

# macOS (Homebrew)
brew install ant-contrib
```

### 4. Pre-populate the FHIR package cache

```bash
cd tests
ant cache-packages
```

This calls `fpl install` for each IG dependency declared in `../sushi-config.yaml` and caches the packages in `~/.fhir/packages/`.

---

## Workflow 1: Generate TestScripts

### From the state machine YAML to JSON TestScripts

The state machine is defined in `tests/state-model/referral-workflow-state-machine.yaml`. The `TestScriptGenerator` class in `fhir-frog-mbt` reads the `ReferralWorkflowModel` (a Java FSM derived from that YAML) and generates two artefacts:

- `tests/generated/json/` — FHIR TestScript JSON files, ready for `fhirtest`
- `tests/generated/tsh/` — TestScript Shorthand (`.tsh`) source, for human review

### Run locally

```bash
cd tests
ant generate
```

### Run via GitHub Actions

Trigger the **"Generate TestScripts from State Machine"** workflow from the Actions tab. The generated files are committed back to the current branch with a `[skip ci]` commit to avoid a test loop.

---

## Workflow 2: Run Tests

### What happens

1. SUSHI compiles `input/fsh/` → `fsh-generated/resources/`
2. `ant init` reads `../sushi-config.yaml`, generates `.fhir-frog/application.yaml` and `.fhir-frog/docker-compose.yml`
3. `ant bootstrap` starts HAPI via Docker Compose (bootstrap profile), waits for the server to be ready, loads the IG packages, and commits the container as a Docker image. This is slow (~20 minutes) on first run; subsequent runs skip straight to starting the committed image.
4. `ant test` starts the test container, iterates over all `*.json` files in `tests/generated/json/`, and for each:
   a. Runs the TestScript against `${server.url}`
   b. Resets server state via `$expunge` (see [Server reset](#server-reset))
5. Generates an HTML report in `tests/test-reports/html/`

### Run locally

```bash
# From the repo root, compile FSH first
sushi .

# Then from the tests/ directory
cd tests
ant test
```

To skip the bootstrap (if you already have the image):

```bash
cd tests
ant test -Dbootstrap.skip=true   # TODO: verify this flag name with fhirbootstrap
```

### Run via GitHub Actions

Push to `80-workflow-state-machine` or `main`, or trigger **"Run Workflow End-to-End Tests"** manually from the Actions tab.

---

## Server reset

Between individual TestScripts, the HAPI server state is cleared using HAPI's `$expunge` operation:

```
POST [base]/$expunge
Content-Type: application/fhir+json

{"resourceType":"Parameters","parameter":[{"name":"expungeEverything","valueBoolean":true}]}
```

This deletes all resources from the server, ensuring each TestScript starts from a clean slate. HAPI requires `expunge_enabled: true` in its configuration; the `init` target patches this into the generated `application.yaml` automatically.

---

## Viewing results

**Local**: Open `tests/test-reports/html/index.html` in a browser after an `ant test` run.

**GitHub Actions CI**: After the *"Run Workflow End-to-End Tests"* workflow completes, test results are published as a GitHub check on the branch (via `dorny/test-reporter`). Click **"Workflow E2E Tests"** in the Checks tab of the commit or PR to see per-test pass/fail detail.

JUnit XML files are also uploaded as a workflow artefact (`junit-xml-results`) in the Actions run, available for 90 days.

---

## State machine source

The authoritative state machine is:

```
tests/state-model/referral-workflow-state-machine.yaml
```

A PlantUML diagram is available at `tests/state-model/referral-workflow-state-machine.puml`.

To update the test suite after changing the state machine:

1. Edit `referral-workflow-state-machine.yaml`
2. Update `ReferralWorkflowModel.java` in `fhir-frog-mbt` to reflect any new states or transitions
3. Run `ant generate` (locally) or trigger the **"Generate TestScripts from State Machine"** workflow
4. Commit the updated generated files

---

## Directory structure

```
tests/
├── build.xml                  — Ant build file (all targets)
├── build.properties           — Default property values
├── README.md                  — This file
├── fixtures/                  — Supporting FHIR resources (Patient, Organization, PractitionerRole)
│   ├── Patient-example.json
│   ├── Organization-referring.json
│   ├── Organization-receiving.json
│   └── PractitionerRole-requester.json
├── generated/                 — Generated by 'ant generate' / Workflow 1 (committed)
│   ├── json/                  — FHIR TestScript JSON (consumed by 'ant test')
│   └── tsh/                   — TestScript Shorthand source (human-readable)
└── state-model/               — State machine source
    ├── referral-workflow-state-machine.yaml
    └── referral-workflow-state-machine.puml
```

IG examples compiled by SUSHI are in `../fsh-generated/resources/` (relative to this directory) and can be referenced by TestScript fixtures using that path.
