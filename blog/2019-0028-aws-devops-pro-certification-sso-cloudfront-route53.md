---
permalink: "/2019/aws-devops-pro-certification-sso-cloudfront-autoscaling-route53"
title: "AWS DevOps Pro Certification Blog Post Series: Amazon Single Signon, CloudFront, Autoscaling and Route53"
categories:
  - "aws,route53,sso,cloudfront"
layout: post.liquid
published_date: "2019-06-14 13:37:00 +0000"
is_draft: true
data:
  tags: "aws,route53,sso,cloudfront"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

**Amazon Single Sign-On** is a managed single sign-on (SSO) service that you can use to simplify access to applications and 3rd party services. If SSO is not a term you're familiar with, if you've ever signed up for a service using your Google, Facebook or Twitter account (instead of using your email address and password specific to that site) then you've used SSO.

**Amazon CloudFront** is a managed Content Delivery Network (CDN) service, you may have heard of CloudFront's competitors like CloudFlare, Akamai and Fastly. CDN speed up your website performance by strategically placing mirrors of popular content (static files, API or streaming audio/video) at locations nearer to user accessing your website. These mirrors are referred to as Edge locations popular content for the region (not specific to client) is cached here. In more densely populated areas there are also Regional Caches that hold content for longer than Edge locations.

**Autoscaling** as we saw in the Domain intro comes in two varieties ...

**Amazon Route53** is ...

Additional resources:

- [? Product Page][aws_product_page]
- [? FAQ][docs_faq]
- [? User Guide][docs_ug]
- [? API][docs_api]
- [? CLI][docs_cli]

## Why?

**Amazon Single Sign-On** or generically any signle sign-on (SSO) service is better than managing the administrative overhead of keeping separate logins for each application / service, you reduce the impact on day to day operations should disaster strike (think the number of helpdesk tickets will be raised for DR systems that rarely get use). You'll also get the undying love of your users because it means less logins into track, which in turn means they will be less likely to keep a scrape paper lying around their desk with the various logins and passwords written down.

**Amazon CloudFront** distributes your content geographically rather than storing in a single location or S3 bucket. By careful design (falling back graceful should the backend be unavailable) ensures your website is highly available.

## When?

**Amazon Single Sign-On** should ideally be implemented as soon as possible, but it's still possible to retrofit into an existing environment. Doing this soon rather than later, could mean you're not having to re-organise the team who are responsible for user and access management if the head count reduces because of efficiency saving through the implementation of SSO.

**Amazon CloudFront** should be implemented once you have some metrics (via Amazon X-Ray or something similar) to indicate you have customers in regions that are experiencing poor response times because of their proximity in relaton to the region where your load balancers, EC2 instances or S3 buckets are hosted.

## How?

**Amazon Single Sign-On** requires an AWS Organization to exist and then you can enable single sign-on via the AWS Console. The specifics for setting up the service with the AWS Account or Cloud Applications (3rd party services) can be found in the [guide][sso_guide]. There is an option to link to your existing Microsoft Active Directory, but if you don't need this option then the service will use it's own directory.

****Amazon CloudFront** to setup you define a distribution that determines the content origins (S3 bucket or HTTP server), access, security (TLS/SSL/HTTPS), session/object tracking, geo restrictions and logging. The provisioning of CloudFront can take awhile as the content is being distributed to edge locations.

I've found the following article in the AWS blog very helpful in terms of an application that I was already familiar with, butalso knew the difficulty in optimising for response time: [How to accelerate your WordPress site with Amazon CloudFront][link_aws_wp_on_cloudfront]

[link_aws_wp_on_cloudfront]: https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-accelerate-your-wordpress-site-with-amazon-cloudfront/

## API and CLI features and verbs

### Amazon Single Sign-On

has no API/CLI.

### Amazon CloudFront

**Features**

- (Streaming) Distributions (this is probably the most important one to be aware of) with or without tags
- Field Level Encryption (Config/Profile)
- Invalidation (cache)
- (CloudFront) Origin Access Identity
- Public key

**Verbs (CRUD)**

- create (distrbution/streaming-with-tags)
- get/list
- update (except invalidation)
- delete (except invalidation)

**Outliers**

- get-field-level-encryption-profile-config
- get-distribution-config
- get-public-key-config
- get-cloud-front-origin-access-identity-config
- get-streaming-distribution-config
- list-distributions-by-web-acl-id
- list-tags-for-resource
- sign
- tag-resource
- untag-resource
- wait

[aws_free_tier]: https://aws.amazon.com/free/
[aws_product_page]: https://aws.amazon.com/cloudwatch/
[docs_faq]: https://aws.amazon.com/cloudwatch/faqs/
[docs_ug]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/index.html
[docs_api]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/index.html
[docs_cli]: https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/index.html

**AWS DevOps Pro Certification Blog Post Series**

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SLDC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging/)
- Domain 4: Policies and Standards Automation
- Domain 5: Incident and Event Response
- Domain 6: High Availability, Fault Tolerance, and Disaster Recovery