Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF23C3ABB2
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Sep 2024 00:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1726533854;
	bh=3keG/Cf16n/9ysA+AKKKWOFEg1euW7LiOtsclHNtffA=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=VIYK6bjRLpCcHJMdJxROOA4+fqjHUsJ2tgFhZ2hthYm/CrDElkXP3Xv95Sq/MZM/m
	 zXoNdysKC7qLI4lgjHhPExixTK7EOD9ya0k8YXc++Hg/jhaks7JvJh9b7EabkU1Oz5
	 +Ctx6vzVpvfolSmv12ml1WRvqA+f0e00AXiy5dq7c5GoVLegm0AfDLwzYHhrsLuQjG
	 Y/fQfpM0r62+/lfniLUCbCH9xqXN/Rut5IToZttXum4et5E5HuEWcIdUBwscrANMZj
	 EC4QL6EZZACrK7WQ3qHfB2/zwCoHxzbS9J0/XoLc9GSn/Vy4URWS+FGIzpk8pdZG2s
	 JCqrKjenpmhuQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4X73254YgQz1HgQ;
	Mon, 16 Sep 2024 20:44:13 -0400 (EDT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04olkn2081e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2c0a::81e])
 by lists.lttng.org (Postfix) with ESMTPS id 4X732358s4z1H4c
 for <lttng-dev@lists.lttng.org>; Mon, 16 Sep 2024 20:44:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUAG7NIzqmWaOwEzq0R6XBxaOeAD/Pe3lllHnqYua8ja7n/M0Jzn3hq0JU9YtZe8q1jvyeHYBcSL0vS7/HoE/Sr+NLl7Rxd96W/ZYpukJLUiIQG79mN8BH+FqmSIdQNkydRCdUWkHPqfuMUEkDufmMeINRW96nLgGJUEmGsKZdYfZsMWYd6ylDPnxvMvPW6hk6gak8/Dz2u1vW9AEvRoXmE7nPpnBhBiP1wqUntNmhPXi/4TxceUIxrqnnuhkl0+hkiMor6zZD7LcTnZfe8LS9SVxXPXnRuFwo5Mrirk69llu/A86X9VAmK3DY34BjVdFnPmMZAXmAFNNUWtpUqTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KOQwxB4jzfE98OXHEX1gyU8X8ZeQEx5Cmy8qyXAeyU=;
 b=hNjXXxTa32j3j+flXIRPd0bGNf/mP4hQRz9yRldElWxo7P+I1rYtpNDhWcKHH1y4AUuOR9bbu0aSKaO6EqvEj3E0XfHylYS+wUr6PS5W0iZoRzzoSwIG1UdFYGQ7Eebdn9Gvldp6hu+27hDvIgW/3D3Hm/7kPUXjqmjUekHfd48MXQaJFmQ4k/+86csLG4tzSYHuGI90b35/jCMr/P9Zu7i2dt/u+zsGCqhaW2g/sOTncHozq1gmVjVwcn51E9cHOn4sd8mENJsTp06dMIXYrkqu7iGM2CuK3Fh2eyOZ2h6fkVz2+KJgH7TBd4btkUch0LzGT1R2HBlMyAqavUs6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from LV8P222MB1013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:1e4::5)
 by SJ2P222MB0969.NAMP222.PROD.OUTLOOK.COM (2603:10b6:a03:569::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 00:44:08 +0000
Received: from LV8P222MB1013.NAMP222.PROD.OUTLOOK.COM
 ([fe80::557b:88e0:af8b:b8d6]) by LV8P222MB1013.NAMP222.PROD.OUTLOOK.COM
 ([fe80::557b:88e0:af8b:b8d6%3]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 00:44:07 +0000
To: Akhil Veeraghanta via lttng-dev <lttng-dev@lists.lttng.org>
Thread-Topic: workqueue tracing symbols
Thread-Index: AQHbCJmJJtTYZ7az70SAe2QGp7QRxQ==
Date: Tue, 17 Sep 2024 00:44:07 +0000
Message-ID: <LV8P222MB1013B292A6263022FF86BCB0E5612@LV8P222MB1013.NAMP222.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8P222MB1013:EE_|SJ2P222MB0969:EE_
x-ms-office365-filtering-correlation-id: 74ddf47c-1216-4f94-b930-08dcd6b1d696
x-microsoft-antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|8060799006|19110799003|461199028|15030799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info: VZpTYq/KaLv2xBjLjsYxHniRR89PtppkiG2QWVkzKDRnOEI2obcRi3E9Fk4WsMhbcVh4K456jgLJXulSVLo8vWL9LFQrCsTcuJN5G9pp+W6EApPN7cZSASEyn7xruJTsNSeRAWAqeQPbcds5HzHYD4lUCIbnDJSA/3UtCFAGcTj85Z2nY6c7Eletxm6E9SwJR2pc+p3iJkApbRjE/14ch+yopK4fU40Efayn2ArZgl6XGClynorT2Pu5jLlyMBU4mMg4v80jimRlieETeysHJgk/zOn/r8GqqjuHWlWrroFAQkhBtxF0Gh4A9LiD8MzX7ETNqqldc1dbh7/j7GWZZ52E4puQFPf/U/NeamrFDRA8C15dxFDmhUC/G2UEtbKeUosDrwLZcJS4GPYjYqElwYJxAdAz9Su9Ee9QZPEqVigNFMzIyRqaFtLguV0jQ1xmoWn7d05g+DHmZgO3W1TNzsI9AW0fJfk0p5ihZFWPkVmvxermhNGrs1irMWeOm8TRAc1Tm6jye8yN6DvETSwItVtX+b8zMbN660H2deJGKH3WfFHqOJhErXzYE/vgteVmPA8939cbUmSFtuKUSiuqOvOAyg3PCq3tBQNtmu6e5MU2vHLuzXfhwvxO1Kb5qDxflQNjeHNNLsuZF4PeWSTs+Vf0f4F24PlRv2B1Zd7wmraLdhlCT8H4fAboCsJwK3axwbrShlEl1Q6WsD8As3I4f9ddhck7YY9iXWRLFwOJJkbbmTXqMkHR2xj0OBnz3MFo
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S85u/XAWhRtvxY/5FrB525+z/RwhYiOCcd7G8HjODp9ISXJ93Ha/Ep4LC5?=
 =?iso-8859-1?Q?Oc1DsoY+P+lr3NWAjIjgOW8Gma7wsbNN3cmBAZLmtu50fzHhDqx+9Qfu9W?=
 =?iso-8859-1?Q?FHboAmjY/8X0sb6Zac9g+3xYulhDf/0AZuXx74KbjwYS1cKjYAFDfRCV5T?=
 =?iso-8859-1?Q?xe8z3NHiZtoZGXiknaxmE+K5E9kFX/4YHsDFPF7WphPHfGxHcPr+LDCC57?=
 =?iso-8859-1?Q?biQG378fUt32aN2S5cnFxyNxZeHMrIv+6j7nwhZYftOcNlkiWavpaf6eh2?=
 =?iso-8859-1?Q?WTl1LIuWWnOROq7mw9UrUsoJHHVFFyfJ2Uim+ew7MOZz8i9Kv8OU/2Fumo?=
 =?iso-8859-1?Q?8/ElI0k406MFfbdbk0dozQo8FgnrUfoAT9X+ZpuibgWE+pTuSdIVxTfdUl?=
 =?iso-8859-1?Q?N8fhUlYS0WiDWUHFRVCogYvMc6rGpW6PPu3dJcEhCc37C7cnRO+X+DtXuY?=
 =?iso-8859-1?Q?2BhcVhPTdZS+OInchxrq/MM7tghPD/xhufo30s431NZkd+2VG2jIpTFvl8?=
 =?iso-8859-1?Q?HWWwA+O5Ik8ucw1I/dozP/HmZ8Geu1+p77kVlrxs+fDE8hA0gwg7Q1r+m3?=
 =?iso-8859-1?Q?LH1C8ZhF5no6gsHtIW5tU3ktYTT9VY1Ty7gA1nv5BT23fJ7vY6a2G7TUv5?=
 =?iso-8859-1?Q?3FEjLu+vzVUYVaOKCollk+3fNanqaYiGODNi0J+aIInuk5Y7RZvs6eimNj?=
 =?iso-8859-1?Q?4PgURHa2rc+N8OTYavdqQOVbWaBWrpnuUqkJ2jyZCWU1YetyjBdLLUPK7g?=
 =?iso-8859-1?Q?IXV1oklRgJln/nOZLI/vrb5CWraBUdqHt1/mrtGk8h7UsMstdjDTFRBaSD?=
 =?iso-8859-1?Q?w+vsOKLrk+8WmPFspXyhu9IH7dTn0KtL+dRG/KGyl0Hug2Lz5wqYa59hSQ?=
 =?iso-8859-1?Q?XtOlW6fyi5ykneXST0kvhtvSv6+HUI+zWUjcO9lO9/J8uVyq/0rnVZm17j?=
 =?iso-8859-1?Q?mYEf0g1c+9ul0q2JlitpRRPCZ2ID7YTzF5G+Te02hds33buKh8R+UtWe0i?=
 =?iso-8859-1?Q?Ow3GMajngRHGQBKGCb6J5a9QhxdQ9sCcPlPpKwtCMSH2WorQGHgpaJX1hQ?=
 =?iso-8859-1?Q?I+4cFI0r4MAXDRozGvaLDBe7kAWfM1YUdOP/rKW6Lf6J2q1l3Bf1eOI8FJ?=
 =?iso-8859-1?Q?En9tMHRX1qnAV2gN2lx8QMKptL0sZsvgIAGK7u39oAOpRX9m2v0C43m8RB?=
 =?iso-8859-1?Q?vkeMf0XazfsdWb4f5Zx+XcJRs7Kcnr6ZIWzDSYAL4aRBhxedf3j9VCBbFa?=
 =?iso-8859-1?Q?sn26rgEl2x+UIHGyEsuTBYHKUrn701iwtqDzIdQq+VLM7vguJjax8JyMkO?=
 =?iso-8859-1?Q?QAMw?=
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8P222MB1013.NAMP222.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ddf47c-1216-4f94-b930-08dcd6b1d696
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 00:44:07.6948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P222MB0969
Subject: [lttng-dev] workqueue tracing symbols
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
From: Akhil Veeraghanta via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Akhil Veeraghanta <akhil.veeraghanta@outlook.com>
Content-Type: multipart/mixed; boundary="===============0006636197446842468=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0006636197446842468==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_LV8P222MB1013B292A6263022FF86BCB0E5612LV8P222MB1013NAMP_"

--_000_LV8P222MB1013B292A6263022FF86BCB0E5612LV8P222MB1013NAMP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

We are trying to debug kernel work queue related issues in our system. And =
as such, we've turned on workqueue_queue_work, workqueue_active_work, workq=
ueue_execute_start, workqueue_execute_end.

The tracepoint itself stores the function pointer which we can look up from=
 /proc/kallsyms manually.

We've been struggling to do this automatically, we've tried:


  1.
Using babeltrace2 to "convert" from lttng to lttng by just editing the even=
ts in place. This doesn't work (atleast as easily) because the event iterat=
or is const.

  2.
Loading the kallsyms file with "Configure Symbols" in trace compass doesn't=
 work either because it doesn't know that it can look up functions in workq=
ueue events from that file.

Converting to a text based format like chrome trace and replacing the field=
s works, but then we have to use chrome::tracing which isn't as powerful.

Before we go any futher modifying trace compass or writing a smarter parser=
, is there a way we can trace the workqueues and do the lookup properly?

  3.


--_000_LV8P222MB1013B292A6263022FF86BCB0E5612LV8P222MB1013NAMP_
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
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hello,<br>
<br>
We are trying to debug kernel work queue related issues in our system. And =
as such, we've turned on workqueue_queue_work, workqueue_active_work, workq=
ueue_execute_start, workqueue_execute_end.<br>
<br>
The tracepoint itself stores the function pointer which we can look up from=
 /proc/kallsyms manually.<br>
<br>
We've been struggling to do this automatically, we've tried:<br>
<br>
</div>
<ol start=3D"1" data-editing-info=3D"{&quot;orderedStyleType&quot;:1,&quot;=
unorderedStyleType&quot;:1}" style=3D"margin-top: 0px; margin-bottom: 0px; =
list-style-type: decimal;">
<li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0);">
<div class=3D"elementToProof">Using babeltrace2 to &quot;convert&quot; from=
 lttng to lttng by just editing the events in place. This doesn't work (atl=
east as easily) because the event iterator is const.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<div class=3D"elementToProof"><br>
</div>
</div>
</li><li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof">Loading the kallsyms file with &quot;Configur=
e Symbols&quot; in trace compass doesn't work either because it doesn't kno=
w that it can look up functions in workqueue events from that file.<br>
<br>
Converting to a text based format like chrome trace and replacing the field=
s works, but then we have to use chrome::tracing which isn't as powerful.<b=
r>
<br>
Before we go any futher modifying trace compass or writing a smarter parser=
, is there a way we can trace the workqueues and do the lookup properly?<br=
>
<br>
</div>
</li><li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof"><br>
</div>
</li></ol>
</body>
</html>

--_000_LV8P222MB1013B292A6263022FF86BCB0E5612LV8P222MB1013NAMP_--

--===============0006636197446842468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0006636197446842468==--
