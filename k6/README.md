# K6 Guideline
## Table of Contents
1. [K6 Installation](#k6-installation)
    - [MacOS](#macos)
    - [Windows](#windows)
2. [Running K6](#running-k6)
    - [Local](#local)
    - [Grafana Cloud](#grafana-cloud)
        - [Running on Grafana Cloud](#running-on-grafana-cloud)
# K6 Installation
* ## MacOS
    Using Homebrew
    ```sh
    brew install k6
    ```
* ## Windows
    If you use the [Chocolatey package manager](https://chocolatey.org/) you can install the unofficial k6 package with:
    ```sh
    choco install k6
    ```
    If you use the [Windows Package Manager](https://github.com/microsoft/winget-cli), install the official packages from the [k6 manifests (created by the community)](https://github.com/microsoft/winget-pkgs/tree/master/manifests/k/k6/k6)
    ```sh
    winget install k6 --source winget
    ```
# Running K6
We have two method to run the k6, locally or by Grafana cloud. The recommendation is using [Grafana Cloud](https://grafana.com/) but it is not free, we can run locally just makesure the internet connection is stable.
* ## Local
    Since on our performance test have multiple scenario, we can run
    ```sh
    # On k6 directory
    cd k6
    # Run the test
    SCENARIO=scenario_baseline k6 run load_test/load_test.js
    ```
    if you run without `SCENARIO` it will run the default scenario that setup on the script
    ```sh
    k6 run load_test/load_test.js
    ```
* ## Grafana Cloud
    When using Grafana Cloud you must have the Grafana Cloud account and Personal API Token first. Follow below steps:    
    1. Copy-paste the `config.json.sample` to `config.json`
    2. Go to https://youraccount.grafana.net/a/k6-app/settings/api-token
    copy the Personal API Token
    3. Paste the Personal API Token to `config.collectors.cloud.token` in `config.json`
    4. If you create different project you can copy the project ID to `config.collectors.cloud.projectID` in `config.json`

    ### Running on Grafana Cloud
    After all setup on `config.json` done we can proceed to run it on cloud by
    ```sh
    # On k6 directory
    # This will run default scenario on script
    k6 cloud --config config.json load_test/load_test.js
    ```
    Run with specific scenario
    ```sh
    # On k6 directory
    k6 cloud --config config.json --env SCENARIO=scenario_10_vus load_test/load_test.js
    ```
