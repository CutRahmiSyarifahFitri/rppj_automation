import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";
import http from 'k6/http';
import { sleep, check, fail } from 'k6';

const scenario = __ENV.SCENARIO || 'scenario_baseline'; // Default scenario

const allScenarios = {
    scenario_baseline: {
        executor: 'ramping-vus',
        startVUs: 0,
        stages: [
            { duration: '1m', target: 10 }
        ],
        exec: 'scenario_baseline',
    },
    scenario_10_vus: {
        executor: 'ramping-vus',
        startVUs: 0,
        stages: [
            { duration: '1m', target: 10 },
            { duration: '5m', target: 10 },
            { duration: '1m', target: 0 },
        ],
        exec: 'scenario_10_vus',
    },
    scenario_25_vus: {
        executor: 'ramping-vus',
        startVUs: 0,
        stages: [
            { duration: '1m', target: 25 },
            { duration: '5m', target: 25 },
            { duration: '1m', target: 0 },
        ],
        exec: 'scenario_25_vus',
    },
    scenario_50_vus: {
        executor: 'ramping-vus',
        startVUs: 0,
        stages: [
            { duration: '1m', target: 50 },
            { duration: '5m', target: 50 },
            { duration: '1m', target: 0 },
        ],
        exec: 'scenario_50_vus',
    },
    scenario_75_vus: {
        executor: 'ramping-vus',
        startVUs: 0,
        stages: [
            { duration: '1m', target: 75 },
            { duration: '5m', target: 75 },
            { duration: '1m', target: 0 },
        ],
        exec: 'scenario_75_vus',
    },
    scenario_100_vus: {
        executor: 'ramping-vus',
        startVUs: 0,
        stages: [
            { duration: '1m', target: 100 },
            { duration: '5m', target: 100 },
            { duration: '1m', target: 0 },
        ],
        exec: 'scenario_100_vus',
    },
    scenario_200_vus: {
        executor: 'ramping-vus',
        startVUs: 0,
        stages: [
            { duration: '1m', target: 200 },
            { duration: '5m', target: 200 },
            { duration: '1m', target: 0 },
        ],
        exec: 'scenario_200_vus',
    },
    scenario_1_request_per_minute_in_5_min: {
        executor: 'ramping-vus',
        startVUs: 0,
        stages: [
            { duration: '1m', target: 1 },
            { duration: '5m', target: 1 },
            { duration: '1m', target: 0 },
        ],
        exec: 'scenario_1_request_per_minute_in_5_min', // change sleep to 60 for achieve 1 req per minute
    },
    scenario_1_request_per_minute_in_10_min: {
        executor: 'ramping-vus',
        startVUs: 0,
        stages: [
            { duration: '1m', target: 1 },
            { duration: '10m', target: 1 },
            { duration: '1m', target: 0 },
        ],
        exec: 'scenario_1_request_per_minute_in_10_min', // change sleep to 60 for achieve 1 req per minute
    },
};

// Ensure the selected scenario is valid
if (!allScenarios[scenario]) {
    throw new Error(`Invalid SCENARIO environment variable: ${scenario}`);
}

// Dynamically set the options based on the selected scenario
export let options = {
    scenarios: {
        [scenario]: allScenarios[scenario]
    },
};

function getBearerToken() {
    const authUrl = 'https://safety.ugems.id/token';
    const authPayload = {
        username: 'admin',
        password: 'admin',
        grant_type: '',
        scope: '',
        client_id: '',
        client_secret: ''
    };

    const authHeaders = {
        'Content-Type': 'application/x-www-form-urlencoded',
    };

    const encodedPayload = Object.keys(authPayload)
        .map(key => `${encodeURIComponent(key)}=${encodeURIComponent(authPayload[key])}`)
        .join('&');

    let authResponse = http.post(authUrl, encodedPayload, { headers: authHeaders });
    let authResponseJson = JSON.parse(authResponse.body);

    check(authResponse, {
        'auth response status is 200': (r) => r.status === 200,
        'access_token is present': (r) => {
            if (authResponseJson.access_token === '') {
                console.error(`token is not present`);
                return false;
            }
            console.log('===: Token verified')
            return true;
        },
        'token_type is bearer': (r) => authResponseJson.token_type === 'bearer',
    });

    return authResponseJson.access_token;
}

export function setup() {
    return {
        token: getBearerToken(),
    };
}

function performRequest(token) {
    const apiUrl = 'https://safety.ugems.id/search_keyword';
    // const apiUrl = 'https://insting.borneo-indobara.com/api/ugems/search_keyword';
    const payload = JSON.stringify({
        query_string: 'bahaya jalan licin',
        top_k: 100,
        area: 'Hauling',
        location_name: 'Nursery kusan',
        sublocation_name: 'Nursery kusan',
        synonym: false,
        translate_only: false
    });

    const headers = {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
    };

    let response = http.post(apiUrl, payload, { headers: headers });
    let responseJson = {};
    console.log(`====:Request made at: ${new Date().toISOString()}`);
    console.log(`====: Response code: ${response.status}`)
    // console.log('====: payload', payload)
    // console.log('====: response', response)
    
    let checkRes = check(response, {
        'response status is 200': (r) => {
            const check = r.status === 200;
            if (!check) {
                console.error(`API request failed with status ${r.status}`);
            } else {
                responseJson = JSON.parse(r.body);
            }
            return check;
        },
    });

    // console.log(`===: Check Res: ${checkRes}`)
    // if (checkRes) {
    //     checkRes = check(responseJson, {
    //         'retrieval is success': (json) => {
    //             const check = json.message === 'Retrieval Success';
    //             if (!check) {
    //                 console.error(`API response message is not "Retrieval Success"`);
    //             }
    //             return check;
    //         },
    //     });
    // }

    // if (!checkRes) {
    //     fail('One or more checks failed');
    // }

    sleep(1); // default is 1 seconds
}

// Scenario functions
export function scenario_baseline(data) {
    console.log(`====: run scenario_baseline`)
    performRequest(data.token);
}

export function scenario_10_vus(data) {
    performRequest(data.token);
}

export function scenario_25_vus(data) {
    performRequest(data.token);
}

export function scenario_50_vus(data) {
    performRequest(data.token);
}

export function scenario_75_vus(data) {
    performRequest(data.token);
}

export function scenario_100_vus(data) {
    performRequest(data.token);
}

export function scenario_200_vus(data) {
    performRequest(data.token);
}

export function scenario_1_request_per_minute_in_5_min(data) {
    performRequest(data.token);
}
export function scenario_1_request_per_minute_in_10_min(data) {
    performRequest(data.token);
}

// Comment this section when using Grafana Cloud as report output
// Start of section
// export function handleSummary(data) {
//     const date = new Date();
//     const dateString = date.toISOString().split('T')[0]; // YYYY-MM-DD
//     const timeString = date.toTimeString().split(' ')[0].replace(/:/g, '-'); // HH-MM-SS
//     const filename = `summary_${scenario}_${dateString}_${timeString}.html`;
    
//     let summary = htmlReport(data);
//     summary = summary.replace('<body>', `<body><h1>Scenario: ${scenario} ${dateString} ${timeString}</h1>`);
    
//     return {
//         [filename]: summary,
//     };
// }
// End of section
