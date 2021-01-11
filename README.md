# X Corp AWS VPC Module 

This module builds out a simple VPC which is compliant to the standards of X Corp.


## Usage

```hcl
module "vpc" {
    source = "malekai101/xcorp_aws_vpc"

    project_name = "sample project"
    admin_ip = "1.2.3.4"
}
```
