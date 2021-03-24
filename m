Return-Path: <SRS0=fpp6=IW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81872C433C1
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 15:53:32 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73B961A09
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 15:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73B961A09
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F5CSp3B9HzMX7;
	Wed, 24 Mar 2021 11:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1616601210;
	bh=gca5YfKGKo2JJqxVoq00svjZHTbFU+PFzD4cAk3IyrM=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=x6PHLUo+nXX/ARSnJq7d4QDlkyYHHEMHChEq2XSVimxi0rSL8/se+sfsZdHmVZvaC
	 XoPRhXcFfQ2QRmo23ExewnMHyjprUlxpiCh6P+9qXbbXom1kHSwcPXpsY+JbN0JWM9
	 twPMWmu6mKZLiKa844jPOCOg32XUoZ4BqQ5UMw327aX1LvXcTtD3uY/7hdp4LqVdw+
	 TQUYcnDew8fVHGzY7sMrSsaVIiUwTBpHzhVltL6O8zaz/BhkKIlBeAVH+PmIJt5fCH
	 gDjk7bLcx2hPGllZf4VQoRqkgA8eO7+xsQqVM0EF/tvzVAqDPgnaH+zZWoENzobjAu
	 NuCIovDEbs2Rw==
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
 by lists.lttng.org (Postfix) with ESMTPS id 4F5CSl733kzMLc
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 11:53:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICHOLsbKEtJJS6eWnB8jYBHb3L7w7bL4tWhOv+utrt7TI2MsCwra/rppP7HkqokKuI52niJIaKz8MAGNHLqnLSFVRf7aXPaXmh91SsT3wIKwqiWbDsfUGGdSbzazEu4w/lT2VbCGMduZF+QsGh9zSwoKny6tJGzkNoUieAU+7Fg2RSLxcNYXwu/ts970/zilf4H1zkuiyIoePA1JLLF6O4OGZikOh4OsSmjfgni6eGgSPk2uYfRqe2FhtsOKR5ze8VOKqLnwwb1vofOlOPEkyuq32uYewZfGTeeA+QrcjhrHauzU/m1BarAB3+o/nnxfm2l4AUW6BlvyU23BmFwvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXVj1G57nrXcLbwgmztu9FgxHQaCiGtyir0HNfBu3+4=;
 b=l0wVImnQ6ct5ceq44kuYtvarxtkCMy+l6vHa2rYmG5cLdyS/oFtTTi1QYZOhnkz80ZUWzvSFbfBrvm+s6nSmUzP7m5FhjWbj5LlZ5N0/CeLmyuKAgECiHf5mumrzqw/fn5yc15jPRF9j0Xj9vRjxfDii/rhNqDQFtq3KM6750w+dOJbf5dorom8nLriY3jtojcTTgzBPllVVct5q9aq43nOcAujuO8JoMe39XTgH4ZAg5TkGSkm0d4pZboKSt5Z6nJpNic9v3jCRwgr/L5jFI2jnKj4T8w1RNqXMcBnsEmJcCYwWLCXjhnSO6MLNMLzobCSjhLc0oSXMCyqfiB8v1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15)
 by PR3PR02MB6331.eurprd02.prod.outlook.com (2603:10a6:102:7b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 15:53:14 +0000
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482]) by PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482%7]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 15:53:14 +0000
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)
Thread-Index: AQHXIJ8+s4nBMhgB0EaYFg2Q2oJLGaqTMeIAgAADJsmAAA+lgIAAAWh+
Date: Wed, 24 Mar 2021 15:53:14 +0000
Message-ID: <PR3PR02MB620209CCED35CC62E1C8550FD1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <PR3PR02MB62023431654FB93182EA21A1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324142540.GB344120@joraj-alpa>
 <PR3PR02MB6202F969540C279A6A171F83D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>,
 <20210324153255.GC344120@joraj-alpa>
In-Reply-To: <20210324153255.GC344120@joraj-alpa>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.20.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94af8b47-3347-46a7-d7b8-08d8eedcef0d
x-ms-traffictypediagnostic: PR3PR02MB6331:
x-microsoft-antispam-prvs: <PR3PR02MB63318975B11E22243B75D657D1639@PR3PR02MB6331.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: foWLrE4q45a4eAJ979CEih89fZDHq3JmN6sHAz0qCGKSpcM4bK/Gi8TjiFiYo7sD/bcFzJ1djNXFPa2v1fS7AfW//+QOWK25OLlUcoppohlrku20swKbKFqpn5S9E2+Y6wqlIUmiWUMvZ5cim3pLwhYRZ/ZXzxlytuIjtI4JyYlqtLdxSwLP1qWdYVdSmzTEzhHGVLZFziw43zsck+9veSnIOPQXrHm0AYXgfJ4ea4KSjJaZbCAGmOb2504Tg13W7FEdC8AkI6SR6OQEF5fqeHU9L3qVlTIlH4udpyJu3ifQPEl/yEOwus0MYHqrwDS5faQng+jCwqetqTukAqDrjslOnuGKviOckpnbTpVUD6ZDn0xmPb+D+QFtcCF0N5qOLUuMrJrG0CoLLIYakBsdFPY4V8n/fbk6NG6JIUV4YThT1uqq96QlwDT7d+4azk2Wo5czibJ2gbcK92qtkYhBazYMeIPrLJa6DqQX8Y01xzMEGS6rAW1hw8bOu9xEoeABe2AHzz+DnABSkAkqXLqs0RdgvidLCE4aBGlu36FXBvn/gbwIstFx2EjHS04/pJXA0jGkp1tAjnwh4D1yNA3pTZ5vYoW+/MIWcG77Q6s0fXYdHdwfN00YJmBZa4XOb8+DQC2gvrW/Ekezh51eeS5FziTAY6tBxOHnKYefkb8JMN9EfHECR8T14LoL85UGOFE7W/x3h397U9CXTB4XewYJGd1Z/7avxlsYvnbpy+HEgjQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR02MB6202.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(346002)(376002)(136003)(366004)(396003)(166002)(6916009)(2906002)(66446008)(86362001)(966005)(6506007)(71200400001)(7696005)(4326008)(478600001)(33656002)(66556008)(186003)(76116006)(26005)(786003)(66476007)(8936002)(52536014)(38100700001)(5660300002)(8676002)(55236004)(64756008)(66946007)(55016002)(316002)(9686003)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?otcJ661HczTNgLeFQLgLSB6yxpOToKrQAEs1D3gfBK0TFO7fkCPg1uXZ9u?=
 =?iso-8859-1?Q?mXwKKGhTkbalyjPZIfiE8yXkZpZwP/TQ8RmgxzNGGJk/2Ve+tfL6pWYsp2?=
 =?iso-8859-1?Q?TelW+1PIHOhAAr7jL/SkrnZKRQXjlDTLTWdi/DUMoyEeGKhkOArrnqBMOh?=
 =?iso-8859-1?Q?ME8kvdvY6XjMtGaOKrJ9XV8sIItjD7SGO2nIjShENfNtWMgsT9yK14JEBT?=
 =?iso-8859-1?Q?BmTMy6WBuL+rd1WwKIcI+VPeMP718IFEjnPItovpenSvmfVqxXgG+IjEGy?=
 =?iso-8859-1?Q?RSycMsDQYenyiC4Co0Fi0/MmFOMv1c0YpcXhAmjB9WNT4rMOPRIR/x6m12?=
 =?iso-8859-1?Q?/kWBPL2+zwIcNK/sHeGeNKh9IiNuzp+E8JwajxK+pJiVsTk1aqxbqpAEJG?=
 =?iso-8859-1?Q?ALlH3XjJ3qoZcQ4PGCW+JSTFbcZ0/NiMUO+RX+CQr/o6TZl7ULJlnx+ksC?=
 =?iso-8859-1?Q?+PbHHpvrCqB1F68Opiel8lmkbO/4RQhYsN1DSif+NN3eD96rOAFPDrcLnM?=
 =?iso-8859-1?Q?4nzBAcVpreJFuHKgCCxDUA70rw0LvR9ttoPYDr6m4pw4sHf1AVajmY0mr1?=
 =?iso-8859-1?Q?YrW2AbsF/f5MWwdieg6KhcH3uEOlHIya+5lcu7TOlTwc6fFGMDclUvgoBX?=
 =?iso-8859-1?Q?s0CI4AhzRMX6bP3dM/6vlbsXZ86OWeOswdGpeL5g9RbEncJDWAvst6xNYN?=
 =?iso-8859-1?Q?JGFK3wDglVwQTN28nM3ebwFBrpSUb4PFT8wtICYQHOz36avFVIeOKr2uO/?=
 =?iso-8859-1?Q?dD73yrEc6XLfQa7i3NSke77MDfS5GReOcWxCtlO3vi+D3u+ehypp99PwYV?=
 =?iso-8859-1?Q?XigxlKd4y3BNVujVGGzinOPfZW335jELOOfWjS1f6osHeAZRNRcVXVfIHY?=
 =?iso-8859-1?Q?GCj1t7e6mxsAbchOq0x6P/LVqgMGFcD2crQygYRCy8DhTf8+YL7hYAL1pK?=
 =?iso-8859-1?Q?FBm+gsafXnvT9m8xgT3MvVJ/QvN8ah6P9bKvTMSdbS+Dbp7w2gdw3rj4v6?=
 =?iso-8859-1?Q?uJUyPCTG3izdmsFnfM+tFqR1g5nxsFdfBFBh+wT58NI+4j2SH8Eyv5LKZQ?=
 =?iso-8859-1?Q?Gr+qML0y35FX0ipN3Y+KRwoqNmeFSWXbMzmaSlXVeG2BZF9huClvmY/Rzr?=
 =?iso-8859-1?Q?SfEt+RHrlmoimYEN/IdDo+7B7THgqitOtHjxv5oCD1tpye5lZJ7opYU0yN?=
 =?iso-8859-1?Q?pO2bGIJtRyZpmhqx+u33AJtB+fAvM2BqOaNJf2Pl62CjxcEGkrCXcjLZa9?=
 =?iso-8859-1?Q?MMlTLGP/tzgwIDOVZq7QX2soQzyd1EKKQ1bqnLkK1EEnFFSutsP4rnC5ma?=
 =?iso-8859-1?Q?jI5pQHQ3dQerl1dz25lGOH+fG56uPvdUUuG9kgJPN2pwNzE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6202.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94af8b47-3347-46a7-d7b8-08d8eedcef0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 15:53:14.2403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3W30FSM4IyBXCXP48VHW77VOon9f32bGuqH/btMORgQkgTM6YhIz8tP2lNjpIAS1/lebEqtfnGT/McCFeD9i4U9ZK/yz82Ff2s505bwAc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6331
Subject: Re: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: MONTET Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: MONTET Julien <julien.montet@reseau.eseo.fr>
Content-Type: multipart/mixed; boundary="===============4395551874722504544=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4395551874722504544==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB620209CCED35CC62E1C8550FD1639PR3PR02MB6202eurp_"

--_000_PR3PR02MB620209CCED35CC62E1C8550FD1639PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

After having written 'sudo systemctl stop lttng-sessiond.service', the comm=
and 'sudo lttng-sessiond -vvv > /tmp/lttng-sessiond.log 2>&1' gives me noth=
ing.

ls -la /var/run/lttng/ : Ubuntu Pastebin<https://paste.ubuntu.com/p/gjbqKkC=
rZK/>
groups : Ubuntu Pastebin<https://paste.ubuntu.com/p/pjVFHk7kFZ/>
lttng-sessiond -vvv > /tmp/lttng-sessiond-local.log 2>&1 : nothing
/tmp/lttng-sessiond-local.log : Ubuntu Pastebin<https://paste.ubuntu.com/p/=
bj38FhhVpc/>

The issue persist with the 'lttng list' command.

Best regards,

Sorry it was indeed :
The command lines entered to compile are quite the same, I just had to modi=
fy :
> this :     gcc -o hello hello.o hello-tp.o -llttng-ust -ldl
> to this : gcc -o hello hello.o hello-tp.o -L/usr/local/lib -llttng-ust -l=
dl
(I just wanted to focus the importance of  -L/usr/local/lib)

________________________________
De : Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Envoy=E9 : mercredi 24 mars 2021 16:32
=C0 : MONTET Julien <julien.montet@reseau.eseo.fr>
Cc : lttng-dev <lttng-dev@lists.lttng.org>
Objet : Re: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)

Hi Julien,

Please always keep the mailing list in CC.

> I am running 'lttng list --userspace' with the application running in ano=
ther terminal (like the tutorial, and also with a while that loop on tracep=
oint(...).

ok.

>
> You can find here the Ubuntu paste : Ubuntu Pastebin<https://paste.ubuntu=
.com/p/bWw25kmSTq/>

Based on this, it seems like lttng-ust is unable to find the socket for a s=
essiond either
locally (for your user) [1] or a global one (root lttng-sessiond) [2].

[1] 43:  libust[207688/207690]: Info: sessiond not accepting connections to=
 local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1822)
[2] 45:  libust[207688/207689]: Info: sessiond not accepting connections to=
 global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1822)

Since you installed via the PPA, a systemd service control service is insta=
lled
that control a global (root) lttng-sessiond.

First let's stop it.
   sudo systemctl stop lttng-sessiond.service

Then in a console, again use a paste service to share the content of /tmp/l=
ttng-sessiond.log with us

   sudo lttng-sessiond -vvv > /tmp/lttng-sessiond.log 2>&1

In another console, while the lttng-sessiond process is running, please hav=
e a look at the /var/run/lttng directory:

 ls -la /var/run/lttng/

Again use a paste service to share this with us.

Also can you provide the output of the following while using the user you a=
re
normally using to play with lttng:

 groups

You can also try to spawn a local lttng-sessiond for the user.
  Note that a global and many local lttng-sessiond can coexist but for the =
sake of debugging
  we will only have one of each at a time.

Kill the root lttng-sessiond we started earlier and start a local one:

 lttng-sessiond -vvv > /tmp/lttng-sessiond-local.log 2>&1

 Note the absence of `sudo` here.

Again please share the content of /tmp/lttng-sessiond-local.log via a paste
service.

From there you can retry your experiment with the `lttng list` command.

Cheers


> The command lines entered to compile are quite the same, I just had to mo=
dify :
> this :     gcc -o hello hello.o hello-tp.o
> to this : gcc -o hello hello.o hello-tp.o -L/usr/local/lib -llttng-ust -l=
dl

As per the doc [3]:
    gcc -o hello hello.o hello-tp.o -llttng-ust -ldl

[3] https://lttng.org/docs/v2.12/#doc-tracing-your-own-user-application Bul=
let point #6

Cheers

--_000_PR3PR02MB620209CCED35CC62E1C8550FD1639PR3PR02MB6202eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Jonathan,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
After having written '<span style=3D"color:rgb(32, 31, 30);font-family:&quo=
t;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&=
quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot=
;, sans-serif;font-size:14.6667px;background-color:rgb(255, 255, 255);displ=
ay:inline !important">sudo
 systemctl stop lttng-sessiond.service', the command '<span style=3D"backgr=
ound-color:rgb(255, 255, 255);display:inline !important">sudo lttng-session=
d -vvv &gt; /tmp/lttng-sessiond.log 2&gt;&amp;1' gives me nothing.</span><b=
r>
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t"><b><br>
</b></span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t"><b>ls
 -la /var/run/lttng/ :&nbsp;</b></span></span><a href=3D"https://paste.ubun=
tu.com/p/gjbqKkCrZK/" id=3D"LPlnk587030" style=3D"font-family: Calibri, Hel=
vetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe U=
I Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android E=
moji&quot;, EmojiSymbols; font-size: 12pt;">Ubuntu
 Pastebin</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>groups</b> :&nbsp;<a href=3D"https://paste.ubuntu.com/p/pjVFHk7kFZ/" id=
=3D"LPlnk488565">Ubuntu Pastebin</a><br>
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
<b>lttng-sessiond
 -vvv &gt; /tmp/lttng-sessiond-local.log 2&gt;&amp;1 :</b> nothing</span></=
div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px;"><b>/tmp/lttng-sessiond-local.log
</b>:&nbsp;</span><a href=3D"https://paste.ubuntu.com/p/bj38FhhVpc/" id=3D"=
LPlnk513333" style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web=
 (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystem=
Font, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px;=
">Ubuntu
 Pastebin</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The issue persist with the '<span style=3D"color:rgb(32, 31, 30);font-famil=
y:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Seg=
oe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neu=
e&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255, 255, 255)=
;display:inline !important">lttng
 list' command.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
<br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
Best
 regards,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
<br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
<b>Sorry
 it was indeed :&nbsp;</b></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">The
 command lines entered to compile are quite the same, I just had to modify =
:</span><br style=3D"background-color:rgb(255, 255, 255)">
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">&gt; this :&nbsp;&nbsp;&nbsp;&nbsp; gcc -o hello hello.o hello-tp.o&nbsp=
;<span style=3D"background-color:rgb(255, 255, 255);display:inline !importa=
nt">-llttng-ust -ldl</span></span><br style=3D"background-color:rgb(255, 25=
5, 255)">
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">&gt; to this : gcc -o hello hello.o hello-tp.o
<b>-L/usr/local/lib</b> -llttng-ust -ldl</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color:rgb(32, 31, 30);font-family:&quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;font-siz=
e:14.6667px;background-color:rgb(255, 255, 255);display:inline !important">=
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">(I
 just wanted to focus the importance of&nbsp;<span style=3D"background-colo=
r:rgb(255, 255, 255);display:inline !important"><span>&nbsp;</span></span><=
b>-L/usr/local/lib)</b></span></span></div>
<div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"color:rgb(0,0,0); fon=
t-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Sym=
bol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:12pt">
<p></p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>De :</b> Jonathan Rajotte-Julie=
n &lt;jonathan.rajotte-julien@efficios.com&gt;<br>
<b>Envoy=E9 :</b> mercredi 24 mars 2021 16:32<br>
<b>=C0 :</b> MONTET Julien &lt;julien.montet@reseau.eseo.fr&gt;<br>
<b>Cc&nbsp;:</b> lttng-dev &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Objet :</b> Re: [lttng-dev] Issues on basic LTTng trace userspace (tutor=
ial)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Julien,<br>
<br>
Please always keep the mailing list in CC.<br>
<br>
&gt; I am running 'lttng list --userspace' with the application running in =
another terminal (like the tutorial, and also with a while that loop on tra=
cepoint(...).<br>
<br>
ok.<br>
<br>
&gt; <br>
&gt; You can find here the Ubuntu paste : Ubuntu Pastebin&lt;<a href=3D"htt=
ps://paste.ubuntu.com/p/bWw25kmSTq/">https://paste.ubuntu.com/p/bWw25kmSTq/=
</a>&gt;<br>
<br>
Based on this, it seems like lttng-ust is unable to find the socket for a s=
essiond either<br>
locally (for your user) [1] or a global one (root lttng-sessiond) [2].<br>
<br>
[1] 43:&nbsp; libust[207688/207690]: Info: sessiond not accepting connectio=
ns to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1822)=
<br>
[2] 45:&nbsp; libust[207688/207689]: Info: sessiond not accepting connectio=
ns to global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1822=
)<br>
<br>
Since you installed via the PPA, a systemd service control service is insta=
lled<br>
that control a global (root) lttng-sessiond.<br>
<br>
First let's stop it.<br>
&nbsp;&nbsp; sudo systemctl stop lttng-sessiond.service<br>
<br>
Then in a console, again use a paste service to share the content of /tmp/l=
ttng-sessiond.log with us<br>
<br>
&nbsp;&nbsp; sudo lttng-sessiond -vvv &gt; /tmp/lttng-sessiond.log 2&gt;&am=
p;1<br>
<br>
In another console, while the lttng-sessiond process is running, please hav=
e a look at the /var/run/lttng directory:<br>
<br>
&nbsp;ls -la /var/run/lttng/<br>
<br>
Again use a paste service to share this with us.<br>
<br>
Also can you provide the output of the following while using the user you a=
re<br>
normally using to play with lttng:<br>
<br>
&nbsp;groups<br>
<br>
You can also try to spawn a local lttng-sessiond for the user.<br>
&nbsp; Note that a global and many local lttng-sessiond can coexist but for=
 the sake of debugging<br>
&nbsp; we will only have one of each at a time. <br>
<br>
Kill the root lttng-sessiond we started earlier and start a local one:<br>
<br>
&nbsp;lttng-sessiond -vvv &gt; /tmp/lttng-sessiond-local.log 2&gt;&amp;1 <b=
r>
<br>
&nbsp;Note the absence of `sudo` here.<br>
<br>
Again please share the content of /tmp/lttng-sessiond-local.log via a paste=
<br>
service.<br>
<br>
From there you can retry your experiment with the `lttng list` command.<br>
<br>
Cheers<br>
<br>
<br>
&gt; The command lines entered to compile are quite the same, I just had to=
 modify :<br>
&gt; this :&nbsp;&nbsp;&nbsp;&nbsp; gcc -o hello hello.o hello-tp.o<br>
&gt; to this : gcc -o hello hello.o hello-tp.o -L/usr/local/lib -llttng-ust=
 -ldl<br>
<br>
As per the doc [3]:<br>
&nbsp;&nbsp;&nbsp; gcc -o hello hello.o hello-tp.o -llttng-ust -ldl<br>
<br>
[3] <a href=3D"https://lttng.org/docs/v2.12/#doc-tracing-your-own-user-appl=
ication">
https://lttng.org/docs/v2.12/#doc-tracing-your-own-user-application</a> Bul=
let point #6<br>
<br>
Cheers<br>
</div>
</span></font></div>
</body>
</html>

--_000_PR3PR02MB620209CCED35CC62E1C8550FD1639PR3PR02MB6202eurp_--

--===============4395551874722504544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4395551874722504544==--
