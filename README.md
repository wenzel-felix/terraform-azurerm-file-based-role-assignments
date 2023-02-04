# file-based-role-assignments

This terraform module allows the user to create Azure role assignments based on json files.
By providing this setup the terraform code itself is highly minimized while also allowing better overview through a fully customizable file structure.

Here are some example structure:

simple:
```bash
.
├── main.tf
├── variables.tf
├── output.tf
└── role_assignments/
    └── all_role_assignments.json
```

subscription-based:
```bash
.
├── main.tf
├── variables.tf
├── output.tf
└── role_assignments/
    ├── subscription1.json
    ├── subscription2.json
    └── subscription3.json
```

complex:
```bash
.
├── main.tf
├── variables.tf
├── output.tf
└── role_assignments/
    ├── product_team1/
    │   ├── subscription1.json
    │   ├── subscription2.json
    │   └── subscription3.json
    ├── product_team2/
    │   ├── subscription1.json
    │   ├── subscription4.json
    │   └── subscription5.json
    └── core_team/
        └── subscription1.json
```

The individual json-files consist of a list of objects like so:

```
    [
        {
            (required parameters)
            "objectId": "173a87bf-b42f-4ea3-b03c-200c8ed46660",
            "roleDefinitionName": "Storage Blob Data Reader",
            "scope": "/subscriptions/a74686c1-f74f-4671-9963-e3316c48afdd",
            (optional parameters)
            "roleAssignmentDescription": "Contributor role assignment for the current user",
            "ConditionVersion": "2.0",
            "Condition": "((!(ActionMatches{'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read'})) OR (@Resource[Microsoft.Storage/storageAccounts/blobServices/containers:name] StringEquals 'blobs-example-container'))"
        },
        {...}
    ]
```