Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66815EE4993
	for <lttng-dev@archiver.kernel.org>; Wed, 23 Aug 2023 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692804500;
	bh=YjjvWuh2puMfpd6nqpIYqA6k5sOjrckTGFVVrRWiRuA=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ROnolwEvY9YHSu39tZbbWtC15rH4QE33wm4sK44UshNJK2/u279s62DVlCIUSXjJz
	 6Vits/WdjE3+aiNOhI2IgdE7/MM8FfBIIWoliSlcy3mdhVVA0HCAisKVihanMQ44tD
	 CmuuyLLsMILWA9TgYAx1nawYRb45DpybKDAtvX8HcSWOYKEEW+inZmbUguahLHU3H0
	 1hWjfueh7jcX1ZttFm44Paseejl1g5RBH83e4i4n66mcCb/DR7UzyUTguNcc7bmaVD
	 9GnLPxTC9ysLgqMTyaAujRJTTV/HFJSD8fCEv3rVhma2dOnaj6BDbXx3gRy7yKnmrx
	 e1UAEty2mgzng==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RW98g5kzQz2QN4;
	Wed, 23 Aug 2023 11:28:19 -0400 (EDT)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::611])
 by lists.lttng.org (Postfix) with ESMTPS id 4RW98d3vvFz2QN2
 for <lttng-dev@lists.lttng.org>; Wed, 23 Aug 2023 11:28:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHD6uRNQXBVldPP7+uf/ha8nrtES/66X4kCJT8m3/7SfsQxgikhvibaHkoNyn/teVtLgtlLh29aj+LhDbTMu2pxFxNwWoKI8sRKWv1/sQRLgfhx0LTZ30wIGTLTo24RN6eK9HTs2Q5wXBkuC7VV2VoCynM+j3ZSmcDUQOFCrd5Se4PCebqfv9VCw5LSaoB/N3DOVSF4pIp3pqRAeYDmWo9gdxJ8DFy2kSyvCgdnAkKtfCWWByhC/wBXw2ctYJDkaWbq2rtCeeSKvyccJ3YQTPU2DSHN68M6mcvIkYXyvKF/PFeAt6qFtTQJ/ufiV3AD/sVEJNslLb/bRV4dYVR4hUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ekf+gCKZzvQ1tuu8uHeunvK7VZ0mc9Q6DcUC7tF3rjc=;
 b=U5MoMWIc0KbVK/+NZP6MFNqkf2Kg93S2zpnervlEXTa4kb9AKug00zWRre0CTWeBSdlm55hY17s/l2qr34z9pjHPetKSjSu2L/cdY8o6Il0p8L+dy5VJEmMB67yhhdwgoKJ6VxadRe43FG9fajJXDtGqvBdl88sMbQcsatjmar8KJNSVBUXzxTORa2k6hLA5vSudVg7XzSadWavSx+HkEczuzBJbWkjY3h3TQWq6w2Yxti6Bse21BK+XHRgxhEEYbzo7bUyYGtzukJeocKy9IQ12g298KfislZV6t+Kg4g1i4fH7gDwGEyZG/HgKpYKBdHHUeNzsWkuNSfK1IOKIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
Received: from SA1PR15MB4401.namprd15.prod.outlook.com (2603:10b6:806:190::14)
 by SA1PR15MB4337.namprd15.prod.outlook.com (2603:10b6:806:1ac::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:28:15 +0000
Received: from SA1PR15MB4401.namprd15.prod.outlook.com
 ([fe80::cab:bf70:e554:8635]) by SA1PR15MB4401.namprd15.prod.outlook.com
 ([fe80::cab:bf70:e554:8635%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 15:28:15 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Bala Gundeboina
 <Bala.Gundeboina@kpit.com>
Thread-Topic: userspace logs cpu analysis and LTTng UST Callstack
Thread-Index: AQHZ1R5JzcAa3ZMnsEaTPMWl5xdKpK/4AHka
Date: Wed, 23 Aug 2023 15:28:14 +0000
Message-ID: <SA1PR15MB440196EFB7CC4F7B1081211F9E1CA@SA1PR15MB4401.namprd15.prod.outlook.com>
References: <MA0PR01MB698794918256CD8FAFAF0005851FA@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <MA0PR01MB698794918256CD8FAFAF0005851FA@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB4401:EE_|SA1PR15MB4337:EE_
x-ms-office365-filtering-correlation-id: 4fc44edf-9420-4eb4-11f4-08dba3ed91b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/c/y+zCDVSVnFo5VDfuu2VmBHdd+YDtJcqsxK+fYMh2BYr/CSWnFR4vFKksKqJ+eBhcNyydZ0H2ytC8j4bk919MLkZopd3yglQdocz4fr/XuuQsafqkxoooALsnwFr550PS0QS6kPZ0FhZOQKscISANivNwmn9uD+TisZTqic4BiTUBR29QofTlM4irU7ipD6x/1o5D8DU7Gia342F9dvFztGjZU0qj/JLx4CQaFNMWvqI3/tDpc0ettO/G8Csn2/su4J5yucIwuydXcRjlS/bWxSaEo3UpFVsfvWdKkHgkC//NAgVCilo/PT5TVKJtDvhM3aU/XGyYRNQNbmPK1qH6+FJLDZ7uL1CVJjiCTGyGRRcucrREusekWnd9h7zBrANpwQq6pY00Wf2D6ISQSOUSCYMpLXNEsxlaWslYknNqD80ckIUMBEcbND0a3XjXrsIPTJ/gv5z7YAzSKIyGQf+vK7ugFdSzyRHYkLF0Wfi7I72xQuk2QFE5QU94L8c/YwubTnj41rMaRB9uEXn5M6+q5yKYUb7gkkBkjSuFksrL5XUTTytldBXFu3jB7z89nRkjCqFf8gUKDRpopZk1epJZTOsSAjH8OgthSPoEjyzrhBMXVTi9Sh+kYhpXRPQq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR15MB4401.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(186009)(451199024)(1800799009)(6506007)(7696005)(52536014)(316002)(53546011)(19627405001)(8936002)(8676002)(66946007)(66476007)(66556008)(76116006)(64756008)(66446008)(110136005)(41300700001)(55016003)(9686003)(91956017)(26005)(5660300002)(44832011)(71200400001)(478600001)(83380400001)(66574015)(86362001)(82960400001)(2906002)(33656002)(38100700002)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5ZSdKM7t9OU4rR3V92spXcaE4ZsKS05z7mmux9M8K9fZfgAj3wsSJo2Uz7Dz?=
 =?us-ascii?Q?97cVqDtWTXxkYHo74ns4Pbj+vInyW7nB2MffaoBTQUkqrHCASKqAtBVOcheC?=
 =?us-ascii?Q?bxP3IV1D1GfxIBqWSMWvk0u42C5ppbu+LmISAvbJkkk6gtwFxwMFB5epTmRx?=
 =?us-ascii?Q?2d6Dlz3L0txB1aHbNQnRmD4mJt1T5uA131+EIR9DR1LJul6lIzfvlVFF1DNv?=
 =?us-ascii?Q?bVT9sRo70leayYzOtCsv51F9UGQ4FNkPXjM8NSq9g3hw94DMYeYHn5j9/AnQ?=
 =?us-ascii?Q?5F2fY0CzFSJrBosdfZpiaWbP31u7Jl0YcH2FsZLHe2wEU4C1nnPncV7trn2K?=
 =?us-ascii?Q?zUaZF8znpvwxjn7cDTqbKNTdyxo+u6d9f5BE3TkGxIRBKdRNCrk5EtoDKEj9?=
 =?us-ascii?Q?XsAD+o9zkEfEEzAayzPckkYo+eThWYa2fWwli+v3CZ0KynsnAxyQghn9QfTv?=
 =?us-ascii?Q?5NOdFl5RpiOxXjAnV5SQ1hyh0Wvyc4EhZ4Gl1RQ+UNO49z4lQ5rDwEePPOK0?=
 =?us-ascii?Q?poQK9NATIUq4J3j4U9kRd4yiKyT6v/UPW+oKS9CL3KjL9UtIPfH5pl/ai0/H?=
 =?us-ascii?Q?+vamh2ISBcVtOo1RcFYnUQ0SKlTxxUbjLJ8l3kUtfWUWqNHD15zBkteHav1l?=
 =?us-ascii?Q?4jZwOxfFCqnzolV87DrK56y3AK/q0t+uxTKMc9iUcNcTDXtzfQiwbn2Fq5bf?=
 =?us-ascii?Q?KZJtLCao6wWRkhPeHJooqRAdzWTSnGbPepE7gjPCrKdCu76lzLkJHYBle/Gd?=
 =?us-ascii?Q?LTkJFkfqdwyDyWQFZDaXz7+IiOYh4Irkm8rhmEXZuKHcWOBewLllvKVXD9zO?=
 =?us-ascii?Q?1L89qAr4ijR6ggDEAnyTRcK5HDWIKcnYqiJ9P8AOST1B5WOV9nsB3CSkCEJR?=
 =?us-ascii?Q?RAeCWoQYZLYlbvPm/fS3G0rkEnA5onH6HN/ClrEAF/pZWXhC1N0TcLTSrIOU?=
 =?us-ascii?Q?5Cxr06t8uBIj0FkBgv0YecYQAO+0v4Uhta+UJxj8GNTqDgXrqS9moZxGsya3?=
 =?us-ascii?Q?gc89jwX0d0Zey4uv81SveePteufK1hC6yryqvIah7D8l/d1Nf19swP4wSwZz?=
 =?us-ascii?Q?S6QYnJym+USBGupejgiXSL/Fjkmhva+d8CnCatT6JLRUeIwwvc2s0G+1DSKK?=
 =?us-ascii?Q?7oW9BmHFXbiuF1ZN/T8XEvp6PBFDwKmA1K03TIVE4ibu28/xGU6I+ssK0Cwl?=
 =?us-ascii?Q?p0WnBbCuy8q3Mgf1jTS0HTomM/bzGWs95nHtDYF32xKNaRQWnmAMQfBVnyMn?=
 =?us-ascii?Q?mUUuR2Gaza6I8aPesfpcUTalROWAqr6kn++VwRZw8wluMNw+1wDUBoMqvSxp?=
 =?us-ascii?Q?0ag5OV/8Jd8WqohoQRa6Y7htuYwH1E8e7bAhx57MjhKxXWR4aRINWBiV0+Ql?=
 =?us-ascii?Q?hhqN7+01OKhR7JKX14cicIVOCunpJiNbLWOIb7HY4XBXJ0z30EFE3x+ijvgA?=
 =?us-ascii?Q?WivXeO8iD3+wEth8K1IxT/skj6wHbim+hf4ql1BjJfGKwZ5WcRYFb75cLa6r?=
 =?us-ascii?Q?91TaAHMYjkWTWpi9xcgEel6IicAA2UHo6Le3N+KbZW6hhyy3FdU5jTxiB6ns?=
 =?us-ascii?Q?fwCtiHVf2z4PhtAn9M4FSn/4SQHdcLwkuL97DKNhWfzzh44qBXYIo6d2n+65?=
 =?us-ascii?Q?XQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4401.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc44edf-9420-4eb4-11f4-08dba3ed91b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 15:28:15.0000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+tDQU0Vjlv3qmxFnuIGTyBrEETS2R3Zql0nnoAkeOs7ksBGJVw1hTpkmhaeK/Cw+uPxN0eImoHNflAfq//FvD1ZSl0149zYEtaMO+6RaAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4337
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
Content-Type: multipart/mixed; boundary="===============7315203105740438458=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7315203105740438458==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SA1PR15MB440196EFB7CC4F7B1081211F9E1CASA1PR15MB4401namp_"

--_000_SA1PR15MB440196EFB7CC4F7B1081211F9E1CASA1PR15MB4401namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_SA1PR15MB440196EFB7CC4F7B1081211F9E1CASA1PR15MB4401namp_
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
I believe Percepio Tracealyzer is a fine commercial product, I have spoken =
to the CEO, he seems like a great guy. I cannot speak for his work, however=
, with eclipse trace compass, I want to make sure you know, with an experie=
ment you can mix userspace and kernel
 traces. Then the userspace events complement the kernel views.<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of Bala Gundeboina via lttng-dev &=
lt;lttng-dev@lists.lttng.org&gt;<br>
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
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Hi all,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; I have capturing kernel and users=
pace trace logs with LTTng but kernel logs will give more useful informatio=
n but userspace logs is not giving more useful information compared to kern=
el trace logs, how to get the more data from userspace trace logs.
 PFA of userspace and kernel screenshots if you observe the kernel screensh=
ot we will get per core cpu usage, thread analysis and more .</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
i am not able to load userspace trace logs in tracealyzer ,is tracealyzer i=
s not supported the userspace logs ? , is there anyway we can make enable i=
t ? kindly please me to sort out of this problem.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
Thanks&nbsp;</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
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
</body>
</html>

--_000_SA1PR15MB440196EFB7CC4F7B1081211F9E1CASA1PR15MB4401namp_--

--===============7315203105740438458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7315203105740438458==--
