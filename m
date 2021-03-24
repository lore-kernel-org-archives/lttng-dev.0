Return-Path: <SRS0=fpp6=IW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99C9C433E1
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 18:55:45 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099FB619EC
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 18:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099FB619EC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F5HW33JzGzMgM;
	Wed, 24 Mar 2021 14:55:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1616612144;
	bh=Mf5yQ7osbsVt+d+qTaIqJeJagGlgij2NQF19rCgsNco=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WiiKNFFN3cmtUVP9fARIoaIk2QlAlrPX7klefzHvx6C+C8/KYIgksORSsn1BggnVJ
	 JLjd09UGg3Wqye1CXP5DIpdBtpfkTwmjDmCibVnPL3vDaEg0Z76tyfMImJ1JOE229s
	 VqSkzPHw5XPzl7rOEYyWqsdXkjhVEO4cnkLJ8VM3PzVBnJRW0U45NAwebArQ4/imdt
	 JdGOZiTBzSS+jWnlEHTGRQUgS2uReX3MGmKcscUIv9Z2UDju2oprDMLUrSmFhUILR4
	 FwvnzfO88TI0KDJh33TQUp4VdRzkewyQ4rHmR/8Yh9GoUOhjlxF5Sj93ibOn0IQm+U
	 ACR8UiiVmpj+w==
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
 by lists.lttng.org (Postfix) with ESMTPS id 4F5HW11qV7zMVs
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 14:55:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIi4yRZ0UXs3j/9IbwrYiym/LwFLGcd4xZUoIhjmAjI/HRGydve8lLcJKj9R3qydjsvKNG4dwZYMeSu89komINkZi+CvNmqt9L8t1oQQngQTZ8xY7gRIh8tANSes1B9ZCzBXdwt26vqUIdtGMzwjcr9C9gg+cgPOXTnjvqYX5akAa6V8lfyyGlhNSgFJt1yKVfTOj6/wgxBaMj6bKzcD7PHBEWPzr4wGlp57mvF2ohJ//sIMAX+TfqRrBkbW1wTRBeIE48ph1XRXtH99rZjnlrBRPskByIeBYTjpfVd371GdawmRZ0QadZQJXRtqXit1Kvfg+L16eBurvuAUXfYdiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Eny3izEGoJVVnya5GrsphTDFsA0qkXHGE2Z3DuCDLM=;
 b=ElZLWmJpoNnx35D5ljb3YuzpHfnB7Bhb37fbaHbQ9jcaQNIRA0GjU0CGPUr/JLUW5omZetqTBfqJvKFWyjAPLhnyy1IXE/QqwZOOIlQnnXMrEzRNJdVSFZa3/zPwskRzibeOMJZ6xSdhlxEznwpvCiESll6KhnGGc1KwWE3zol+dEPlfhO047UpbuAuy95wluSDpUzpL95bUJ4hiui9w3Oaxnj+RPsqiFk6t5Zlzjpfx55KK/5qliCuqE1R+E87bRGilUZNHEwIFYMiQ6PrUGEGQYBHxKfQZO4Fmdwe/qnZt2z8fDffnr9jUfYBNYaqi5fATiyMIgn/N42ZxJ1Y/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15)
 by PR3PR02MB6220.eurprd02.prod.outlook.com (2603:10a6:102:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 18:55:37 +0000
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482]) by PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482%7]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 18:55:37 +0000
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)
Thread-Index: AQHXIJ8+s4nBMhgB0EaYFg2Q2oJLGaqTMeIAgAADJsmAAA+lgIAAAWh+gAAH+ICAAAhNgIAAI39w
Date: Wed, 24 Mar 2021 18:55:37 +0000
Message-ID: <PR3PR02MB6202B24C2EBFF492A659DFF1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <PR3PR02MB62023431654FB93182EA21A1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324142540.GB344120@joraj-alpa>
 <PR3PR02MB6202F969540C279A6A171F83D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324153255.GC344120@joraj-alpa>
 <PR3PR02MB620209CCED35CC62E1C8550FD1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324160629.GE344120@joraj-alpa>,<20210324163611.GF344120@joraj-alpa>
In-Reply-To: <20210324163611.GF344120@joraj-alpa>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.20.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d106f6ef-e53d-4eb3-3ea0-08d8eef669c1
x-ms-traffictypediagnostic: PR3PR02MB6220:
x-microsoft-antispam-prvs: <PR3PR02MB6220F3755AB53C47CE66FF13D1639@PR3PR02MB6220.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7b31Ot/2oEaDNcd+7+1mYmt8uEN4UN4gDfiBWiepTVcTn4PSIqyMP6kXp0hkbSjheQe4AxLhHIVIKGAuIp8CSzVxUNQHDzA3dIC5ybm5FfTwlvAPTmTirixHvcn+tPSpsX2lOOADwisxI6j/DiXl1cw6wrAvW7cSPtvkuM7W+7UyIgieYKXaFiND4iJC/OLMXfJVKmqGrJTumLXk5reEz8XOWDigQuDvozKkSSpMq6RO8n1KTRz3CGKR6b0Vs+lmjoM/lEbtgyo2sTN+W6T8gPdyZMWZYxZn09sfAKerE6mg2t1QZ+OE7ywvBZkuJSRtRw0iZDINWYeNR9ZjZz77b4TAzJ6XV8+PzQ1BcpQNMMCoZXLt2TL4d/k2LtO/+z3sOQ1Qo+Q+kCC1cQaEHBb6mtJJWWUfR7D/0dZkINqLkzGnYVlwA9xghSLasWTNX0iRboN06F41jA/UAl4ZRsXCsGxIsqP0LN85Jfbtlxq9e7/L1jYibg7cAAxLNdyR8Ch6ka97afq90A/9tHcOegWFA8wGMK86bSvDfrd1PLKSBpqEcPXZc2Q4zSvDW3cB9oO2vn5eTYCmOMAgIzrQ/nEu8NqmvpMf0hXfege5ab95FclYKLdLzqoJ4I8JMO9BVI4YPpGrbqXnsVUtGhMasFmPMJBIzWxzabV0njZabLDCQ5uiv1g8X77M+BNhLvmnforwerMfqtRd9TWQc02VM3lIVEhr/kyXE1awyqXDePhwRXk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR02MB6202.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39850400004)(33656002)(166002)(186003)(4326008)(64756008)(52536014)(8676002)(9686003)(83380400001)(55016002)(38100700001)(55236004)(86362001)(8936002)(7696005)(966005)(26005)(66946007)(478600001)(6506007)(66476007)(76116006)(786003)(316002)(66556008)(66446008)(6916009)(19627405001)(71200400001)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?5vFaSIwqvxf/WIbhBlEXBnMiH1USvNNq1JqQcAyUkLIph6NMPYYUwgt8lj?=
 =?iso-8859-1?Q?N5xtiYqnwwVrF1etfhZPgfgnhlqLeeOEFMDFkdNIbw5YMeljW4kz99pVpj?=
 =?iso-8859-1?Q?vEkvwJCYzh9LB35LfKtm33kq76fFfgkifCGitRZ3iGbr3T7iQrIyTrN1WK?=
 =?iso-8859-1?Q?GrptkAx2+BM7IYDN0FGzBpAmuIRwy+ET2d565i3ayIO5JsIeqXoCFjB8PF?=
 =?iso-8859-1?Q?dBbdirGPVUos2N9ZPGJ/LGoZ+aJqOOcGJ5CFWyBTAEYz4fWEAwgiwSaBOm?=
 =?iso-8859-1?Q?ElbdDIMva/he2rXk2FlEO/vqdP7KQ8qtrPGO3caB+cGMBs2qceol6Nr2V0?=
 =?iso-8859-1?Q?jMrfQYm+m70pqRG2TrZv/D6UamI5SAgGlCNWrnal2PLQHg+z6pf29T0yIh?=
 =?iso-8859-1?Q?6pVsjaZ5KtONAfeCtMg1ZzhO9UO6SJjhP4AG1VLa+bXpK/U02FQUFpdJmt?=
 =?iso-8859-1?Q?a3ww5jWsq1JmVxuAAET5+lHxpUY4RiykrLfFcFV6Od9X2TjaXRFrvU/2sm?=
 =?iso-8859-1?Q?5hfyf/+vAHNgEUidYvAkNCRqjwuXvJ3mfsIr1GqnuaBXusZ4qPTnNnA4wT?=
 =?iso-8859-1?Q?PSfBsKCW48ZQDYBNRYuQaNdZOhi7YtucJnhrD+3mEirRHyG2FdIqionyqk?=
 =?iso-8859-1?Q?pSa+Nzb39ebR/NKiORhG2JZbXjX/jLBT4egUI0S06JFV4BmzRmOUjSy9dL?=
 =?iso-8859-1?Q?0GmaXkcBYgjoOfE8gqzpIm0jrCqjJgPcque5B0quZskEPuRpyHCpJ3ugNX?=
 =?iso-8859-1?Q?MGZP+jsbz13R7lmtM2MII0rI5jxHB6MyI7TcLlYyGQynLz7d/hkrR1DHXL?=
 =?iso-8859-1?Q?6qThulBE+PxGgw6FLpYzivHk38/mnFhHaL9mULcT50aWnXbosJx75gm8kU?=
 =?iso-8859-1?Q?rOcZf8RQ5jAyTevX8vL20rdvKeI7gaBuctw3qI8cGoPn/19f4Q2Kw3yROC?=
 =?iso-8859-1?Q?WLtU683D69OoVxue8YYrBuiwaY/l+ZyyC/qQU1owZ9c98nXgEseRv1xuur?=
 =?iso-8859-1?Q?kPTBSHada/ro+zvA1n6X1MVN3IWX4+Svnd1I/LQMkwg6qsIgnxEL7sni/S?=
 =?iso-8859-1?Q?6pbKcrqzyE4mT/yUfY4vEVvKTyVOmnX2MnnXp07P8aaTCU3ES7WjhkGQ1e?=
 =?iso-8859-1?Q?WaWvr4G5+tFItlbQy8OeNrS+6MruPhbrY64627u2KueabCW75ONLzU7KYh?=
 =?iso-8859-1?Q?/hrzuFfVuwoxL18IcIxRAZbzv6CQ6Zxoas3PVPGOkEops2gUYGvahzdL+9?=
 =?iso-8859-1?Q?TZsyVSla1hxReD9KsUxfbUn0PfnZKsAfj0kqChLSp2lMklSVZukBnZaxvR?=
 =?iso-8859-1?Q?64zMafUT8M5HyozSjypaGmuizSyBXYWBGB/wcfAV3U8m/QE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6202.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d106f6ef-e53d-4eb3-3ea0-08d8eef669c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 18:55:37.5422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PB2x0x5u+8fDboeKaMULqR/W0f1Jp78O+Xvke/bXC489idCEaZ1iM7ISLYymDh9ZXHmB54+vg/rSyPO+JwbVfDoWjKD/c6Jrkbt4qILZx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6220
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
Content-Type: multipart/mixed; boundary="===============5872813690948419241=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5872813690948419241==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB6202B24C2EBFF492A659DFF1D1639PR3PR02MB6202eurp_"

--_000_PR3PR02MB6202B24C2EBFF492A659DFF1D1639PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

You are absolutely right !
I have two different lttng :   find /usr -name "*liblttng-ust*" Ubuntu Past=
ebin<https://paste.ubuntu.com/p/NVtXPhj4fW/>

According to you, what would be the best solution to solve this issue ?

I have indeed a folder named lttng-ust where I have made the (wrong) config=
ure / make.

I tried to (temporary) remove all the libttng* /usr/local/lib/, but I face =
this problem :
/usr/bin/ld: hello-tp.o: in function `__lttng_events_init__hello_world':
hello-tp.c:(.text+0xe56): undefined reference to `lttng_ust_probe_register'
/usr/bin/ld: hello-tp.o: in function `__lttng_events_exit__hello_world':
hello-tp.c:(.text+0xeb2): undefined reference to `lttng_ust_probe_unregiste=
r'
collect2: error: ld returned 1 exit status

In the worst case scenario I am able to get my last clean snapchot.

What would you advise me to do ?

Cheers,

________________________________
De : Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Envoy=E9 : mercredi 24 mars 2021 17:36
=C0 : MONTET Julien <julien.montet@reseau.eseo.fr>
Cc : lttng-dev <lttng-dev@lists.lttng.org>
Objet : Re: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)

Hi Julien,

> TBH nothing points toward a problem here. I would need to spawn a 20.04 t=
o check
> if something is broken, I might have time later today.

Finally I had a Vagrant definition file laying around for the stable-2.12 p=
pa
that let me bring up a vm easily. All seems fine.

How lttng is installed:

  add-apt-repository ppa:lttng/stable-2.12 -y
  apt-get update
  apt-get install -y lttng-tools lttng-modules-dkms babeltrace2 liblttng-us=
t-dev

From there all the steps for building the userspace application works witho=
ut
ANY modifications.

The app is able to connect itself to the global sessiond: https://paste.ubu=
ntu.com/p/QnfqbtgpFF/

Note that no local sessiond is present hence why the app does not communica=
te
with one.

Note that the user I am using here (vagrant) is not part of the "tracing" g=
roup
hence the user cannot interact with the global sessiond.

Such scenario return the following:

  vagrant@ubuntu2004:~$ lttng list -u
  Error: Unable to list UST events: No session daemon is available

Now let's start a lttng-sessiond for the user and restart our app (note tha=
t
this is not required for day to day tracing since a running app will connec=
t
itself and only for debugging purpose):

 lttng-sessiond -b
 LTTNG_UST_DEBUG=3D1 ./hello

Yielding: https://paste.ubuntu.com/p/MsnHt94FXZ/

Now the app is connected to both sessiond.

Now the user can list the event against the local lttng-sessiond:

  vagrant@ubuntu2004:~$ lttng list -u
  UST events:
  -------------

  PID: 15429 - Name: ./hello
        lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (14)) (type: =
tracepoint)
        lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE (13=
)) (type: tracepoint)


So based on this I would say that either we are not given the full picture =
of
what is going on or there is a step you are missing. One explication would =
be
that you end up linking against a older lttng-ust without knowing it.

Please run this an provide the output via a paste service:

   find /usr -name "*liblttng-ust*"

For example on my VM: https://paste.ubuntu.com/p/Tjxn3V7g5j/

Cheers

--
Jonathan Rajotte-Julien
EfficiOS

--_000_PR3PR02MB6202B24C2EBFF492A659DFF1D1639PR3PR02MB6202eurp_
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
You are absolutely right !</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I have two different lttng :&nbsp;<span style=3D"color:rgb(32, 31, 30);font=
-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &qu=
ot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helveti=
ca Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255, 255=
, 255);display:inline !important">&nbsp;
 find /usr -name &quot;*liblttng-ust*&quot;&nbsp;</span><a href=3D"https://=
paste.ubuntu.com/p/NVtXPhj4fW/" style=3D"font-family: &quot;Segoe UI&quot;,=
 &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-sys=
tem, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; fo=
nt-size: 14.6667px;">Ubuntu
 Pastebin</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
According to you, what would be the best solution to solve this issue ?</di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I have indeed a folder named lttng-ust where I have made the (wrong) config=
ure / make.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I tried to (temporary) remove all the libttng* /usr/local/lib/, but I face =
this problem :&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
/usr/bin/ld: hello-tp.o: in function `__lttng_events_init__hello_world':
<div>hello-tp.c:(.text+0xe56): undefined reference to `lttng_ust_probe_regi=
ster'</div>
<div>/usr/bin/ld: hello-tp.o: in function `__lttng_events_exit__hello_world=
':</div>
<div>hello-tp.c:(.text+0xeb2): undefined reference to `lttng_ust_probe_unre=
gister'</div>
<div>collect2: error: ld returned 1 exit status</div>
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
In the worst case scenario I am able to get my last clean snapchot.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
What would you advise me to do ?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Cheers,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>De :</b> Jonathan Rajotte-Julie=
n &lt;jonathan.rajotte-julien@efficios.com&gt;<br>
<b>Envoy=E9 :</b> mercredi 24 mars 2021 17:36<br>
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
&gt; TBH nothing points toward a problem here. I would need to spawn a 20.0=
4 to check<br>
&gt; if something is broken, I might have time later today.<br>
<br>
Finally I had a Vagrant definition file laying around for the stable-2.12 p=
pa<br>
that let me bring up a vm easily. All seems fine.<br>
<br>
How lttng is installed:<br>
<br>
&nbsp; add-apt-repository ppa:lttng/stable-2.12 -y<br>
&nbsp; apt-get update<br>
&nbsp; apt-get install -y lttng-tools lttng-modules-dkms babeltrace2 libltt=
ng-ust-dev<br>
<br>
From there all the steps for building the userspace application works witho=
ut<br>
ANY modifications.<br>
<br>
The app is able to connect itself to the global sessiond: <a href=3D"https:=
//paste.ubuntu.com/p/QnfqbtgpFF/">
https://paste.ubuntu.com/p/QnfqbtgpFF/</a><br>
<br>
Note that no local sessiond is present hence why the app does not communica=
te<br>
with one.<br>
<br>
Note that the user I am using here (vagrant) is not part of the &quot;traci=
ng&quot; group<br>
hence the user cannot interact with the global sessiond.<br>
<br>
Such scenario return the following:<br>
<br>
&nbsp; vagrant@ubuntu2004:~$ lttng list -u<br>
&nbsp; Error: Unable to list UST events: No session daemon is available<br>
<br>
Now let's start a lttng-sessiond for the user and restart our app (note tha=
t<br>
this is not required for day to day tracing since a running app will connec=
t<br>
itself and only for debugging purpose):<br>
<br>
&nbsp;lttng-sessiond -b<br>
&nbsp;LTTNG_UST_DEBUG=3D1 ./hello<br>
<br>
Yielding: <a href=3D"https://paste.ubuntu.com/p/MsnHt94FXZ/">https://paste.=
ubuntu.com/p/MsnHt94FXZ/</a><br>
<br>
Now the app is connected to both sessiond.<br>
<br>
Now the user can list the event against the local lttng-sessiond:<br>
<br>
&nbsp; vagrant@ubuntu2004:~$ lttng list -u<br>
&nbsp; UST events:<br>
&nbsp; -------------<br>
&nbsp; <br>
&nbsp; PID: 15429 - Name: ./hello<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng_ust_tracelog:TRACE_DEBUG (=
loglevel: TRACE_DEBUG (14)) (type: tracepoint)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng_ust_tracelog:TRACE_DEBUG_L=
INE (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)<br>
<br>
<br>
So based on this I would say that either we are not given the full picture =
of<br>
what is going on or there is a step you are missing. One explication would =
be<br>
that you end up linking against a older lttng-ust without knowing it.<br>
<br>
Please run this an provide the output via a paste service:<br>
<br>
&nbsp;&nbsp; find /usr -name &quot;*liblttng-ust*&quot;<br>
<br>
For example on my VM: <a href=3D"https://paste.ubuntu.com/p/Tjxn3V7g5j/">ht=
tps://paste.ubuntu.com/p/Tjxn3V7g5j/</a><br>
<br>
Cheers<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</div>
</span></font></div>
</body>
</html>

--_000_PR3PR02MB6202B24C2EBFF492A659DFF1D1639PR3PR02MB6202eurp_--

--===============5872813690948419241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5872813690948419241==--
