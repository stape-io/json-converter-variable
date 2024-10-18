___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "JSON converter",
  "description": "JSON converter, can stringify or parse data.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "RADIO",
    "name": "actionType",
    "displayName": "Action type",
    "radioItems": [
      {
        "value": "stringify",
        "displayValue": "Stringify",
        "help": "Convert data to string"
      },
      {
        "value": "prase",
        "displayValue": "Parse",
        "help": "Parse string to JSON"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "stringify"
  },
  {
    "type": "TEXT",
    "name": "rawData",
    "displayName": "Raw data",
    "simpleValueType": true,
    "help": "Add data to stringify",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

const JSON = require('JSON');
const raw_data = data.rawData || undefined;


if(!raw_data){
  return '';
}
if(data.actionType == 'parse' && typeof raw_data === 'string') {
  return JSON.parse(raw_data);
} else {
  return JSON.stringify(raw_data);
}


___TESTS___

scenarios:
- name: Stringify check
  code: |-
    const mockData = {
      rawData: {price: 69, currency: 'USD'},
      actionType: 'stringify'
    };


    let variableResult = runCode(mockData);


    assertThat(variableResult).isEqualTo('{"price":69,"currency":"USD"}');
- name: Parse check
  code: |-
    const mockData = {
      rawData: '{"price":69,"currency":"USD"}',
      actionType: 'parse'
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo({price: 69, currency: 'USD'});
- name: Wrong data
  code: |-
    // return stringify if try to parse some other type then string
    const mockData = {
      rawData: 123,
      actionType: 'parse'
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo('123');
- name: No data
  code: |-
    // return empty string if no data
    const mockData = {
      rawData: undefined,
      actionType: 'parse'
    };

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo('');


___NOTES___

Created on 10/17/2024, 1:39:23 PM


