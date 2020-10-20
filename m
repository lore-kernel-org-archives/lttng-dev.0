Return-Path: <SRS0=G+Hn=D4=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FFC56202
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Oct 2020 14:00:33 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A7321481
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Oct 2020 14:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="nEZq+ipx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A7321481
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CGXFW0bN5z15RP;
	Wed, 21 Oct 2020 10:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1603288831;
	bh=b9J3kJUXb1oLvyFfrsr+Tz74s8UETOSbzC0HzhcrHFY=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=nEZq+ipx/e84i6EajXV6ZJuWbJtPX/+1bjyJRKVajC+/NkLJ5CdQChtcZeVja94LD
	 BOw9VsbnHw+OUP9T6i/82ITVPINWx0Q/DZD+ylVYlizPiM+2cvPjJO81DB3hFfadRK
	 he+yHThDCmgAjvlFWozFa/Mmw+OlJ0iNETkxUeobUeKHB++TMWPYHDMXCL+HP+oXfT
	 ibkh7AaHyOJtFL5whYFId4pdklVl7rvFfCEa6wv2xI9IwKoMjrANIY2JXDOYTiC3tf
	 50yuIkMVZ8lcoMxfJXy42abKsdcXrXxt3/zQm+c20hm7AhvH9xrDIo+KujUSYw1+f+
	 Ab0lBQWR10Npg==
Received: from mailrelay.anl.gov (mailrelay.anl.gov [130.202.101.22])
 by lists.lttng.org (Postfix) with ESMTPS id 4CG8fC4cnJz1560
 for <lttng-dev@lists.lttng.org>; Tue, 20 Oct 2020 19:17:07 -0400 (EDT)
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTPS id 1BF9810060E0
 for <lttng-dev@lists.lttng.org>; Tue, 20 Oct 2020 18:17:01 -0500 (CDT)
IronPort-SDR: QfDlt1yYP3p9z4FrUdGixlRke/XQ83RqIoliMWpLYDM3cb5wDd9qn4l6+ZEUm0xGhSwRyh9QdR
 5JPZt0WTqkxAPKuRnstzjaEWHts/yjoNB61WsjR5Hz9lbvoo7xD/XzC+UTnSSs2jL+vnN/XFWZ
 9q0oXCJxK6pofA//2stEbWScgs8uP6QIIrbcjwQ5f9vh9MAXTFe5SFYMAuYNlI4ikafXMsrjup
 4SzDoPthmsbNDSEO1nGQIvQD84N00/6vL69my/lqKTm1Io04nApF8RMGQvhe7g3H6hcozeoHv+
 cbo=
X-IronPort-AV: E=Sophos;i="5.77,399,1596517200"; 
 d="scan'208,217";a="119341473"
Received: from camel.anl.gov ([146.137.81.12])
 by mailgateway.anl.gov with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 20 Oct 2020 18:17:01 -0500
Received: from eskimodog.anl.gov (146.137.81.13) by Camel.anl.gov
 (146.137.81.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Oct
 2020 18:17:00 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (104.47.64.107)
 by hybridexchange.anl.gov (146.137.81.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 20 Oct 2020 18:17:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eciwKxXxXPCty+qvBJ8M7gKI5dEVwLEriG+9qDUvI89k39BJwbMGU9mUUnN2m1gfA4QGYgHTdsIqEkVhj3+XIEoBRuJbLdrBJh9C7w/PDPkyh5TKfE9IpaxclkjewlHSrDi1WZ4f0jyNNiSXGDK/WP1sV3UMd1Q01RkJLTE0IfXAFGFGx3MBtth3plXrW6PjPrq7aV6RqJiU/rtINQ9oS41wjnwrkrcRmBT1qWld6oZXFsEhdiHTjrj5PR3mO4/FjcfCj8BUv0B6TXz3WzM3XZuyvlFHopblmNAVeNihxOG2NC0mRDSS//cSu5J0dqk12qXmzdRtUhp1mKO2v0kp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zttBh4RgKURFW3/fEMNM3+gUUOhe5IB79+E3PRXckWg=;
 b=e7tOBQG8MzgeD1fuFozhOwBWj8Ec2yhZWQtyZmdk5dZeU4zRxcNJubzJwGVCNBSErK21UtMM/Ap+qFEFn0YU66ODKCZhHMADcz8vVZrlmBuRS16IwKKWA10MZRSU5XkJY3MXAKM2ZMp2Hz0FwT5C+y9Stjfkd0nO12CRgplH6IHRBrzXZ7mzSiF2JiMSjaIVbP8lWdckBkxzh+XyhYROxGFuFquQvbAKLIbjer7zoR1gNfjA/qRWSDgjnMdkyNGdpXKtvfnDEpq0WjFjL9KRHe2genUO0duBuLoFGcwLAvnG+F6tm6S89CRXaZlC52O3OKR4Qy9tPmCcCdSbnmtI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=anl.gov; dmarc=pass action=none header.from=anl.gov; dkim=pass
 header.d=anl.gov; arc=none
Received: from SA9PR09MB5725.namprd09.prod.outlook.com (2603:10b6:806:47::24)
 by SA0PR09MB6411.namprd09.prod.outlook.com (2603:10b6:806:a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Tue, 20 Oct
 2020 23:16:58 +0000
Received: from SA9PR09MB5725.namprd09.prod.outlook.com
 ([fe80::6d00:3e06:875a:9952]) by SA9PR09MB5725.namprd09.prod.outlook.com
 ([fe80::6d00:3e06:875a:9952%6]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 23:16:58 +0000
To: Michael Jeanson <mjeanson@efficios.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] lttng-tool for configure for `liburcu` doesn't use
 PKG_CONFIG
Thread-Index: AQHWpmX1CLG67E+ETUuLkTMh9IIIwqmgmPNhgACF9AqAAAJmcg==
Date: Tue, 20 Oct 2020 23:16:58 +0000
Message-ID: <SA9PR09MB5725EE9DD44073D9561D5A18C41F0@SA9PR09MB5725.namprd09.prod.outlook.com>
References: <SA9PR09MB57258DA2DB866F09A1950BBAC41E0@SA9PR09MB5725.namprd09.prod.outlook.com>
 <e217db77-248a-d598-e906-3091e04a0863@efficios.com>,
 <255b71b0-fb0f-5548-e96b-b16c9f6662ed@efficios.com>,
 <SA9PR09MB57256409CDC88BC617D5C8C2C41F0@SA9PR09MB5725.namprd09.prod.outlook.com>
In-Reply-To: <SA9PR09MB57256409CDC88BC617D5C8C2C41F0@SA9PR09MB5725.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.75.236.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9942fa83-60b2-4024-ab60-08d8754e3e7c
x-ms-traffictypediagnostic: SA0PR09MB6411:
x-microsoft-antispam-prvs: <SA0PR09MB6411A575F0384B7184CD8BD3C41F0@SA0PR09MB6411.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sxSF0DdFnoQAvog8PaT/KUtSNc9IJNhcSk/keD4ZYzOPLSgWMoAPat7uBiYBUBw3jwCZR/v02C1AjFReF6bRp6LPFbQZ3Sk+ohJjh6x+PjUrDHtn2HnCe0wtNo1UWi+UTIF8+cM1gGIzoWhlIvxsdKuOKAaUDF1e6VWMKtMi5QGjHYLl9WVYMbQ6QWHFKLwDPfq6q6yXXrDaGxfB7zsk8IINbTsnMbKNOwhYQOsQRZ6dwBKSGO933Rb9H9mtbdazkFzgySjCGWV08e/pTGeTv8161dPz60wIw941sXPjIOCR4xfs5Z4YCELn4P7MZA/uBDgJnBu5fqV+itfsSR57fr42rV0sVoEHUj50lMBV4Tf7KTgnZGH92Kb1Sf6xAa5Ovd6mSkoPK4n60/9mX5V+ATDX8kPtx4p3m6sE6RA/D9B0f3SsFmfO8yFZLdiMkN/q7LzIoo3bh9F+LGLmn+SnCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA9PR09MB5725.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(396003)(39850400004)(366004)(136003)(2906002)(166002)(186003)(7696005)(33656002)(6506007)(478600001)(53546011)(2940100002)(316002)(9686003)(26005)(55016002)(91956017)(76116006)(66946007)(19627405001)(66556008)(64756008)(66446008)(52536014)(66476007)(5660300002)(86362001)(110136005)(4001150100001)(71200400001)(10130500003)(8936002)(8676002)(81973001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 6QffFgtT3w0FesIk40a6BURKeYaG9OHXClS6FI2AXL9s1guR+4ze2ortzcVCFfXbXIhgWK1nDcitfxEsZw82LcNEUOxs+wki8l1QvRVByrkHaSXeS8E++nCp1dtSL/shIztpY4+qLgg/TURpghzYua+Sf6w773vPMzqtHM/TVdpStGWlajbao7nph3szlIvHyr2diu+96moj0Ytm33w51PQG5+a6tT9XITkcg2o5oGPXfw1dYZY0smrIo4xIR9Lho7V+s6mT+aGWpESpQtIG+FbWuC2LtX5VQTV8m2yFc/o+3TFb7kMAlvQ0xp7KFBqadBay+yAnlQv+Vx7koL+ivODE1PqTqve6UNbSi/nkKnisUna+6fnnyiP3uTqUa02CU0jefYoMglpz1aM48OifYoOWWJeGUqhWejKqfQulM/SP4CmEpQL9bE3eOTMG3r1SG0XVzn8nH3i6XmWYZiRtonI+QzQRtRdv8yhO5lHggbm/mkr8oUBT2b/be6P56Dctmt6fZ99Lut3fkPcOnv4Dsa43gb9qYeDbG2d828TNm5jkcVjUqATmweMV0kLvpB34VRrsuRbfTsR24CFuEgTGJfF55P4q4pMpx/eiY0tnu67vUXTwRTwTvhQ+s8HSN4w9sm8LIuIaCQE8Ms8oHJRWrQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA9PR09MB5725.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9942fa83-60b2-4024-ab60-08d8754e3e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 23:16:58.7718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0cfca185-25f7-49e3-8ae7-704d5326e285
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMuvC4Jhtfoeol+plgzD/QyyN+96aahykTFkPlQNI1eYwCHie+jIZlLaXvlFhagPpu3zryvUpZhmOhSc9b+LaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR09MB6411
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
Content-Type: multipart/mixed; boundary="===============7439768817384707802=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7439768817384707802==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SA9PR09MB5725EE9DD44073D9561D5A18C41F0SA9PR09MB5725namp_"

--_000_SA9PR09MB5725EE9DD44073D9561D5A18C41F0SA9PR09MB5725namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I just saw the fixe (https://bugs.lttng.org/projects/lttng-ust/repository/l=
ttng-ust/revisions/ff1ee9bccaa84dd4b062387989c107eb1dafc136/diff),

Thanks a lot!

Thomas Applencourt
Leadership Computing Facility
Argonne National Laboratory
Building 240 Office - 1.D.18
9700 S Cass Av., Lemont Il, 60439
(630) 252-0036
________________________________
From: Applencourt, Thomas <tapplencourt@anl.gov>
Sent: Tuesday, October 20, 2020 18:15
To: Michael Jeanson <mjeanson@efficios.com>; lttng-dev@lists.lttng.org <ltt=
ng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] lttng-tool for configure for `liburcu` doesn't use=
 PKG_CONFIG

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

--_000_SA9PR09MB5725EE9DD44073D9561D5A18C41F0SA9PR09MB5725namp_
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
I just saw the fixe (<a href=3D"https://bugs.lttng.org/projects/lttng-ust/r=
epository/lttng-ust/revisions/ff1ee9bccaa84dd4b062387989c107eb1dafc136/diff=
" id=3D"LPlnk">https://bugs.lttng.org/projects/lttng-ust/repository/lttng-u=
st/revisions/ff1ee9bccaa84dd4b062387989c107eb1dafc136/diff</a>),</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
Thanks a lot!<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Applencourt, Thomas &=
lt;tapplencourt@anl.gov&gt;<br>
<b>Sent:</b> Tuesday, October 20, 2020 18:15<br>
<b>To:</b> Michael Jeanson &lt;mjeanson@efficios.com&gt;; lttng-dev@lists.l=
ttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> Re: [lttng-dev] lttng-tool for configure for `liburcu` does=
n't use PKG_CONFIG</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
Thanks for the quick reply!<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
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
<div class=3D"x__Entity x__EType_OWALinkPreview x__EId_OWALinkPreview x__ER=
eadonly_1">
</div>
<br>
<div><br>
<div id=3D"x_Signature">
<div>
<meta content=3D"text/html; charset=3DUTF-8">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif">
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
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Michael Jeanson &lt=
;mjeanson@efficios.com&gt;<br>
<b>Sent:</b> Tuesday, October 20, 2020 10:07<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;; App=
lencourt, Thomas &lt;tapplencourt@anl.gov&gt;<br>
<b>Subject:</b> Re: [lttng-dev] lttng-tool for configure for `liburcu` does=
n't use PKG_CONFIG</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On 2020-10-20 11 h 01, Michael Jeanson via lttng=
-dev wrote:<br>
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
</div>
</body>
</html>

--_000_SA9PR09MB5725EE9DD44073D9561D5A18C41F0SA9PR09MB5725namp_--

--===============7439768817384707802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7439768817384707802==--
