---
permalink: "/2019/aws-devops-pro-certification-policy-standards-automation"
title: "AWS DevOps Pro Certification Blog Post Series: Policy and Standards Automation"
categories:
  - "aws,study,certification"
layout: post.liquid
published_date: "2019-06-05 14:19:02 +0000"
is_draft: false
data:
  tags: "aws,study,certification"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## What does the exam guide say?

To pass this domain, you'll need to know the following:

- Apply concepts required to enforce standards for logging, metrics, monitoring, testing, and security
- Determine how to optimize cost through automation
- Apply concepts required to implement governance strategies

## What services and products covered in this domain?

- [AWS Service Catalog][service_catalog_page]
- [AWS Trusted Advisor][trusted_advisor_page]
- [AWS Systems Manager][ssm_page]
- [AWS Organizations Product Page][orgs_page]
- [AWS Secrets Manager Product Page][secrets_page]
- [AWS Macie Product Page][macie_page]
- [AWS Certificate Manager Product Page][certman_page]

## What about other types of documentation?

If you have the time, by all means, read the User Guides, but they are usually a couple of hundred pages. Alternatively, get familiar with the services using the FAQs:

- AWS Service Catalog [FAQ][service_catalog_faq]
- AWS Trusted Advisor [FAQ][trusted_advisor_faq]
- AWS Systems Manager [Guide][ssm_guide]/[FAQ][ssm_faq]
- AWS Organizations [Guide][orgs_guide]/[FAQ][orgs_faq]
- AWS Secrets Manager [Guide][secrets_guide]/[FAQ][secrets_faq]
- AWS Macie [Guide][macie_guide]/[FAQ][macie_faq]
- AWS Certificate Manager [Guide][certman_guide]/[FAQ][certman_faq]

You're all expected to know the APIs

- [AWS Service Catalog API][service_catalog_api]
- [AWS Trusted Advisor][trusted_advisor_api]
- [AWS Systems Manager API][ssm_api]
- [AWS Organizations API][orgs_api]
- [AWS Secrets Manager API][secrets_api]
- [AWS Macie API][macie_api]

Before you panic, you'll start to spot a pattern with the API verbs.

And the CLI commands

- [AWS Systems Manager CLI][ssm_cli]
- [AWS Organizations CLI][orgs_cli]
- [AWS Secrets Manager CLI][secrets_cli]
- [AWS Macie CLI][macie_cli]

As with the API, there are patterns to the commands.

## 10 per cent

I've decided to keep all of the services around this domain within this intro, you're expected to be aware of the services, their purposes and uses cases rather than have in-depth knowledge around their implementation.

Whilst this domain is only 10 per cent, it probably doesn't hurt to know of these services it might make the difference between a pass and fail grade when you take the exam.

### What?

**AWS Service Catalog**...

- allows you to build a catalogue of products (of AWS resources) that your users can use.
- through the use of the API, you can provision these services through your own front end instead of AWS console
- uses the following terminology
  - Products - are application stacks based around AWS resources created by admins
  - Portfolios - are a collection of products
  - Users - can launch these products without needed access to AWS or the console

**AWS Trusted Advisor** is a service that provides a dashboard to report if AWS resources are not in line with current best practice. The reporting is categorised as follow:

- Cost Optimisation - will report on any low or underutilised resources to save you money
- Performance - will report any aspect of configuration that has an impact on resource performance
- Security -  will report any concerns around security i.e. MFA not enabled on the root account
- Fault Tolerance - will report on any resources that are not fault tolerant
- Service Limits - will report on resources that are close to reaching the service limits 

What reports you to get depend on the support plan you're on.

Basic/Developer - get seven core checks (six from Security and all of the Service Limit reports)
Business/Enterprise - get all the reporting and checks

**AWS Systems Manager** is an infrastructure management service that can perform the following tasks:

- Inventory - allows you to collect information about your instances and the software installed on them.
- Configuration compliance - scans your instance for patch compliance and configuration inconsistencies
- Automation - automates daily or repetitive tasks or reports
- Run Command - allows you to perform commands against a single or group of resources
- Session Manager simplifies connections to resources without needing to open inbound ports, setup bastion servers or manage SSH keys
- Patch Manager - allows you to deploy patches and updates to your instances either immediately or via a maintenance window
- Maintenance Windows - allows you to schedule pre-arranged outages
- Distributor is a software package distribution mechanism
- State manager to store policies that can be reapplied to resources when there is a drift in configuration
- Parameter Store (secrets and configuration data)

**AWS Organizations** allows you to organise your environment based on your own hierarchy or functional roles (security, compliance, operations, developer and finance).

**AWS Secrets Manager** encrypts secrets at rest using keys in KMS. Secrets can be database credentials, passwords and 3rd party API keys. You can store and control access through Console service, CLI, API and SDK.

Secrets can be rotated automatically via a schedule

Secret types you can store are:

- Credentials for RDS databases
- Credentials for other databases
- Other types of secrets (API keys, passwords, etc)

**Amazon Macie** uses machine learning to automatically identify, classify and protect sensitive data in AWS. It recognises personally identifiable information (PII) or intellectual property. It currently protects S3, but data store related services are being planned for the future.

**AWS Certificate Manager** centralised managed certificates in AWS. It has good integration with AWS services allowing it to provision TLS/SSL certificates on their behalf. You can also use it to set up a private certificate authority which can be internally within an organisation when there's no need to use trusted Internet Root CAs.

### Why?

**AWS Service Catalog** allows you to hide the specific implementation of your cloud infrastructure. By giving your users a separate front end, you can remove a direct association to an AWS account.

**AWS Trusted Advisor** is an automated tool to gather information about your AWS environment and report against those not configured as per best practice. It's also a cost-saving tool, making recommendations to remove unused resources or downgrade them. A full list of checks can be found on the [AWS Support][trusted_advisor_checks] page.

**AWS Systems Manager** is a tool to centralised various tasks and activities you may wish to perform against your infrastructure. The CloudWatch Dashboards and Trusted Advisor reports are also integrated to make this a one-stop shop for systems management.

**AWS Organizations** allows you to map access to AWS resources based on your own business functions. The most simple example is to only allow developers access to the development environment and maybe read-only access to production.

**Amazon Macie** uses machine learning to identify personally

### When?

**AWS Service Catalog** should be used when you want your users to have a specific set of products based around AWS services, but don't want to give them access to the AWS Console or a specific IAM account.

**AWS Trusted Advisor** should be used when you need to find out if you're following best practice.

**AWS Systems Manager** is an enterprise tool, allow you to identify resources by attribute (AMI image id, OS type, instance type) rather than navigate to specific resources.

*AWS Organizations* when you need to map your business functions against AWS resources and IAM users, groups and roles are not sufficient enough controls.

**Amazon Macie** should be used by organisations that require careful handling of customer data i.e. health care or government. Where the volumes of data are not easily managed by a data administration team or monitored by security/compliance business function.

**AWS Secrets Managers** when you don't want to hard code secrets or store sensitive data on servers or have a regulatory requirement cycle secrets on a regular basis.

**AWS Certificate Manager** when you need to provision SSL/TLS certificates or need to a private certificate authority.

### How?

If there are no specific instructions, it's assumed the service is available through the AWS Console.

**AWS Service Catalog** requires development so the [Developer Guide][service_catalog_api] should be consulted.

**AWS Trusted Advisor** is available through the AWS Console. In addition to the dashboard, you can send out weekly reports to receipts based on role: billing, operations and security.

**AWS Systems Manager** is available through the AWS Console, you can create groups to manage by searching for resources based on tags (resource type, operating system, etc). It will require an agent to be installed on the resource (as well as an IAM instance profile) to become a managed instance.

[service_catalog_page]: https://aws.amazon.com/servicecatalog/
[service_catalog_faq]: https://aws.amazon.com/servicecatalog/faqs/?nc=sn&loc=6
[service_catalog_api]: https://docs.aws.amazon.com/servicecatalog/latest/dg/API_Reference.html
[trusted_advisor_page]: https://aws.amazon.com/premiumsupport/technology/trusted-advisor/
[trusted_advisor_faq]: https://aws.amazon.com/premiumsupport/technology/trusted-advisor/faqs/
[trusted_advisor_api]:https://docs.aws.amazon.com/awssupport/latest/user/trustedadvisor.html?nc2=type_a
[trusted_advisor_checks]: https://aws.amazon.com/premiumsupport/technology/trusted-advisor/best-practice-checklist/
[ssm_page]: https://aws.amazon.com/systems-manager/
[ssm_guide]: https://docs.aws.amazon.com/systems-manager/latest/userguide/what-is-systems-manager.html
[ssm_faq]: https://aws.amazon.com/systems-manager/faq/
[ssm_api]: https://docs.aws.amazon.com/systems-manager/latest/APIReference/Welcome.html
[ssm_cli]: https://docs.aws.amazon.com/cli/latest/reference/ssm/index.html
[orgs_page]: https://aws.amazon.com/organizations/
[orgs_faq]: https://aws.amazon.com/organizations/faqs/
[orgs_guide]: https://docs.aws.amazon.com/organizations/latest/userguide/orgs_introduction.html
[orgs_api]: https://docs.aws.amazon.com/organizations/latest/APIReference/Welcome.html
[orgs_cli]: https://docs.aws.amazon.com/cli/latest/reference/organizations/index.html
[secrets_page]: https://aws.amazon.com/secrets-manager/
[secrets_guide]: https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html
[secrets_faq]: https://aws.amazon.com/secrets-manager/faqs/
[secrets_api]: https://docs.aws.amazon.com/secretsmanager/latest/apireference/Welcome.html
[secrets_cli]: https://docs.aws.amazon.com/cli/latest/reference/secretsmanager/index.html#cli-aws-secretsmanager
[macie_page]: https://aws.amazon.com/macie/
[macie_guide]: https://docs.aws.amazon.com/macie/latest/userguide/what-is-macie.html
[macie_faq]: https://aws.amazon.com/macie/faq/
[macie_api]: https://docs.aws.amazon.com/macie/1.0/APIReference/Welcome.html
[macie_cli]: https://docs.aws.amazon.com/cli/latest/reference/macie/index.html
[certman_page]: https://aws.amazon.com/certificate-manager/
[certman_guide]: https://aws.amazon.com/certificate-manager/getting-started/
[certman_faq]: https://aws.amazon.com/certificate-manager/faqs/

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging/)
- Domain 4: Policies and Standards Automation
  - AWS Service Catalog
  - AWS Trusted Advisor
  - AWS Systems Manager
  - AWS Organizations
  - AWS Secrets Manager
  - Amazon Macie
  - AWS Certificate Manager
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
