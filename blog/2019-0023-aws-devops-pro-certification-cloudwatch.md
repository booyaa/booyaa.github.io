---
permalink: "/2019/aws-devops-pro-certification-cloudwatch"
title: "AWS DevOps Pro Certification Blog Post Series: CloudWatch"
categories:
  - "aws,study,certification,cloudwatch"
layout: post.liquid
published_date: "2019-06-05 10:04:00 +0000"
is_draft: false
data:
  tags: "aws,study,certification,cloudwatch"
  route: blog
---

_This is part of the blog post series: [AWS DevOps Pro Certification](/2019/aws-devops-pro-certification-intro/)_

## Caveat emptor

Using AWS costs money, some of these services may not be part of the AWS [Free Tier][aws_free_tier]. You can keep costs down by tearing down anything you've created whilst learning, but it's still possible to run up a hefty bill so pay attention to the instances you setup!

I'm very lucky to be able to use my employer's AWS account. You should ask your place of work if a similar arrangement can be made as part of your study.

## Velocius quam asparagi conquantur

The format of the blog posts is liable to change as I try to refine my mental model of each domain, so be sure to revisit the blog posts on a regular basis.

## What?

CloudWatch...

- is a service that allows you to collect, track and analyse metrics AWS resources and applications.
- consists of:
  - Dashboards - this is a customisable web page that can display graphs, metrics, text and query results. DevOps engineers would use a dashboard to provide an at a glance view of the system/environment's health.
  - Metrics allow you to visualise your metrics and create alarms.
    - The following services (in scope for the exam) publish metrics to CloudWatch. A full list can be found in the [User Guide][docs_ug_metric_publishers].
      - Amazon CloudFront
      - CloudWatch Events and Logs
      - AWS CodeBuild
      - AWS EC2 / Auto Scaling
      - AWS ECS
      - AWS / EFS
      - ELB
      - AWS Kinesis
      - AWS Lambda / Step Functions
      - AWS OpsWorks
    - You can publish custom metrics from EC2 instances via the AWS CLI/API or applications by using the AWS SDK.
  - Alarms are generated off values from your metrics or a maths expression based around that value.
    - Common use cases for alarms are:
      - CPU/Memory utilisation
      - Load Balancer Latency
      - Storage Throughput
      - Billing (exceeding a spending threshold)
    - Alarms can even be used to stop, terminate, reboot or recover an instance
      - There are three states for an Alarm:
        - OK - The metric or expression is within a defined threshold
        - ALARM - The metric or expression is outside the defined threshold
        - INSUFFICIENT DATA - The alarm has just started, but the metric is not available or there is not enough data for the metric to define its alarm state
      - Alarms only invoke actions for sustained state changes. So you won't keep generating alarms because you're in a state ALARM.
  - Logs are aggregated by Log Groups, to drill down to the actual logs you need to pick a log stream.
    - Insights allow you to run SQL like queries over your log data. An example query might be to view the most expensive request for your Lambda function.
  - Events are a near real-time stream of system events around changes to your AWS resources
    - Rules match incoming events and route them to the target
    - Targets something that will process the events (SNS topic, Lambda)
  
Metric retention periods

- High res (<60 seconds) is 3 hours. High resolution has to be activated and incurs an additional charge.
- Data points of 60 secs (1 min) is 15 days
- Data points of 300 secs (5 mins) is for 63 days
- Data points of 3600 seconds (1 hour) is for 455 (15 months)

Additional resources:

- [CloudWatch Product Page][aws_cloudwatch]
- [CloudWatch FAQ][docs_faq]
- [CloudWatch User Guide][docs_ug]
- [CloudWatch API][docs_api]
- [CloudWatch CLI][docs_cli]

## Why?

CloudWatch enables you to aggregate your logging and metrics into a centralised location. You can then perform analysis or visualise the data. Furthermore, you can use Alarms and Events to notify your team or perform automatic reactive action.

## When?

You should use the CloudWatch Agent to gather metrics and logs from your EC2 instances or on-premises servers (Linux or Windows based).

You should use the AWS CLI if you only need to publish custom metrics from your EC2 instance or on-premises servers.

## How?

TODO: Unfortunately I've found these sections have been eating up a lot of my study time. I will try and revisit this during my revision stage.

Here's what I had planned for this section:

- How to install the CloudWatch Agent log to capture logs from an EC2 instance, this would be based around [this][docs_ug_cw_agent] guide.
- How to publish a custom metric and generate an alarm using the AWS CLI, this would be based around [this][docs_ug_custom_metrics] guide.

## API and CLI features and verbs

I'd hazard the guess the one API/CLI call you need to be familiar with is `put-metric-data` [CLI][docs_cli_put_metric_data][API][docs_api_put_metric_data] because it's got an immediate and practical use and isn't possible through the AWS Console.

**Features**

- Alarms
- Dashboards
- Metrics

**Verbs (CRUD)**

- ??? oddly creation verbs are via Puts
- describe (alarms)/get (dashboard/metric-data)/list (dashboard/metrics)
- put (dashboard/metric-[alarm/data])
- delete (alarms/dashboards)

**Outliers**

- describe-alarm-history
- describe-alarms-for-metric
- disable-alarm-actions
- enable-alarm-actions
- get-metric-statistics
- get-metric-widget-image
- list-tags-for-resource
- set-alarm-state
- tag-resource
- untag-resource
- wait

[aws_free_tier]: https://aws.amazon.com/free/
[docs_ug_metric_publishers]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/aws-services-cloudwatch-metrics.html
[aws_cloudwatch]: https://aws.amazon.com/cloudwatch/
[docs_faq]: https://aws.amazon.com/cloudwatch/faqs/
[docs_ug]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/index.html
[docs_ug_custom_metrics]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/PublishMetrics.html
[docs_ug_cw_agent]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Install-CloudWatch-Agent.html
[docs_api]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/index.html
[docs_api_put_metric_data]: https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_PutMetricData.html
[docs_cli]: https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/index.html
[docs_cli_put_metric_data]: https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/put-metric-data.html

## AWS DevOps Pro Certification Blog Post Series

- [Intro](/2019/aws-devops-pro-certification-intro/)
- Domain 1: [SDLC automation](/2019/aws-devops-pro-certification-sdlc-intro/)
- Domain 2: [Configuration Management and Infrastructure as Code](/2019/aws-devops-pro-certification-configuration-management-and-infrastructure-as-code-intro/)
- Domain 3: [Monitoring and Logging](/2019/aws-devops-pro-certification-monitoring-and-logging/)
  - CloudWatch
  - [AWS X-Ray](/2019/aws-devops-pro-certification-xray/)
- Domain 4: [Policies and Standards Automation](/2019/aws-devops-pro-certification-policy-standards-automation/)
- Domain 5: [Incident and Event Response](/2019/aws-devops-pro-certification-incident-and-event-response/)
- Domain 6: [High Availability, Fault Tolerance, and Disaster Recovery](/2019/aws-devops-pro-certification-high-availability-fault-tolerance-disaster-recover/)
