Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D71C3DA66
	for <lttng-dev@archiver.kernel.org>; Wed, 23 Aug 2023 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692811803;
	bh=RuFDtfLPklklBjMDPQgWY1GRmtVnB/s9UOES4etAAmU=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ARNyzNyeSt8hJXFD7yQ0atk5m7KKB39ciCt0VhiQ/spTNT1gc3K/zq0D4Y4u0VYZq
	 DiuDpPb5p+lqLzb7zc3HIRUicZEdWIR01HsEGlaO34AGWTa4wpvNydwlpmTS2iz/QV
	 JdqiUcuKvHrU6y0ThbVmNuImrHJ2HNNkYnnep3MB+37+WTHjrP5zqt9qU4WcGiUCur
	 Xrq6QOWU49U3RtknLza+TWdISSSgnfPUVB4Jku9NQnpx31Ioi8m3LCSLgJWVC8hXoF
	 1KJ6PHCGQP+jD/SBqLP4j73WeOuwiWWgZ2TyOgXIESrZsfTLRSLWDhTccUGiUjKdlp
	 mHtvb5ulBIw5g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RWCs65Gk8z2QBK;
	Wed, 23 Aug 2023 13:30:02 -0400 (EDT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by lists.lttng.org (Postfix) with ESMTPS id 4RWCs4457dz2Q31
 for <lttng-dev@lists.lttng.org>; Wed, 23 Aug 2023 13:30:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPjRsIjHJtWkL8o1P9MTqd9cWNyMOGUq17oLu4ScN68SrvlQxZJJgAC4VmPo6A47Srn1Bckr67bXMV33XD3tq+mlKFFBYrw6QM+IQCn6gs8tIWrW9dczTeto9gwJUm0tr+HsUEXjjDJJSlWf7o+LR3qwGXwwfUTcnwV3MOwth0veZM/VA0oyMUcFqS+YmPAoiRZyig5UMkXx0B8JLl4fZ5OPZjRK3ypFAeL8bIo51jPpZvHwsx4thF9YyuMKDWGWf5BXmYIMYLT/kI4tWJUJ5wE0mBGMFTZLsniT853yRkbmILm3N1OlkoBikDBJ+dha3bcNO+TZ/zaYPY63BFWf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE2qsF4qNhXuU4wGoYG1rNLfkQqX/jdkc9ZdQGr56ZU=;
 b=SGfRagmAjQGgvICqR9+ZIXlejxmlGfYGQ0X1Gvwm6G7xW/Ar/716uiOR8qccEqPjkxLmicorad/WFZ6ZUuhGMAkngD8JYgvqRMe+HIbmiEBvRRcrvWNgMCHh+ihy2QzQ/LFWHzuogdrRjz+zFUm9uk0sR62nK6Y7gKhtB1f5Ya1nm0lei4cK5aOZWi7lhnzpG/btgLDMrGQz+ZMBIepYW9ZPmJe1QykeP4QsOYQY1RsIFVhTPtPZ+7g7v9ShredgWxK/UdNKJL3u5dIEkGrNBGuq4C6yRkRpjQ0/2yh0TgZn2+1BaIpaQ53YhXurgCeXKdKb9/bruJ3uBBQo9tGhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
Received: from SA1PR15MB4401.namprd15.prod.outlook.com (2603:10b6:806:190::14)
 by PH0PR15MB5640.namprd15.prod.outlook.com (2603:10b6:510:28b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 17:14:04 +0000
Received: from SA1PR15MB4401.namprd15.prod.outlook.com
 ([fe80::cab:bf70:e554:8635]) by SA1PR15MB4401.namprd15.prod.outlook.com
 ([fe80::cab:bf70:e554:8635%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 17:14:04 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Bala Gundeboina
 <Bala.Gundeboina@kpit.com>, Matthew Khouzam <matthew.khouzam@ericsson.com>
Thread-Topic: userspace logs cpu analysis and LTTng UST Callstack
Thread-Index: AQHZ1R5JzcAa3ZMnsEaTPMWl5xdKpK/4AHkagAAfR8A=
Date: Wed, 23 Aug 2023 17:14:04 +0000
Message-ID: <SA1PR15MB4401C1D660802D563A5507609E1CA@SA1PR15MB4401.namprd15.prod.outlook.com>
References: <MA0PR01MB698794918256CD8FAFAF0005851FA@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
 <SA1PR15MB440196EFB7CC4F7B1081211F9E1CA@SA1PR15MB4401.namprd15.prod.outlook.com>
In-Reply-To: <SA1PR15MB440196EFB7CC4F7B1081211F9E1CA@SA1PR15MB4401.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB4401:EE_|PH0PR15MB5640:EE_
x-ms-office365-filtering-correlation-id: d4def6b4-1b41-45d6-b334-08dba3fc5a6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NtuSXy1yTCWhqwaLFXqtAsgcC+5AWSEK1eByVqoFhdBF/XB0GsGwNcTgmFhYRmdByEPSk3QLygrmB1QMSvey5PLdhJ1Qzl/pqyG6+VwJZmCuyao6UWLoUpVAAeOt51br3R1qu5LHObBOaGJPtvq1O9SDB8c8vdU0LvHfDKS25taTyRP+JVQvcGzx/BUH0Kfp8ZO/aB9LnLu1u9B40+wKBIZoHLnnpilHh8LGWvfTrVRU8BaErNAWqSHXt7v3SRWmoLBmERD7+seRQt7gOBh5zsSghzbwC6o9u5hOHih7XxpLEwA+0jaUTntrMRdUC+bTbBlPC9gUqVorJHgbL5JNMrjQyvjlbA2zhrx+isdnFzzE5I3TJsJ3zvIoisDdrwc5nr3B39PG6tKNoW1mTAJ12pha+eapHt0mnHB9WkwVpUJ05ypO/BJK8BfIw9AFXpQ60dPattPSJ7F+F3l7aK39MAgrK2618rNhWxP9H/yOnxKLxJHN8M4yBa7DAboFBJGqmrOFGqBRDQCeEiAGJ08/gc1464/+f/FCfKQ1ZNdn0zS44xmVrEAhBKHPV8Ek6WuZMoJZd0V07kbsosIGB0fDIB2vQiiQohIGbaOM8TEubXQlJJ8EZ2jMC3/2rANrnmzJc7HPwTdRXHZ5Sy8FLwCFwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR15MB4401.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(1690799017)(451199024)(186009)(1800799009)(15974865002)(2906002)(66574015)(38070700005)(38100700002)(6506007)(53546011)(83380400001)(5660300002)(44832011)(26005)(33656002)(52536014)(166002)(19627405001)(86362001)(7696005)(8676002)(8936002)(966005)(66556008)(316002)(66946007)(64756008)(9686003)(76116006)(66446008)(2940100002)(66476007)(110136005)(91956017)(66899024)(82960400001)(478600001)(55016003)(122000001)(71200400001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?30ZGGE06tXVbrdEc0e0bn/n3Wo8iekTKEEVFBIb2jKOzF7/cDYHnedmd+6Of?=
 =?us-ascii?Q?h11KcSCvwwUigBI4wbgsFfMJe2ALoTjRE8ifNt1JtBisGfwtMffdX5Bg18KD?=
 =?us-ascii?Q?foQHx+VMgAOpeacsFfpEQAXwf443yo2ZdP8pm+S8ikxsek6J3PCbkrc18BTa?=
 =?us-ascii?Q?fDDYAPUpL2CAVsg67E5beeGEhcoicWP5/Z7MPCtU9ah+IzNbV3hUjRT3NmvJ?=
 =?us-ascii?Q?R9077L0Myshw3aGa/Oq6G0JzA5NDcTj6AMB4VfGq2Wwk2XOHNIdHc6oRTafL?=
 =?us-ascii?Q?Hqcwjdt0qQEal7QK9vG0GdTI7RqDc1/yee1Xe5pblYgT2tZw2K+Lp683w6nv?=
 =?us-ascii?Q?O6+6VdRMmaxjumrB6WKJcqnfr1c4Nz6zkZmhNfvePpiLhkW1Qw1KY5vtdn81?=
 =?us-ascii?Q?EZHh0VALx/5Pgb1M/sL71wTnL+6xcqKwRvUEODwVWhMngb3lXlm0ZHCaDDFO?=
 =?us-ascii?Q?2UAz2utmD+0eg622YWuq+l+8OfTUIOJ1827Vtr0fQL5pnE4H0xpzsjVCbnRX?=
 =?us-ascii?Q?wbeBE86KEFF3hqaEbCobh+9rr7npMZRWXO9uXP8Nnok4HdJxKJ1AJf+CkyL+?=
 =?us-ascii?Q?cMcpYxBVw6Dg6vBnQZ1oCLCtB1U1df66EtsQKvT9qF7NM9JVM8iUihTNWHGL?=
 =?us-ascii?Q?ABsG6Gg/Jii1w64Xjn6774jkwMiqybfgNq3BDTLFDScVaTffpY3X1zcDrGWQ?=
 =?us-ascii?Q?YPL/ZHBhxCdk5UZPhmHErzlN8GBpbT/TnkiZxJvFQwdn4kkmcJY+OIp+1e8m?=
 =?us-ascii?Q?k4dfyrpyNxR1U8MPWwL5NmZOGFE564/VBYwyjmq94D2XXC0yEu+pzhaJjpOb?=
 =?us-ascii?Q?9iB/LsVR0RoIH1oJmQz+8wrEFx68T/87rW7KMMph/H+pAU9wuvrRwsnmn5BW?=
 =?us-ascii?Q?4C1E+M7NIscNHScq4/ZMNYCOTi6+BKWp+GMiVnZtGUEEPSIG8P1mpjDuePCu?=
 =?us-ascii?Q?FiEjVjO2XkAHYr7p+GJHQKm3GtHo9hBfncAfliJE6+b+2GibJqlPPKPfME1F?=
 =?us-ascii?Q?WB1JNlpGjwdlWdYrW24+MxXmzKtgFh91j9B/00pkD+VKu/L4XtaqNsFxD+pT?=
 =?us-ascii?Q?fhiC70nqMoF+rIgrUo0VpV/MmUyfnNX49Uq6wdtPAtm4lhDw+st/cHnCof5e?=
 =?us-ascii?Q?II49WVJQ0ggrXLR82Kc+pb+6Fwu0t9iHUKjRdh9qoCjTZOkl5ZtNy9V8vXRn?=
 =?us-ascii?Q?Bc0blWKW5fGz6sHTvVksA0srQPtoj8IGe0hEcM+yqWu2sHdOh1t41J3s428F?=
 =?us-ascii?Q?EWq7HNFj3tpQfIAVtq7l+AfPJWcARZ8X8TznnqZfde6Z7l6h/e5K5kVCz4sY?=
 =?us-ascii?Q?/oGb/mYzP3zqYS8no2mQDxg3RYd3ZK/Hy/Qmj5hZSLw9hcwDDj4DdT/ivdvJ?=
 =?us-ascii?Q?5AJPu3LeX5uX36hk03ebBRbWXkmH1Cb0UJ/rLpNS+kf6WHpsTI2ngppqsjB1?=
 =?us-ascii?Q?shsWkKvVouQU/iQrCR4+WVuPAW/P20XsRqM6m8TnOEI9Oz0b8fc/0XOwYcHJ?=
 =?us-ascii?Q?WtunqcYXdr9R9gNQ2g9z44fAKZoldnDLZuj+Hp0gGmZY8lcjCZsJRBwf5CrA?=
 =?us-ascii?Q?lBNKQennP8HIijILMLAt151kzBPrWt1/zeLWLihy8LTDynTxSesnHqskQ7fY?=
 =?us-ascii?Q?XQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4401.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4def6b4-1b41-45d6-b334-08dba3fc5a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 17:14:04.7218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NIlZuJeCOY1fEsOjJODWwMf+20YuQElH8G9g+KO+jKEeiKvszq2yzYotyvFXOvZ98XUgzml1kbPVFLgbEEew9Ex+i8ty2D0jfy+/YSWoJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5640
Subject: Re: [lttng-dev] userspace logs cpu analysis and LTTng UST Callstack
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
From: Matthew Khouzam via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Content-Type: multipart/mixed; boundary="===============2398706334235294094=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2398706334235294094==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SA1PR15MB4401C1D660802D563A5507609E1CASA1PR15MB4401namp_"

--_000_SA1PR15MB4401C1D660802D563A5507609E1CASA1PR15MB4401namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Here is a youtube video showing how userspace and kernel traces can play ni=
cely together.

https://www.youtube.com/watch?v=3DK1JNQ-HkC6w
[https://www.bing.com/th?id=3DOVP.Gn3WzoDhqlLuUCSgJ3asFQHgFo&pid=3DApi]<htt=
ps://www.youtube.com/watch?v=3DK1JNQ-HkC6w>
Eclipse Trace Compass: What's the deal with Experiments?<https://www.youtub=
e.com/watch?v=3DK1JNQ-HkC6w>
Since the beginning of Eclipse Trace Compass, and even before, people wonde=
red 'what is an experiment?' This video is a helper on that front. Experime=
nts are a collection of traces that have similarities and thus can have enh=
anced analyses as their information paints a full picture. Some examples of=
 where experiments shine: * Resources Views ...
www.youtube.com

________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Matthew Kh=
ouzam via lttng-dev <lttng-dev@lists.lttng.org>
Sent: Wednesday, August 23, 2023 11:28 AM
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>; Bala Gundeboina =
<Bala.Gundeboina@kpit.com>
Subject: Re: [lttng-dev] userspace logs cpu analysis and LTTng UST Callstac=
k

I believe Percepio Tracealyzer is a fine commercial product, I have spoken =
to the CEO, he seems like a great guy. I cannot speak for his work, however=
, with eclipse trace compass, I want to make sure you know, with an experie=
ment you can mix userspace and kernel traces. Then the userspace events com=
plement the kernel views.
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Bala Gunde=
boina via lttng-dev <lttng-dev@lists.lttng.org>
Sent: Wednesday, August 23, 2023 2:17 AM
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] userspace logs cpu analysis and LTTng UST Callstack

Hi all,
            I have capturing kernel and userspace trace logs with LTTng but=
 kernel logs will give more useful information but userspace logs is not gi=
ving more useful information compared to kernel trace logs, how to get the =
more data from userspace trace logs. PFA of userspace and kernel screenshot=
s if you observe the kernel screenshot we will get per core cpu usage, thre=
ad analysis and more .

i am not able to load userspace trace logs in tracealyzer ,is tracealyzer i=
s not supported the userspace logs ? , is there anyway we can make enable i=
t ? kindly please me to sort out of this problem.

Thanks
Bala Gundeboina
This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print, retain copy, disseminate, distribute, o=
r use this message or any part thereof. If you receive this message in erro=
r, please notify the sender immediately and delete all copies of this messa=
ge. KPIT Technologies Ltd. does not accept any liability for virus infected=
 mails.

--_000_SA1PR15MB4401C1D660802D563A5507609E1CASA1PR15MB4401namp_
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
Here is a youtube video showing how userspace and kernel traces can play ni=
cely together.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
<a href=3D"https://www.youtube.com/watch?v=3DK1JNQ-HkC6w" id=3D"LPlnkOWALin=
kPreview">https://www.youtube.com/watch?v=3DK1JNQ-HkC6w</a><br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1">
<div id=3D"LPBorder_BVTaHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g:dj1LMUpOUS1I=
a0M2dw.." class=3D"LPBorder130725" style=3D"width: 100%; margin-top: 16px; =
margin-bottom: 16px; position: relative; max-width: 800px; min-width: 424px=
;">
<table id=3D"LPContainer130725" role=3D"presentation" style=3D"padding: 12p=
x 36px 12px 12px; width: 100%; border-width: 1px; border-style: solid; bord=
er-color: rgb(200, 200, 200); border-radius: 2px;">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td>
<div id=3D"LPImageContainer130725" style=3D"position: relative; margin-righ=
t: 12px; height: 180px; overflow: hidden; width: 240px;">
<a target=3D"_blank" id=3D"LPImageAnchor130725" href=3D"https://www.youtube=
.com/watch?v=3DK1JNQ-HkC6w"><img id=3D"LPThumbnailImageId130725" alt=3D"" s=
tyle=3D"display: block;" height=3D"180" width=3D"240" src=3D"https://www.bi=
ng.com/th?id=3DOVP.Gn3WzoDhqlLuUCSgJ3asFQHgFo&amp;pid=3DApi"></a></div>
</td>
<td style=3D"width: 100%;">
<div id=3D"LPTitle130725" style=3D"font-size: 21px; font-weight: 300; margi=
n-right: 8px; font-family: &quot;wf_segoe-ui_light&quot;, &quot;Segoe UI Li=
ght&quot;, &quot;Segoe WP Light&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif; margin-bottom: 12px;">
<a target=3D"_blank" id=3D"LPUrlAnchor130725" href=3D"https://www.youtube.c=
om/watch?v=3DK1JNQ-HkC6w" style=3D"text-decoration: none;">Eclipse Trace Co=
mpass: What's the deal with Experiments?</a></div>
<div id=3D"LPDescription130725" style=3D"font-size: 14px; max-height: 100px=
; font-family: &quot;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;=
Segoe WP&quot;, Tahoma, Arial, sans-serif; margin-bottom: 12px; margin-righ=
t: 8px; overflow: hidden; color: rgb(102, 102, 102);">
Since the beginning of Eclipse Trace Compass, and even before, people wonde=
red 'what is an experiment?' This video is a helper on that front. Experime=
nts are a collection of traces that have similarities and thus can have enh=
anced analyses as their information
 paints a full picture. Some examples of where experiments shine: * Resourc=
es Views ...</div>
<div id=3D"LPMetadata130725" style=3D"font-size: 14px; font-weight: 400; fo=
nt-family: &quot;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Sego=
e WP&quot;, Tahoma, Arial, sans-serif; color: rgb(166, 166, 166);">
www.youtube.com</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of Matthew Khouzam via lttng-dev &=
lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> Wednesday, August 23, 2023 11:28 AM<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;; Bal=
a Gundeboina &lt;Bala.Gundeboina@kpit.com&gt;<br>
<b>Subject:</b> Re: [lttng-dev] userspace logs cpu analysis and LTTng UST C=
allstack</font>
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
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
I believe Percepio Tracealyzer is a fine commercial product, I have spoken =
to the CEO, he seems like a great guy. I cannot speak for his work, however=
, with eclipse trace compass, I want to make sure you know, with an experie=
ment you can mix userspace and kernel
 traces. Then the userspace events complement the kernel views.<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> lttng-dev &lt;lttng=
-dev-bounces@lists.lttng.org&gt; on behalf of Bala Gundeboina via lttng-dev=
 &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> Wednesday, August 23, 2023 2:17 AM<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> [lttng-dev] userspace logs cpu analysis and LTTng UST Calls=
tack</font>
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
<div class=3D"x_x_elementToProof" style=3D"font-family:Aptos,Aptos_Embedded=
Font,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; colo=
r:rgb(0,0,0)">
Hi all,</div>
<div class=3D"x_x_elementToProof" style=3D"font-family:Aptos,Aptos_Embedded=
Font,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; colo=
r:rgb(0,0,0)">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; I have capturing kernel and users=
pace trace logs with LTTng but kernel logs will give more useful informatio=
n but userspace logs is not giving more useful information compared to kern=
el trace logs, how to get the more data from userspace trace logs.
 PFA of userspace and kernel screenshots if you observe the kernel screensh=
ot we will get per core cpu usage, thread analysis and more .</div>
<div class=3D"x_x_elementToProof" style=3D"font-family:Aptos,Aptos_Embedded=
Font,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; colo=
r:rgb(0,0,0)">
<br>
</div>
<div class=3D"x_x_elementToProof" style=3D"font-family:Aptos,Aptos_Embedded=
Font,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; colo=
r:rgb(0,0,0)">
i am not able to load userspace trace logs in tracealyzer ,is tracealyzer i=
s not supported the userspace logs ? , is there anyway we can make enable i=
t ? kindly please me to sort out of this problem.</div>
<div class=3D"x_x_elementToProof" style=3D"font-family:Aptos,Aptos_Embedded=
Font,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; colo=
r:rgb(0,0,0)">
<br>
</div>
<div class=3D"x_x_elementToProof" style=3D"font-family:Aptos,Aptos_Embedded=
Font,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; colo=
r:rgb(0,0,0)">
Thanks&nbsp;</div>
<div class=3D"x_x_elementToProof" style=3D"font-family:Aptos,Aptos_Embedded=
Font,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; colo=
r:rgb(0,0,0)">
Bala Gundeboina</div>
This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print,
 retain copy, disseminate, distribute, or use this message or any part ther=
eof. If you receive this message in error, please notify the sender immedia=
tely and delete all copies of this message. KPIT Technologies Ltd. does not=
 accept any liability for virus
 infected mails. </div>
</div>
</body>
</html>

--_000_SA1PR15MB4401C1D660802D563A5507609E1CASA1PR15MB4401namp_--

--===============2398706334235294094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2398706334235294094==--
