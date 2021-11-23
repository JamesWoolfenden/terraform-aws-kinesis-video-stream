# terraform-aws-kinesis-stream

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-kinesis-stream.svg)](https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-aws-kinesis-stream.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.14.0-blue.svg)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/JamesWoolfenden/terraform-aws-kinesis-stream/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-kinesis-stream&benchmark=CIS+AWS+V1.2)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/jameswoolfenden/terraform-aws-kinesis-stream/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-kinesis-stream&benchmark=INFRASTRUCTURE+SECURITY)

This has an example for how to add a custom Checkov check:
Create a folder for your checks:

```cli
$ mkdir checkov
...
```

Add **init**.py

```python
from os.path import dirname, basename, isfile, join
import glob
modules = glob.glob(join(dirname(__file__), "*.py"))
__all__ = [ basename(f)[:-3] for f in modules if isfile(f) and not f.endswith('__init__.py')]
```

And your resource check **checkov\KinesisStreamEncryptionType.py**:

```python
from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck


class KinesisStreamEncryptionType(BaseResourceCheck):
    def __init__(self):
        name = "Ensure Kinesis Stream is securely encrypted"
        id = "CKV_AWS_999"
        supported_resources = ['aws_kinesis_stream']
        categories = [CheckCategories.ENCRYPTION]
        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)

    def scan_resource_conf(self, conf):
        if "encryption_type" in conf.keys():
            if (conf["encryption_type"][0] == "KMS"):
                return CheckResult.PASSED
            else:
                return CheckResult.FAILED
        else:
            return CheckResult.FAILED



check = KinesisStreamEncryptionType()
```

And finally run your new check:

```cli
$ checkov -d . --external-checks-dir checkov/
...
```

## Usage

This is just a very basic example.

![alt text](./diagram/kinesis.png)

Include **module.kinesis.tf** this repository as a module in your existing terraform code:

```terraform
module "kinesis" {
  source      = "JamesWoolfenden/kinesis-stream/aws"
  version     = "v0.1.1"
  common_tags = var.common_tags
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kinesis_stream.flow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_stream) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | This is to help you add tags to your cloud objects | `map(any)` | n/a | yes |
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | n/a | `string` | `"KMS"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | n/a | `string` | `"alias/aws/kinesis"` | no |
| <a name="input_stream"></a> [stream](#input\_stream) | n/a | `map` | <pre>{<br>  "encryption_typ": "KMS",<br>  "name": "terraform-kinesis-test",<br>  "retention_period": 48,<br>  "shard_count": 1,<br>  "shard_level_metrics": [<br>    "IncomingBytes",<br>    "OutgoingBytes"<br>  ]<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Related Projects

Check out these related projects.

- [terraform-aws-s3](https://github.com/jameswoolfenden/terraform-aws-s3) - S3 buckets

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2021 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/in/jameswoolfenden/
[twitter]: https://twitter.com/JimWoolfenden
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-kinesis-stream&url=https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-kinesis-stream&url=https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream
[share_reddit]: https://reddit.com/submit/?url=https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream
[share_email]: mailto:?subject=terraform-aws-kinesis-stream&body=https://github.com/JamesWoolfenden/terraform-aws-kinesis-stream
