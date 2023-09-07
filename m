Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D4EB8FD7
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Sep 2023 11:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1694087196;
	bh=ZP4nwTq0wkUKj+2KXuEBYw+u8e+GqF5bXS4J0FZrgjY=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=quR0gQbkN524c+WS18cqJmX+ePApfjqjlG5E4qpkbBFZ2YL+AiWoJ3ltYZeAOkGSF
	 wnuBJyOjJAm/SCDrSj2Af2D1rAmUOe3LWcFjRiW5nN9qRBf8g3yByTObeXPMWDF2nM
	 9FfSl6UWqwEls44kawLGMEevRF4Y3nGY5PZ5WVgM9NmkNSJgKEc7XGNc5cUqlpiP2s
	 KIlziRDqa13Uoyj91z+a7DHCKQUZP/SGqZanAkcpkOiWlr8pH1RlUP6+3Zr9NJkvpB
	 ENrN/4OpIu+7krc5bmhvJH/CJSX1E6lI2IHtaeY0fFAiZvD20BDwuxXlz0eWZbeRb+
	 JsbOd2EOSHe7g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RhHWv5Tyzz2WCD;
	Thu,  7 Sep 2023 07:46:35 -0400 (EDT)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by lists.lttng.org (Postfix) with ESMTPS id 4RhHWt2k28z2WCC
 for <lttng-dev@lists.lttng.org>; Thu,  7 Sep 2023 07:46:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpfEirrGaxSIlStgsZ+cPeDtI9uaywQPH8vFDrry4ytGQuqr7jRKOHFuzhuq5hx7nCA6yR6qYgikXaNq3j8jvVKwCR9KZirQl83e5/7Dht3bNQg86w3Oh/rTFW92Ql9ekKnUg7YU0iiHYbMtoTdP60ytw7hV5U7PTd9QPQmjpPZ3MtuZBEoAtA0ADmUZJg5Ol4g8Dj7TpoF1ntQl5y5TQV564Nwlfz6KP1KaKDkJh2x5fzLkZdKAyQPKv2PRNUpwR8ZRghJd66SF8uq2v/8svPsWqpF2ND1me3wG1fMI9RLhC209GqNOk3cDdlKCs+WgSCrjBZ6tJ6UDv8XqtDcmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiIReSgcpG49CqFsD8QIBxh8HeNni+FiWKswBfkQ6JY=;
 b=dmCAZ0mehyuTJBSjgim2mIGKMWquAZEUlAC7pOq+fOuFnV53ClLF4Iy933VBdI/avbRsnv1q9E/PsFmsBSAByIGJoMgFztZrM1dualvziZgYPMkci+f3jFh+WkgsLM7dGwlkGmU9y0o4KE5+Egui6pFPt9wfQ9IRTvDYBPpF0jXdBODt2/Ix4d6JLcoocHbRjn+pUmAEap4niyxf6DUDDt48gTnen+8QNlKBHGnlGt2xPwsWTvc81oWx27BVUap26Q5x2OTS3Dn1APZ+YE9GTyNNNY01w43JqkvSRcO2VdRkB7b2ut0ckbyfFWuAfxASJ2jWGABzbSrYoDRCKtqU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 11:46:31 +0000
Received: from MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::5acf:b492:72c8:6e99]) by MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::5acf:b492:72c8:6e99%4]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 11:46:30 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] LTTNG LIB UST Crash
Thread-Index: AQHZ38CUibDWq+jpPkCnQS40t4VDBrAMYgOAgAEwByWAAFzyAIABT9mS
Date: Thu, 7 Sep 2023 11:46:30 +0000
Message-ID: <MW3PR12MB455584B7DCA5C2A85BABE9D9D9EEA@MW3PR12MB4555.namprd12.prod.outlook.com>
References: <MW3PR12MB4555EFAAF7F86C5EFA8DB849D9E8A@MW3PR12MB4555.namprd12.prod.outlook.com>
 <b16699e8-92de-2088-2912-e956443f4a3e@efficios.com>
 <MW3PR12MB45557CD01005A03C4A5E84F2D9EFA@MW3PR12MB4555.namprd12.prod.outlook.com>
 <785fc568-684d-2123-c5a8-0d631100cdc9@efficios.com>
In-Reply-To: <785fc568-684d-2123-c5a8-0d631100cdc9@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4555:EE_|SA0PR12MB4461:EE_
x-ms-office365-filtering-correlation-id: 3ff4fae4-641e-4ec4-aed9-08dbaf9813d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uIzQVOu6QYI0s8c0zXcCtqv785i5AcRvon6Eh4oOdBPLrOCePxZOaC8tqBRRYqX4dFxjKrqN/jfylnn/rGld7/fYFcnZKcR8mLwsXStD735vkLyvSy4mfpcK1wZA+9eXIXIcsVof98zV+snPdovW850r+dnm8XemnFXQoEoeDL7hk75oHW7FfACZuVJSB/fxrhDCDdIutXl+n3o8GSI9zrq9vzGqTfbiqkRGXLsza8wIp6xbVlqc86KGCuqRwOzRWcHtiSMYdwQ1PZw78y5rbAfphU7LXHGGRpGAbDyr5E4JdjFDzSH7jtkWX7ZtUtUsfIlNyDgi6KbQ2l8jaXpAa57Folh4kIWKMShlHU4As/EL10Y841g2TQGn7V4mcRJqkJHkWbY+ImX84WHy4VlOtqDJMmKF6VTOeBaCt7JFKTbEGeExA9sUOSRXy+hcRRUnrCS4XmRQDmpRJEfXRXs49hqXV9dqeZ9Fw7uY8w5IdiBAkGjmifyGiFs2Hp3SLlNF3JfHeC0nGbEpemYK7qUi9awWI3ME1tZsvTk1cqLmtEmerKvKG+UMAjJK5xc7Pp2Sc0KcqEBmFfs8+hejhvJA1nzeY4kWqguDdcB0GE44TFo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199024)(1800799009)(186009)(19627405001)(66476007)(64756008)(6916009)(316002)(66446008)(122000001)(33656002)(71200400001)(86362001)(91956017)(66946007)(76116006)(66556008)(2906002)(8676002)(41300700001)(52536014)(8936002)(30864003)(5660300002)(55016003)(38100700002)(38070700005)(66899024)(478600001)(966005)(53546011)(166002)(9686003)(26005)(6506007)(45080400002)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ctcuAfu9IGkNQ7l5cmC57zGMdlTAIXWEdRrR6twGMO2HYpmaSfhZzd1y6eSZ?=
 =?us-ascii?Q?n8qa+ibufbOdSRQwZFQPMPaO+GFwzoWx9s0Yx08y7w/F+LmOg7ey3qXJ5VGv?=
 =?us-ascii?Q?mMWOvYIESTDuQr/io0ZCHuM/cFyXXLhxft4WnIgndFa+UHAGH1VNtNxAbefp?=
 =?us-ascii?Q?r6JLA9cOvgF7qIO8NlIPxrhdPMHelcI7MjoXngYqe9KzNzA4sCraIDlsnkIV?=
 =?us-ascii?Q?jCufDuLMpiRUMnbno5A4GF5NMSoFa8levh8X1ZpcaHJnXQHjBURpGtsp251K?=
 =?us-ascii?Q?A9jL6oQXNn8PJ4Dl0XXNTIEEEVSeeLe8kskPoIoMdYBgH6iS6NcTSHuW7Ot4?=
 =?us-ascii?Q?aHIJou9anM0n/3wmAzyKUbEYES38Ql2YKrlY5oE5CyFhheYAUqKVUivayDuk?=
 =?us-ascii?Q?JDd6JB0pHipXe3Hvag0wvxA64FpLNEe5R6pEAGtn/LvRBOtG9xlWK3qXkZ3Z?=
 =?us-ascii?Q?vvwHHsNP/CLzasqKZ7+OJbFCpV7dLN2Pkq6OeGQQurY+nRtQygsNIvv6Dgg1?=
 =?us-ascii?Q?og9ANt4+o/IUqGNr97S/P9//FCzZdf25M9hUT0LJbLfhEBPO4xx5tz9MtN3k?=
 =?us-ascii?Q?77GuQTLZRGnYNFZ2DMbTBvmJdX6smhUPU1OrK80EpXkuDsDoHoWO0g8BasST?=
 =?us-ascii?Q?HQAV7VvVFdjasU6ZLjF8F2SDyHYP1SrWSv6TTHrsPhYIYv3Qch+I4zT9ws5z?=
 =?us-ascii?Q?4bPhb6NdRTYnSQbqR6AHoiP9j2kU9DxebkebXghYGjM5bux0GwI+gEAN6G/Y?=
 =?us-ascii?Q?bz5xUkw/uniQs4gqe/Vem7ctboiEkIYsRQWVB0grMuiyLRWixh433fnpQUfH?=
 =?us-ascii?Q?4kx96LVW96kHI+Mr+mDgQhwFa0S/ra/3i/zXDGu+7leEGwqqoC8YQkd4DQAb?=
 =?us-ascii?Q?BbgEJdb0HsypOpLIzduIgIGdX3A35ckjsiHGBvgYCBmwqUoPsraKnNk1QD1y?=
 =?us-ascii?Q?1A2TW4Efjh3ppmDVTHavqbe4JggyOBYeiHZ9drfWvBeZwUmNeSjURPtkaFOB?=
 =?us-ascii?Q?KEmVSFM54VD9KFkc1r5YNmAimeMS5HqVAui2JCZjii8FZ0Rxm5l6Mjue99wK?=
 =?us-ascii?Q?lPEXc7MKDXHqX0o7GvKC+8AWTt1dStFNdep+ijt63rVGH8VDP6E/wdg+CR+o?=
 =?us-ascii?Q?LYEaU07v6V4FRDqXYKQvzxLx7N/UhZwynpAK7xoXS2LP71//v+cuUHmT5QWq?=
 =?us-ascii?Q?H370sVUmIZVnjAX6WW9/9G+VXcKu1zxocxhG3OQUAxLMZBB40BrLwDFEZSy6?=
 =?us-ascii?Q?VGAAa+XiDdzPgYrD1qNsYlsg6ZA1kfp1ojJI9nkt0Fn9FAdF1Rbyr4YaV1RI?=
 =?us-ascii?Q?aNthMx2y4/hzZszPygZCUrKrTXfcJu7oykRt7GXBfeZ1lUqv/KDO+qe8/WCE?=
 =?us-ascii?Q?7xi9OmnUMedeO1fiw43YHBXssQAV0flny4HUxuNJ5K2omUVXtFhJuR9W3lmE?=
 =?us-ascii?Q?pXo/n72iKj1cQrjVsgNjZovkbX6Y9Fh9lYMEe6cmC4tPgvLYYmlr5uPMCr0C?=
 =?us-ascii?Q?z/uinJwwz8tmVVSUobIVJJukOZncN1tNiLlJw1R4P42NZaryunE7o5mCFa1B?=
 =?us-ascii?Q?GZz0XBq7AAjgorvCpKI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff4fae4-641e-4ec4-aed9-08dbaf9813d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 11:46:30.5331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNyU6mX0mnQkGZsZJSitT26v7jdq158k3rsObegMfrzsPeWhbSi4JMVsJQ1YTe2mjNVamXW6prVluhaxp+XNSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
Subject: Re: [lttng-dev] LTTNG LIB UST Crash
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Lakshmi Deverkonda via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lakshmi Deverkonda <laksd@nvidia.com>
Content-Type: multipart/mixed; boundary="===============6979463397817280916=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6979463397817280916==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB455584B7DCA5C2A85BABE9D9D9EEAMW3PR12MB4555namp_"

--_000_MW3PR12MB455584B7DCA5C2A85BABE9D9D9EEAMW3PR12MB4555namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for replying.

Basically in our python3 application, we already have a logger which will r=
edirect the logs to a log file.  By default, only info logs gets logged unl=
ess user explicitly turns on debug logging via cli.

For LTTNG Tracing, we would want to log all the events that is both info/de=
bugs.
>>Do you think there would be any overhead on the application?
>> I cannot use the existing logger which does a file logging so for lttng =
only I have created just a new logger without any handler. Should this be f=
ine?
>>Also, I see the default channel created for the python logging in lttng  =
"lttng_python_channel" .  From the documentation, I see that we cannot crea=
te another channel for python logging.
I would want to modify some of the attribute for the default channel such a=
s making event-loss-mode as "overwrite" and increasing the trace_file_count=
. How can I do it ? This is one of the necessary requirement for our applic=
ation. Can you please guide on this ?


Regards,
Lakshmi
________________________________
From: Kienan Stewart <kstewart@efficios.com>
Sent: 06 September 2023 21:01
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>; Lakshmi Deverkon=
da <laksd@nvidia.com>
Subject: Re: [lttng-dev] LTTNG LIB UST Crash

External email: Use caution opening links or attachments


Hi Lakshmi,

On 2023-09-06 06:02, Lakshmi Deverkonda via lttng-dev wrote:
> Thanks for the reply. Issue is fixed after loading the tracing helpers.
>
> I have one query wrt to logging wrt lttng on python3 application. Is
> there any way I can avoid the file logging and only trace via lttng ?
>

In the example python application at
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.o=
rg%2Fdocs%2Fv2.13%2F%23doc-python-application&data=3D05%7C01%7Claksd%40nvid=
ia.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9ccc17=
a%7C0%7C0%7C638296111141743499%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DHMry=
NCihtLBKA49TWfsxp4%2FkzkFJhZrlyocoAsR7w78%3D&reserved=3D0<https://lttng.org=
/docs/v2.13/#doc-python-application> the log messages
are not written to disk or to stderr.

I lack the details of your application to give you a more precise answer.

Hope this helps,
kienan

> Regards,
> Lakshmi
>
>
> ------------------------------------------------------------------------
> *From:* Kienan Stewart <kstewart@efficios.com>
> *Sent:* 05 September 2023 21:20
> *To:* Lakshmi Deverkonda <laksd@nvidia.com>
> *Subject:* Re: [lttng-dev] LTTNG LIB UST Crash
> External email: Use caution opening links or attachments
>
>
> Hi Lakshmi,
>
> could you please provide us with the system details and version
> information for LTTng tools and UST?
>
> The bug reporting guidelines which cover the type of information
> required to respond adequately questions can be found here:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng=
.org%2Fcommunity%2F%23bug-reporting-guidelines&data=3D05%7C01%7Claksd%40nvi=
dia.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9ccc1=
7a%7C0%7C0%7C638296111141743499%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DZU4=
mg%2BDNKMbtxCVA3kRuyCZAaj7yUH5bLz6p4oXpROA%3D&reserved=3D0<https://lttng.or=
g/community/#bug-reporting-guidelines> <https://nam11.safelinks.protection.=
outlook.com/?url=3Dhttps%3A%2F%2Flttng.org%2Fcommunity%2F%23bug-reporting-g=
uidelines&data=3D05%7C01%7Claksd%40nvidia.com%7C5dec50116ea24aef578508dbaee=
e6437%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638296111141899697%7CUnk=
nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX=
VCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dx0QzE9thuFtUFdNKd2qg0Fo4XSYqeTB4vbEBl88d=
GxE%3D&reserved=3D0<https://lttng.org/community/#bug-reporting-guidelines>>
>
> Given that you are instrumenting a user space application, do you have a
> minimal reproducer of the crash including the details of how the
> application is invoked that you would be able to share?
>
> Some types of user space applications required tracing helpers loaded
> via LD_PRELOAD. More information can be found here
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng=
.org%2Fdocs%2Fv2.13%2F%23doc-prebuilt-ust-helpers&data=3D05%7C01%7Claksd%40=
nvidia.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9c=
cc17a%7C0%7C0%7C638296111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D=
WpDm%2FpMZMb3EukOw9NF9L2GiMZpWeOAq3It8H8p%2BNSI%3D&reserved=3D0<https://ltt=
ng.org/docs/v2.13/#doc-prebuilt-ust-helpers> <https://nam11.safelinks.prote=
ction.outlook.com/?url=3Dhttps%3A%2F%2Flttng.org%2Fdocs%2Fv2.13%2F%23doc-pr=
ebuilt-ust-helpers&data=3D05%7C01%7Claksd%40nvidia.com%7C5dec50116ea24aef57=
8508dbaeee6437%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638296111141899=
697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DWpDm%2FpMZMb3EukOw9NF9L2GiMZpWe=
OAq3It8H8p%2BNSI%3D&reserved=3D0<https://lttng.org/docs/v2.13/#doc-prebuilt=
-ust-helpers>>
>
> If you're unable to share code or other log files due to company policy,
> or require responses within a guaranteed time frame, EfficiOS offers
> commercial support services:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.e=
fficios.com%2Fservices%2F&data=3D05%7C01%7Claksd%40nvidia.com%7C5dec50116ea=
24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C63829611=
1141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB=
TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D92syXIQdFYIdm7jBG%2BEc%2=
FNFcSBujENDvSRG%2BaeyPCMs%3D&reserved=3D0<https://www.efficios.com/services=
/> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.efficios.com%2Fservices%2F&data=3D05%7C01%7Claksd%40nvidia.com%7C5dec50116=
ea24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638296=
111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D92syXIQdFYIdm7jBG%2BEc=
%2FNFcSBujENDvSRG%2BaeyPCMs%3D&reserved=3D0<https://www.efficios.com/servic=
es/>>
>
> thanks,
> kienan
>
> p.s. Sorry for forgetting to CC you in my earlier reply to the list!
>
> On 2023-09-05 02:30, Lakshmi Deverkonda via lttng-dev wrote:
>> Hi All,
>>
>> I am observing lttng crash while trying to interface LTTNG for one of my
>> python3 application.
>> I just tried the following things,
>>
>> Added "import lttngust " in the code.
>>
>> # lttng create clagd
>> Session clagd created.
>> Traces will be written in /root/lttng-traces/clagd-20230905-062210
>>
>> # lttng enable-event --python clagd
>> #lttng start
>>
>> #service clagd start
>> *
>> *
>> *cumulus-core: Running cl-support for core files
>> "clagd-ust.95410.1693895062.core"*
>>
>> #0  0x00007f134fb938eb in raise () from /lib/x86_64-linux-gnu/libc.so.6
>> #1  0x00007f134fb7e535 in abort () from /lib/x86_64-linux-gnu/libc.so.6
>> #2  0x00007f134fb7e40f in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>> #3  0x00007f134fb8c1a2 in __assert_fail () from
>> /lib/x86_64-linux-gnu/libc.so.6
>> #4  0x00007f134f1a9677 in lttng_ust_add_fd_to_tracker () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #5  0x00007f134f1bdcf4 in lttng_ust_elf_create () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #6  0x00007f134f1bf8de in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.=
so.0
>> #7  0x00007f134fc8f957 in dl_iterate_phdr () from
>> /lib/x86_64-linux-gnu/libc.so.6
>> #8  0x00007f134f1bff6b in lttng_ust_dl_update () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #9  0x00007f134f1c061a in do_lttng_ust_statedump () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #10 0x00007f134f1b5ca9 in lttng_handle_pending_statedump () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #11 0x00007f134f1ab6d1 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.=
so.0
>> #12 0x00007f134f1ad7eb in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.=
so.0
>> #13 0x00007f134ff0dfa3 in start_thread () from
>> /lib/x86_64-linux-gnu/libpthread.so.0
>> #14 0x00007f134fc5506f in clone () from /lib/x86_64-linux-gnu/libc.so.6
>>
>>
>> When I stop the lttng session, I see another core
>>
>> #0  0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu/libc.so.6
>> [Current thread is 1 (Thread 0x7fad9331f700 (LWP 2221103))]
>> (gdb) bt
>> #0  0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu/libc.so.6
>> #1  0x00007fad95183535 in abort () from /lib/x86_64-linux-gnu/libc.so.6
>> #2  0x00007fad9518340f in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>> #3  0x00007fad951911a2 in __assert_fail () from
>> /lib/x86_64-linux-gnu/libc.so.6
>> #4  0x00007fad947e8d9f in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.=
so.0
>> #5  0x00007fad947e98e3 in shm_object_table_destroy () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #6  0x00007fad947e4d9a in channel_destroy () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #7  0x00007fad947ba6b5 in lttng_session_destroy () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #8  0x00007fad947b47c6 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.=
so.0
>> #9  0x00007fad947b4bac in lttng_ust_objd_unref () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #10 0x00007fad947b4bac in lttng_ust_objd_unref () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #11 0x00007fad947b4bac in lttng_ust_objd_unref () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #12 0x00007fad947b5304 in lttng_ust_objd_table_owner_cleanup () from
>> /lib/x86_64-linux-gnu/liblttng-ust.so.0
>> #13 0x00007fad947b2b75 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.=
so.0
>> #14 0x00007fad95512fa3 in start_thread () from
>> /lib/x86_64-linux-gnu/libpthread.so.0
>> #15 0x00007fad9525a06f in clone () from /lib/x86_64-linux-gnu/libc.so.6
>>
>>
>> Can you please help here if I'm missing something. This is a critical
>> task item for us but are currently stuck with multiple lttng crashes.
>>
>> Regards,
>> Lakshmi
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&data=3D05%7C01%7Clak=
sd%40nvidia.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db39=
efd9ccc17a%7C0%7C0%7C638296111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sda=
ta=3DBaJ6W4wzDuPk2BuBxWO6bEptWW1NpA2oWZwEOGIDpRY%3D&reserved=3D0<https://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev> <https://nam11.safelinks.=
protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmai=
lman%2Flistinfo%2Flttng-dev&data=3D05%7C01%7Claksd%40nvidia.com%7C5dec50116=
ea24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638296=
111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC=
JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DBaJ6W4wzDuPk2BuBxWO6bE=
ptWW1NpA2oWZwEOGIDpRY%3D&reserved=3D0<https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev>>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&data=3D05%7C01%7Claks=
d%40nvidia.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db39e=
fd9ccc17a%7C0%7C0%7C638296111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdat=
a=3DBaJ6W4wzDuPk2BuBxWO6bEptWW1NpA2oWZwEOGIDpRY%3D&reserved=3D0<https://lis=
ts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>

--_000_MW3PR12MB455584B7DCA5C2A85BABE9D9D9EEAMW3PR12MB4555namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks for replying.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Basically in our python3 application, we already have a logger which will r=
edirect the logs to a log file.&nbsp; By default, only info logs gets logge=
d unless user explicitly turns on debug logging via cli.&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
For LTTNG Tracing, we would want to log all the events that is both info/de=
bugs.&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&gt;&gt;Do you think there would be any overhead on the application?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&gt;&gt; I cannot use the existing logger which does a file logging so for =
lttng only I have created just a new logger without any handler. Should thi=
s be fine?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
&gt;&gt;Also, I see the default channel created for the python logging in l=
ttng&nbsp; &quot;lttng_python_channel&quot; .&nbsp; From the documentation,=
 I see that we cannot create another channel for python logging.&nbsp;</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
I would want to modify some of the attribute for the default channel such a=
s making event-loss-mode as &quot;overwrite&quot; and increasing the trace_=
file_count. How can I do it ? This is one of the necessary requirement for =
our application. Can you please guide on this
 ?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
Lakshmi</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kienan Stewart &lt;ks=
tewart@efficios.com&gt;<br>
<b>Sent:</b> 06 September 2023 21:01<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;; Lak=
shmi Deverkonda &lt;laksd@nvidia.com&gt;<br>
<b>Subject:</b> Re: [lttng-dev] LTTNG LIB UST Crash</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">External email: Use caution opening links or attac=
hments<br>
<br>
<br>
Hi Lakshmi,<br>
<br>
On 2023-09-06 06:02, Lakshmi Deverkonda via lttng-dev wrote:<br>
&gt; Thanks for the reply. Issue is fixed after loading the tracing helpers=
.<br>
&gt;<br>
&gt; I have one query wrt to logging wrt lttng on python3 application. Is<b=
r>
&gt; there any way I can avoid the file logging and only trace via lttng ?<=
br>
&gt;<br>
<br>
In the example python application at<br>
<a href=3D"https://lttng.org/docs/v2.13/#doc-python-application">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.org%2Fdocs%=
2Fv2.13%2F%23doc-python-application&amp;data=3D05%7C01%7Claksd%40nvidia.com=
%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9ccc17a%7C0%=
7C0%7C638296111141743499%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DHMryNC=
ihtLBKA49TWfsxp4%2FkzkFJhZrlyocoAsR7w78%3D&amp;reserved=3D0</a>
 the log messages<br>
are not written to disk or to stderr.<br>
<br>
I lack the details of your application to give you a more precise answer.<b=
r>
<br>
Hope this helps,<br>
kienan<br>
<br>
&gt; Regards,<br>
&gt; Lakshmi<br>
&gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Kienan Stewart &lt;kstewart@efficios.com&gt;<br>
&gt; *Sent:* 05 September 2023 21:20<br>
&gt; *To:* Lakshmi Deverkonda &lt;laksd@nvidia.com&gt;<br>
&gt; *Subject:* Re: [lttng-dev] LTTNG LIB UST Crash<br>
&gt; External email: Use caution opening links or attachments<br>
&gt;<br>
&gt;<br>
&gt; Hi Lakshmi,<br>
&gt;<br>
&gt; could you please provide us with the system details and version<br>
&gt; information for LTTng tools and UST?<br>
&gt;<br>
&gt; The bug reporting guidelines which cover the type of information<br>
&gt; required to respond adequately questions can be found here:<br>
&gt; <a href=3D"https://lttng.org/community/#bug-reporting-guidelines">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.org%2=
Fcommunity%2F%23bug-reporting-guidelines&amp;data=3D05%7C01%7Claksd%40nvidi=
a.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9ccc17a=
%7C0%7C0%7C638296111141743499%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL=
CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DZ=
U4mg%2BDNKMbtxCVA3kRuyCZAaj7yUH5bLz6p4oXpROA%3D&amp;reserved=3D0</a>
 &lt;<a href=3D"https://lttng.org/community/#bug-reporting-guidelines">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.org%2=
Fcommunity%2F%23bug-reporting-guidelines&amp;data=3D05%7C01%7Claksd%40nvidi=
a.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9ccc17a=
%7C0%7C0%7C638296111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL=
CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dx=
0QzE9thuFtUFdNKd2qg0Fo4XSYqeTB4vbEBl88dGxE%3D&amp;reserved=3D0</a>&gt;<br>
&gt;<br>
&gt; Given that you are instrumenting a user space application, do you have=
 a<br>
&gt; minimal reproducer of the crash including the details of how the<br>
&gt; application is invoked that you would be able to share?<br>
&gt;<br>
&gt; Some types of user space applications required tracing helpers loaded<=
br>
&gt; via LD_PRELOAD. More information can be found here<br>
&gt; <a href=3D"https://lttng.org/docs/v2.13/#doc-prebuilt-ust-helpers">htt=
ps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.org%=
2Fdocs%2Fv2.13%2F%23doc-prebuilt-ust-helpers&amp;data=3D05%7C01%7Claksd%40n=
vidia.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9cc=
c17a%7C0%7C0%7C638296111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM=
DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
=3DWpDm%2FpMZMb3EukOw9NF9L2GiMZpWeOAq3It8H8p%2BNSI%3D&amp;reserved=3D0</a>
 &lt;<a href=3D"https://lttng.org/docs/v2.13/#doc-prebuilt-ust-helpers">htt=
ps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flttng.org%=
2Fdocs%2Fv2.13%2F%23doc-prebuilt-ust-helpers&amp;data=3D05%7C01%7Claksd%40n=
vidia.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db39efd9cc=
c17a%7C0%7C0%7C638296111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM=
DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
=3DWpDm%2FpMZMb3EukOw9NF9L2GiMZpWeOAq3It8H8p%2BNSI%3D&amp;reserved=3D0</a>&=
gt;<br>
&gt;<br>
&gt; If you're unable to share code or other log files due to company polic=
y,<br>
&gt; or require responses within a guaranteed time frame, EfficiOS offers<b=
r>
&gt; commercial support services:<br>
&gt; <a href=3D"https://www.efficios.com/services/">https://nam11.safelinks=
.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.efficios.com%2Fservices%2F=
&amp;data=3D05%7C01%7Claksd%40nvidia.com%7C5dec50116ea24aef578508dbaeee6437=
%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638296111141899697%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C3000%7C%7C%7C&amp;sdata=3D92syXIQdFYIdm7jBG%2BEc%2FNFcSBujENDvSRG%2=
BaeyPCMs%3D&amp;reserved=3D0</a>
 &lt;<a href=3D"https://www.efficios.com/services/">https://nam11.safelinks=
.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.efficios.com%2Fservices%2F=
&amp;data=3D05%7C01%7Claksd%40nvidia.com%7C5dec50116ea24aef578508dbaeee6437=
%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638296111141899697%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C3000%7C%7C%7C&amp;sdata=3D92syXIQdFYIdm7jBG%2BEc%2FNFcSBujENDvSRG%2=
BaeyPCMs%3D&amp;reserved=3D0</a>&gt;<br>
&gt;<br>
&gt; thanks,<br>
&gt; kienan<br>
&gt;<br>
&gt; p.s. Sorry for forgetting to CC you in my earlier reply to the list!<b=
r>
&gt;<br>
&gt; On 2023-09-05 02:30, Lakshmi Deverkonda via lttng-dev wrote:<br>
&gt;&gt; Hi All,<br>
&gt;&gt;<br>
&gt;&gt; I am observing lttng crash while trying to interface LTTNG for one=
 of my<br>
&gt;&gt; python3 application.<br>
&gt;&gt; I just tried the following things,<br>
&gt;&gt;<br>
&gt;&gt; Added &quot;import lttngust &quot; in the code.<br>
&gt;&gt;<br>
&gt;&gt; # lttng create clagd<br>
&gt;&gt; Session clagd created.<br>
&gt;&gt; Traces will be written in /root/lttng-traces/clagd-20230905-062210=
<br>
&gt;&gt;<br>
&gt;&gt; # lttng enable-event --python clagd<br>
&gt;&gt; #lttng start<br>
&gt;&gt;<br>
&gt;&gt; #service clagd start<br>
&gt;&gt; *<br>
&gt;&gt; *<br>
&gt;&gt; *cumulus-core: Running cl-support for core files<br>
&gt;&gt; &quot;clagd-ust.95410.1693895062.core&quot;*<br>
&gt;&gt;<br>
&gt;&gt; #0&nbsp; 0x00007f134fb938eb in raise () from /lib/x86_64-linux-gnu=
/libc.so.6<br>
&gt;&gt; #1&nbsp; 0x00007f134fb7e535 in abort () from /lib/x86_64-linux-gnu=
/libc.so.6<br>
&gt;&gt; #2&nbsp; 0x00007f134fb7e40f in ?? () from /lib/x86_64-linux-gnu/li=
bc.so.6<br>
&gt;&gt; #3&nbsp; 0x00007f134fb8c1a2 in __assert_fail () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/libc.so.6<br>
&gt;&gt; #4&nbsp; 0x00007f134f1a9677 in lttng_ust_add_fd_to_tracker () from=
<br>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #5&nbsp; 0x00007f134f1bdcf4 in lttng_ust_elf_create () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #6&nbsp; 0x00007f134f1bf8de in ?? () from /lib/x86_64-linux-gnu/li=
blttng-ust.so.0<br>
&gt;&gt; #7&nbsp; 0x00007f134fc8f957 in dl_iterate_phdr () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/libc.so.6<br>
&gt;&gt; #8&nbsp; 0x00007f134f1bff6b in lttng_ust_dl_update () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #9&nbsp; 0x00007f134f1c061a in do_lttng_ust_statedump () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #10 0x00007f134f1b5ca9 in lttng_handle_pending_statedump () from<b=
r>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #11 0x00007f134f1ab6d1 in ?? () from /lib/x86_64-linux-gnu/liblttn=
g-ust.so.0<br>
&gt;&gt; #12 0x00007f134f1ad7eb in ?? () from /lib/x86_64-linux-gnu/liblttn=
g-ust.so.0<br>
&gt;&gt; #13 0x00007f134ff0dfa3 in start_thread () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/libpthread.so.0<br>
&gt;&gt; #14 0x00007f134fc5506f in clone () from /lib/x86_64-linux-gnu/libc=
.so.6<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; When I stop the lttng session, I see another core<br>
&gt;&gt;<br>
&gt;&gt; #0&nbsp; 0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu=
/libc.so.6<br>
&gt;&gt; [Current thread is 1 (Thread 0x7fad9331f700 (LWP 2221103))]<br>
&gt;&gt; (gdb) bt<br>
&gt;&gt; #0&nbsp; 0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu=
/libc.so.6<br>
&gt;&gt; #1&nbsp; 0x00007fad95183535 in abort () from /lib/x86_64-linux-gnu=
/libc.so.6<br>
&gt;&gt; #2&nbsp; 0x00007fad9518340f in ?? () from /lib/x86_64-linux-gnu/li=
bc.so.6<br>
&gt;&gt; #3&nbsp; 0x00007fad951911a2 in __assert_fail () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/libc.so.6<br>
&gt;&gt; #4&nbsp; 0x00007fad947e8d9f in ?? () from /lib/x86_64-linux-gnu/li=
blttng-ust.so.0<br>
&gt;&gt; #5&nbsp; 0x00007fad947e98e3 in shm_object_table_destroy () from<br=
>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #6&nbsp; 0x00007fad947e4d9a in channel_destroy () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #7&nbsp; 0x00007fad947ba6b5 in lttng_session_destroy () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #8&nbsp; 0x00007fad947b47c6 in ?? () from /lib/x86_64-linux-gnu/li=
blttng-ust.so.0<br>
&gt;&gt; #9&nbsp; 0x00007fad947b4bac in lttng_ust_objd_unref () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #10 0x00007fad947b4bac in lttng_ust_objd_unref () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #11 0x00007fad947b4bac in lttng_ust_objd_unref () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #12 0x00007fad947b5304 in lttng_ust_objd_table_owner_cleanup () fr=
om<br>
&gt;&gt; /lib/x86_64-linux-gnu/liblttng-ust.so.0<br>
&gt;&gt; #13 0x00007fad947b2b75 in ?? () from /lib/x86_64-linux-gnu/liblttn=
g-ust.so.0<br>
&gt;&gt; #14 0x00007fad95512fa3 in start_thread () from<br>
&gt;&gt; /lib/x86_64-linux-gnu/libpthread.so.0<br>
&gt;&gt; #15 0x00007fad9525a06f in clone () from /lib/x86_64-linux-gnu/libc=
.so.6<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Can you please help here if I'm missing something. This is a criti=
cal<br>
&gt;&gt; task item for us but are currently stuck with multiple lttng crash=
es.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Lakshmi<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; lttng-dev@lists.lttng.org<br>
&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
sts.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&amp;data=3D05%7C01=
%7Claksd%40nvidia.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1=
b7db39efd9ccc17a%7C0%7C0%7C638296111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%=
7C&amp;sdata=3DBaJ6W4wzDuPk2BuBxWO6bEptWW1NpA2oWZwEOGIDpRY%3D&amp;reserved=
=3D0</a>
 &lt;<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.=
lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&amp;data=3D05%7C01%7Cl=
aksd%40nvidia.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db=
39efd9ccc17a%7C0%7C0%7C638296111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&a=
mp;sdata=3DBaJ6W4wzDuPk2BuBxWO6bEptWW1NpA2oWZwEOGIDpRY%3D&amp;reserved=3D0<=
/a>&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.=
lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&amp;data=3D05%7C01%7Cl=
aksd%40nvidia.com%7C5dec50116ea24aef578508dbaeee6437%7C43083d15727340c1b7db=
39efd9ccc17a%7C0%7C0%7C638296111141899697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&a=
mp;sdata=3DBaJ6W4wzDuPk2BuBxWO6bEptWW1NpA2oWZwEOGIDpRY%3D&amp;reserved=3D0<=
/a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MW3PR12MB455584B7DCA5C2A85BABE9D9D9EEAMW3PR12MB4555namp_--

--===============6979463397817280916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6979463397817280916==--
