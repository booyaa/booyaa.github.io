---
permalink: "/2019/aws-devops-pro-certification-sso-cloudfront-autoscaling-route53"
title: "AWS DevOps Pro Certification Blog Post Series: Amazon Single Signon, CloudFront, Autoscaling and Route53"
categories:
  - "aws,route53,sso,cloudfront"
layout: post.liquid
published_date: "2019-06-12 13:37:00 +0000"
is_draft: false
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

**Amazon CloudFront** is a managed Content Delivery Network (CDN) service, you may have heard of CloudFront's competitors like CloudFlare, Akamai and Fastly. CDN speed up your website performance by strategically placing mirrors of popular content (static files, API or streaming audio/video) at locations nearer to the user accessing your website. These mirrors are referred to as Edge locations popular content for the region (not specific to client) is cached here. In more densely populated areas there are also Regional Caches that hold content for longer than Edge locations.

**Amazon Route53** is a managed [Domain Name Service][wiki_dns] (DNS). At its very basic level of functionality DNS servers allow you to connect to servers using friendly domain names i.e. dev.to rather than IP addresses like 151.101.123.4, 151.101.12.34, 151.101.1.234. It's designed to work with other Amazon Web Services that is you can point DNS records directly to Elastic Load Balancer, S3 and EC2 instances.

**Autoscaling** as we saw in the Domain intro comes in two varieties: [AWS Auto Scaling][autoscaling_page] and [Amazon EC2 Auto Scaling][asg_page]. The general rule of thumb for use if you want to just autoscale EC2 instances then use EC2 Auto Scaling service, otherwise, AWS Auto Scaling is a better use case for when you want to scale multiple resources (not just EC2) i.e. DynamoDB tables and indexes, ECS tasks.

An important thing to note that to use AWS Auto Scaling, your resource must be created using CloudFormation or Elastic Beanstalk.

For the rest of this post, we'll only be referring to Amazon EC2 Auto Scaling.

## Why?

**Amazon Single Sign-On** or generically any single sign-on (SSO) service is better than managing the administrative overhead of keeping separate logins for each application / service, you reduce the impact on day to day operations should disaster strike (think the number of helpdesk tickets will be raised for DR systems that rarely get used). You'll also get the undying love of your users because it means fewer logins to track, which in turn means they will be less likely to keep a scrap paper lying around their desk with the various logins and passwords written down.

**Amazon CloudFront** distributes your content geographically rather than storing in a single location or S3 bucket. By careful design (falling back graceful should the backend be unavailable) ensures your website is highly available.

**Amazon Route 53** provides the following [routing policies][route53_routing_policies] whose attributes are suitable for this domain:

- Failover routing - used for active-passive failover, a good use case for automated disaster recovery.
- Geolocation routing - used to route traffic based on the location of users, a good use case for highly available
- Geoproximity routing - similar to Geolocation routing, but also allows you to route to a secondary location. This also makes a good use case for fault tolerance.
- Latency-based routing - used to route users to the resources with the best (least) latency
- Multivalue answer routing - this is similar to round robin, in that you can randomly pick a route from up to eight healthy resources
- Weighted routing - routes traffic to different resources using a percentage split (useful for A/B testing or load balancing). Weights are between 0 to 255.

**Amazon EC2 Auto Scaling** allows you to launch or terminate a number of EC2 instances by defining conditions when scaling out (increase) or scaling in (decreasing) the number of instances. The condition might be metrics like CPU or Memory utilisation, or health checks. This combined with an elastic load balancer provides a system that can be highly available and fault tolerant.

Terminology to be aware of:

- [Auto Scaling Group][asg_what] (ASG) - this is a group of EC2 instances associated with one or more scale in/out conditions.
  - Minimum size - that the ASG never goes below
  - Maximum Size - that the ASG never goes above
  - Desired capacity - that the ASG will already try to maintain (unless the condition requires further scaling-in).
  - Scaling capacity is between desired capacity and Maximum Size


## When?

**Amazon Single Sign-On** should ideally be implemented as soon as possible, but it's still possible to retrofit into an existing environment. Doing this soon rather than later could mean you're not having to re-organise the team who are responsible for user and access management if the headcount reduces because of efficiency savings through the implementation of SSO.

**Amazon CloudFront** should be implemented once you have some metrics (via Amazon X-Ray or something similar) to indicate you have customers in regions that are experiencing poor response times because of their proximity in relation to the region where your load balancers, EC2 instances or S3 buckets are hosted.

**Amazon Route 53**'s routing policy provides a lot of desirable features that are relevant for this domain. This combined with the fact that Amazon also offers an [SLA] of 100% availability and the ability to create and modify DNS record programmatically mean the use of Route 53 is a bit of a no-brainer.

**Amazon EC2 Auto Scaling** has the concept of [lifecycle hooks][asg_lifecycle_hooks]. These allow you to perform custom actions by pausing the instances as the ASG launches (`EC2_INSTANCE_LAUNCHING`) or terminates  (`EC2_INSTANCE_TERMINATING`) them. Whilst the instance is paused, it is in a wait state until you complete the action by issuing the `complete-lifecycle-action` action in the CLI/API or the timeout period ends (one hour by default). You can extend the timeout period by either:

- set a longer heartbeat timeout period using the `put-lifecycle-hook` action (CLI/API) when you create the lifecycle hook
- restart the timeout period using `record-lifecycle-action-heartbeat` action (CLI/API)

The maximum time you can place an instance in a wait state is 48 hours or 100 times the heartbeat timeout (whichever is smaller).

## How?

**Amazon Single Sign-On** requires an AWS Organization to exist and then you can enable single sign-on via the AWS Console. The specifics for setting up the service with the AWS Account or Cloud Applications (3rd party services) can be found in the [guide][sso_guide]. There is an option to link to your existing Microsoft Active Directory, but if you don't need this option then the service will use its own directory.

**Amazon CloudFront** to setup you define a distribution that determines the content origins (S3 bucket or HTTP server), access, security (TLS/SSL/HTTPS), session/object tracking, geo restrictions and logging. The provisioning of CloudFront can take a while as the content is being distributed to edge locations.

I've found the following article in the AWS blog very helpful in terms of an application that I was already familiar with, but also knew the difficulty in optimising for response time: [How to accelerate your WordPress site with Amazon CloudFront][aws_wp_on_cloudfront]

**Amazon EC2 Auto Scaling** terminology:

- Auto-scaling group - this is a collection of EC2 instances that will be scaled in or out depending on conditions defined
  - There's a minimum size
  - Desired capacity
  - Max capacity
- Autoscaling lifecycle
  - starts when an ASG launches an instance
  - ends, when you terminate an instance or ASG, takes an instance out of service and terminates it
- [Cooldowns][asg_cooldowns] prevents the ASG from launching or terminating more instances before the previous scaling activity event has taken effect. The default period is 300 seconds (5 minutes)

## API and CLI features and verbs

### Amazon Single Sign-On

This service has no API/CLI.

### Amazon CloudFront

#### Features

- (Streaming) Distributions (this is probably the most important one to be aware of) with or without tags
- Field Level Encryption (Config/Profile)
- Invalidation (cache)
- (CloudFront) Origin Access Identity
- Public key

#### Verbs (CRUD)

- create (distrbution/streaming-with-tags)
- get/list
- update (except invalidation)
- delete (except invalidation)

#### Outliers

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

### Amazon Route 53

I've opted for the main API/CLI for [Route 53][route53_cli1] instead of [Domains][route53_cli2] and [Resolvers][route53_cli3] as I've been using this more on a day to day basis.

#### Features

- Health Check
- Hosted Zone
- Reusable Delegation Set
- Traffic Policy (Instance/Version)
- Create Query Logging Config

#### Verbs (CRUD)

- create
- get/list
- update
- delete

#### Outliers

- CreateVPCAssociationAuthorization
- AssociateVPCWithHostedZone
- DeleteVPCAssociationAuthorization
- ChangeResourceRecordSets
- ChangeTagsForResource
- DisassociateVPCFromHostedZone
- GetAccountLimit
- GetChange
- GetCheckerIpRanges
- GetGeoLocation
- ListGeoLocations
- TestDNSAnswer

### EC2 Auto Scaling

#### Features

The [API][asg_api] has a lot of features, but the API actions I've focussed on have been around the Lifecycle Hooks.

#### Verbs (CRUD)

- describe (types)
- put
- delete

#### Outliers

- CompleteLifecycleAction
- RecordLifecycleActionHeartbeat

[aws_free_tier]: https://aws.amazon.com/free/

[aws_wp_on_cloudfront]: https://aws.amazon.com/blogs/networking-and-content-delivery/how-to-accelerate-your-wordpress-site-with-amazon-cloudfront/

[route53_sla]: https://aws.amazon.com/route53/sla/
[route53_routing_policies]: https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html
[route53_cli1]: https://docs.aws.amazon.com/cli/latest/reference/route53/index.html
[route53_cli2]: https://docs.aws.amazon.com/cli/latest/reference/servicediscovery/index.html
[route53_cli3]: https://docs.aws.amazon.com/cli/latest/reference/route53domains/index.html

[autoscaling_page]: https://aws.amazon.com/autoscaling/
[asg_page]: https://aws.amazon.com/ec2/autoscaling/
[asg_what]: https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html
[asg_lifecycle_hooks]: https://docs.aws.amazon.com/autoscaling/ec2/userguide/lifecycle-hooks.html
[asg_cooldowns]: https://docs.aws.amazon.com/autoscaling/ec2/userguide/Cooldown.html
[asg_api]: https://docs.aws.amazon.com/AWSEC2/latest/APIReference/index.html

[wiki_dns]: https://en.wikipedia.org/wiki/Dns

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging/)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
  - Amazon Single-Sign On
  - Amazon CloudFront
  - Auto Scaling
  - Amazon Route53
  - [Databases](/2019/aws-devops-pro-certification-databases/)
    - [Amazon RDS](/2019/aws-devops-pro-certification-databases/)
    - [Amazon Aurora](/2019/aws-devops-pro-certification-databases/)
    - [Amazon DynamoDB](/2019/aws-devops-pro-certification-databases/)
