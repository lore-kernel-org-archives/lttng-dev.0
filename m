Return-Path: <SRS0=G+Hn=D4=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015C9C388F9
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Oct 2020 14:00:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849A521481
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Oct 2020 14:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="dWqHxYkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849A521481
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CGXFP24Gqz15Lm;
	Wed, 21 Oct 2020 10:00:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1603288826;
	bh=hkXvS76snkgazPT3IFqgjxLmPluy2KuNNjcUTd8F6cY=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=dWqHxYkVuItYQle1FYaPs1mw7xjs8Fli8D0carTOR0NIhX98yIW2El6dPvyOPGMiV
	 c2GyzgzT7X8qXsiYVyOfz+qNVGX5yk68DM9uljtfK1b4lW6vN7S/yf8MMjuQwY4S1R
	 JUbn1w5u+ZH6lTgVwxYrilxcEGQuYJYqpoP8NGo0jf9+dTH8gaNmU+nm+y8fLkK8m5
	 aoCv+dDJIRBOP3EGx9dyl4nBNWWQi4Wq7nrykSx4kmCMLf983sAh0JofBXQuEIeqiG
	 aLnbnTvfGIIw9UAlgPDR6ujBwd2Weo9uIHJl207ua2S1iiqFJQ8RTZje3jpkYJs3Oq
	 U2g+latIHqSqA==
Received: from mailrelay.anl.gov (mailrelay.anl.gov [130.202.101.22])
 by lists.lttng.org (Postfix) with ESMTPS id 4CG8cB6WmCz158b
 for <lttng-dev@lists.lttng.org>; Tue, 20 Oct 2020 19:15:22 -0400 (EDT)
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTPS id 3739A1005A14
 for <lttng-dev@lists.lttng.org>; Tue, 20 Oct 2020 18:15:16 -0500 (CDT)
IronPort-SDR: IdQ+xXl57T6DBVMhiEz667pVy1pQu5wj6SQxyk+EWlERaLe9sBrODMEbp5EMAv8c1wsg3p5Zp+
 oaKBt0ysKUXnN61sAqFgw2orcFrUgPGUcw8LRP5p7fKY1+GD/c8ZhsQQ5F920iv9mpXFpk67U2
 F9BRGJuuWYI6QRlT0L+iIBCoVTaGOVJmwL6PUR509AdCtB6Fkt07nRStrcLihXLxBYeGFx1Tzm
 5LzRfR4pfPo8Bcy5wzKOxJnzY79vZEvZdAH/GJ3JfBTy8ioZt6tYENSEaSXy8BiprS15o8qnt5
 G04=
X-IronPort-AV: E=Sophos;i="5.77,399,1596517200"; 
 d="scan'208,217";a="119341346"
Received: from eskimodog.anl.gov ([146.137.81.13])
 by mailgateway.anl.gov with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 20 Oct 2020 18:15:16 -0500
Received: from eskimodog.anl.gov (146.137.81.13) by eskimodog.anl.gov
 (146.137.81.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Oct
 2020 18:15:15 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (104.47.64.109)
 by hybridexchange.anl.gov (146.137.81.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 20 Oct 2020 18:15:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGJrI/0XF1qo1/jJiNIKB+nua/nZSyStNnGbBIxQio2MgfvJ3JHv8ZojhQajYA6Y2nmfXFrGdhPXp2rGVuMRzr7e9NLc4m5Yh3daduEkEsFdfgB+sy+mU61JVPXK5mkzDrkLXqEbcPyNOnaItfcxkgvi+ErfrPnlTFTsWSJFQdAnabC8pkCwY4j8vJNBmIha97cn9y+F0PD9KRI3FmZf5cMTSka/BXJwS5ngHuZKdskppSf98/CB8KOo1Jmu7OvTtaGg11H0M1Jk/uKzJxUZ/wIxzOUlZ/XZqEgJec7tk0m173tqoMbljLvVLusCIzKxbb7QKUmSn65xeexnF68wXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05YeLbvjWrSP+38VOjTO7Lz6HVJBUawnLfLMv6p4lzE=;
 b=enBTjHQ3MroUFZFwalkjEII3auFBmYE2qOPwE5lTsJxj/o4IoHrwi8M+3t9lPNhl+Wt9lthlTemySzsz4vqQfWucMl4/GrBDzyFlB1jGimSS8Fkkk038KNXwW08n0IPgzhRxspw7pUrx5am88wdVV5DHmfWXP9z5FAtcXzdcXz0cx/wQiIzuV27judWdqPeTyXTvzkEwH1wlzg5Y7lAOa9i/+zsfjX50nYYXO+TlsY3CIOyZaZBzUy0NliW+Cwvq56JOgexWtHMtHHsIszk1eX8+2iNOpZTiQa4HlRRiBSHY2LTpGOLEOXYMxHcZjsQYz2BDDseJWoPin8y14ieJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=anl.gov; dmarc=pass action=none header.from=anl.gov; dkim=pass
 header.d=anl.gov; arc=none
Received: from SA9PR09MB5725.namprd09.prod.outlook.com (2603:10b6:806:47::24)
 by SA9PR09MB5823.namprd09.prod.outlook.com (2603:10b6:806:48::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 20 Oct
 2020 23:15:12 +0000
Received: from SA9PR09MB5725.namprd09.prod.outlook.com
 ([fe80::6d00:3e06:875a:9952]) by SA9PR09MB5725.namprd09.prod.outlook.com
 ([fe80::6d00:3e06:875a:9952%6]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 23:15:12 +0000
To: Michael Jeanson <mjeanson@efficios.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] lttng-tool for configure for `liburcu` doesn't use
 PKG_CONFIG
Thread-Index: AQHWpmX1CLG67E+ETUuLkTMh9IIIwqmgmPNhgACF9Ao=
Date: Tue, 20 Oct 2020 23:15:12 +0000
Message-ID: <SA9PR09MB57256409CDC88BC617D5C8C2C41F0@SA9PR09MB5725.namprd09.prod.outlook.com>
References: <SA9PR09MB57258DA2DB866F09A1950BBAC41E0@SA9PR09MB5725.namprd09.prod.outlook.com>
 <e217db77-248a-d598-e906-3091e04a0863@efficios.com>,
 <255b71b0-fb0f-5548-e96b-b16c9f6662ed@efficios.com>
In-Reply-To: <255b71b0-fb0f-5548-e96b-b16c9f6662ed@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.75.236.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f328ae99-cee2-4b02-f124-08d8754dff3b
x-ms-traffictypediagnostic: SA9PR09MB5823:
x-microsoft-antispam-prvs: <SA9PR09MB5823A8B31B161F89228B6BD7C41F0@SA9PR09MB5823.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XjWE4/cdfb/P/NhHOpq5WaQh7piyFVw6XjXJm+GBLP7UJVPS9NMFrb0C2ByVtD6MIURDUgdgsLB2+0OT4L2+DjZM2avUUR1SQyfetDaNQ9cg9giBzUumpzpBYHmzxvJ2kpjjJClQa1DlErH3tXqh4hA0aVXiH3cru6hv/h0lrnsmlObIt0J3w4UtN66mIlL2YAYuYG6b3Gpa21l1NqnQtzgJG3ILNztf4Rf+HvfN8c8KnzmG/M03ngcYORbP3vDC/9HIBcad7XHWNigf4hP9rlRCk5HQHXKyM67cOAjwzVEVhVvsJBfVhwkyu9QRv85vAdQVCvqsCnf4M6JUIqqIVgfdkkGm64BS9RQQf3pP9c1t0DprJ1UHqpupfAjEpH154kyQFQyQozsVzSkaZ2x5MEvFiCYTzozdVWCMNlUTUiKKgPGHvSWjGe5zNiDIGEBq4X4//vS9/XC9VJc+eJa7OA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA9PR09MB5725.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39850400004)(396003)(366004)(136003)(66946007)(66556008)(76116006)(91956017)(66476007)(64756008)(110136005)(19627405001)(52536014)(5660300002)(55016002)(86362001)(316002)(66446008)(478600001)(166002)(186003)(10130500003)(4001150100001)(9686003)(7696005)(33656002)(8936002)(53546011)(6506007)(8676002)(71200400001)(2906002)(26005)(81973001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: pvj2sW9aEoiKAEUuWGuGG+Bv1fu1owfxWZ8JjK1z/kWjoSHPQeR4cUmrKOmiW42XNzP6z7A+2LuOUrFoH2mmpiytX4oeodV0d/NnjL9BxaKaIeyVWwGS7QSBN+sqs0LMbVmDK+K71GN3FxIGDe0dHlpTZaadrfvuHPNgvV1mBzBAYVyKhbxmk2keFcxxTujrg4FXXNRvCP5oTDP+DQtauD5nTOYfkifAqkHNrEpijNehkbqtS6q3/H423Qm5XQ2LDQiWa1pBlkURpjf5/vbevas2nOCRNUitw7+TEOJHS5ZVD+22dJ8nah/2lSoQFypfv2cauhmdnuE4OBQgAiqIKDw+7jMi9NoHW8+Fa4EY0uMtB0Ce9H0eY/tNFV9asjUj4LLbUGSDg9NZjkKbZl9Nt4FRpdjl9rsfh9j5z7JtWzmX4HtkpHlfNeG2zWixw7Jfnlr46d+ZBf0WSGnRk9Pupy9h0yvyPEMVVdyeMd8JTpt/mw+Jpk+bzKfuZvwFihMs3FCSAJ2HnmdKepWq3c4094vHy5+QRPYXvPzxD+/ok5oyrTRS8U68umn+U6eFNb+NZ9UTwanvo73utlxzL9kgfnHOAMH6nzpCBjhdJibpljY2g/miNCsEn6M45nlxj6yj7v3kP2kdN0KtIpoRcSoQEA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA9PR09MB5725.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f328ae99-cee2-4b02-f124-08d8754dff3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 23:15:12.6392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0cfca185-25f7-49e3-8ae7-704d5326e285
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7JuuH05Z6ZnAoH7S3n/X1Muicj9ecXMyXro88KBgGK3cV3tVjJ9BlQUUxSHdpQrudR2vIf/8wIOWV4qCyFNKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR09MB5823
X-Mailman-Approved-At: Wed, 21 Oct 2020 10:00:23 -0400
Subject: Re: [lttng-dev] lttng-tool for configure for `liburcu` doesn't use
 PKG_CONFIG
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Applencourt, Thomas via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Applencourt, Thomas" <tapplencourt@anl.gov>
Content-Type: multipart/mixed; boundary="===============0603845924591020748=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0603845924591020748==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SA9PR09MB57256409CDC88BC617D5C8C2C41F0SA9PR09MB5725namp_"

--_000_SA9PR09MB57256409CDC88BC617D5C8C2C41F0SA9PR09MB5725namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick reply!

> lttng-tools,
I used `lttng-tools-latest-2.12.tar.bz2`.  It looks like the main configure=
.ac (https://github.com/lttng/lttng-tools/blob/master/configure.ac) don't c=
heck for PKG_CHECK_MODULES either when looking at lurcu-cds.




Thomas Applencourt
Leadership Computing Facility
Argonne National Laboratory
Building 240 Office - 1.D.18
9700 S Cass Av., Lemont Il, 60439
(630) 252-0036
________________________________
From: Michael Jeanson <mjeanson@efficios.com>
Sent: Tuesday, October 20, 2020 10:07
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>; Applencourt, Tho=
mas <tapplencourt@anl.gov>
Subject: Re: [lttng-dev] lttng-tool for configure for `liburcu` doesn't use=
 PKG_CONFIG

On 2020-10-20 11 h 01, Michael Jeanson via lttng-dev wrote:
> On 2020-10-19 18 h 22, Applencourt, Thomas via lttng-dev wrote:
>> Hi,
>>
>> When having `lurcu-cds` in the PKG_CONFIG_PATH but not in the
>> LD_LIBRARY or CPATH it's not picket up by the configure script.
>>
>> Regards,
>> Thomas
>
> For which version of babeltrace? From git or a release tarball?

I meant lttng-tools, not babeltrace.

--_000_SA9PR09MB57256409CDC88BC617D5C8C2C41F0SA9PR09MB5725namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Thanks for the quick reply!<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
&gt;<font size=3D"2"><span style=3D"font-size:11pt"> lttng-tools,</span></f=
ont><br>
</div>
<div>I used `lttng-tools-latest-2.12.tar.bz2`.&nbsp; It looks like the main=
 configure.ac (<a href=3D"https://github.com/lttng/lttng-tools/blob/master/=
configure.ac" id=3D"LPlnk">https://github.com/lttng/lttng-tools/blob/master=
/configure.ac</a>) don't check for PKG_CHECK_MODULES
 either when looking at lurcu-cds. <br>
</div>
<div><br>
</div>
<div><br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
<div><br>
<div id=3D"Signature">
<div>
<meta content=3D"text/html; charset=3DUTF-8">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif;">
<div style=3D"font-family:Tahoma; font-size:13px"><font face=3D"Courier New=
"><span style=3D"font-size:13.333333015441895px">Thomas Applencourt</span><=
br style=3D"font-size:13.333333015441895px">
<span style=3D"font-size:13.333333015441895px">Leadership Computing Facilit=
y</span><br style=3D"font-size:13.333333015441895px">
<span style=3D"font-size:13.333333015441895px">Argonne National Laboratory<=
/span><br style=3D"font-size:13.333333015441895px">
<span style=3D"font-size:13.333333015441895px">Building 240 Office - 1.D.18=
</span><br style=3D"font-size:13.333333015441895px">
<span style=3D"font-size:13.333333015441895px">9700 S Cass Av., Lemont Il, =
60439</span><br style=3D"font-size:13.333333015441895px">
<span style=3D"font-size:13.333333015441895px">(630) 252-0036</span></font>=
</div>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Michael Jeanson &lt;m=
jeanson@efficios.com&gt;<br>
<b>Sent:</b> Tuesday, October 20, 2020 10:07<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;; App=
lencourt, Thomas &lt;tapplencourt@anl.gov&gt;<br>
<b>Subject:</b> Re: [lttng-dev] lttng-tool for configure for `liburcu` does=
n't use PKG_CONFIG</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2020-10-20 11 h 01, Michael Jeanson via lttng-d=
ev wrote:<br>
&gt; On 2020-10-19 18 h 22, Applencourt, Thomas via lttng-dev wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; When having `lurcu-cds` in the PKG_CONFIG_PATH but not in the <br>
&gt;&gt; LD_LIBRARY or CPATH it's not picket up by the configure script.<br=
>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Thomas<br>
&gt; <br>
&gt; For which version of babeltrace? From git or a release tarball?<br>
<br>
I meant lttng-tools, not babeltrace.<br>
</div>
</span></font></div>
</body>
</html>

--_000_SA9PR09MB57256409CDC88BC617D5C8C2C41F0SA9PR09MB5725namp_--

--===============0603845924591020748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0603845924591020748==--
