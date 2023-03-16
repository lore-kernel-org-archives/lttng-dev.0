Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCBDC6FD19
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Mar 2023 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1678983278;
	bh=4k7uIiVoE6cwThQLopWynJTigaWudhGWio9DdLeHVfY=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=WqL3aRUlSVQ8R2S16znyMzbCYiNDSsnI9QN/fFd1YGcNP/R71hHy+YbbIKLKePdmm
	 1cDn7hnpmvi1xzxp2h1ALLgOkFbxqqb/PiixahIvieRwBJvQ3X6hMIJ9dDVT0dIOSN
	 KEfo4MFM8VBB5Y9A8704g/jz5HSNeo+EvuZzkdabv5I3o3D2CBK94jXWhlCQYg+ALj
	 uRy+qf5XUpLbiouq9FIZK2gD9r+ZkQHzCjlpLvjNY7HME9tsjM04bac/6Dg6Zn09sf
	 MG9ihkobugGRSCx+BvozeOavQepA39wB6w+4qs75cJj6y3UD+diB/pg874MBQJINHF
	 RErmPOK2wrANA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pcslx3Z2Yz2CSt;
	Thu, 16 Mar 2023 12:14:37 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2041.outbound.protection.outlook.com [40.107.116.41])
 by lists.lttng.org (Postfix) with ESMTPS id 4Pcsls61KYz2CSs
 for <lttng-dev@lists.lttng.org>; Thu, 16 Mar 2023 12:14:29 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUo4VGMAEMGF0YAC6nqNGcP4elwWGHlLuNhA6qOAorxzuE0QDZPzc12g3vSwZFqMe1qiELRdpRMZkqIyhQo0opTugGbHVxYJhFbwAZN+FC7s0sEm1i2wy+ZV/2qu4TkYOBDv5EEXS93cPitF8OwRAdF9cwHU/+zj6dxnpNbi8s34c7R91+k3C3KMB+2YQo28YdGIWL5qmQNwSwEokG3UDINVK4gADo7cJzyVbxV9SXRpRmUwcFl+xz+kh+Cq2KlL3P9l4EAbi/b8+pgopES5ztYP7Hvr+Ba3xLYfsYkXIMFHepgJJY9gwEW2sP0qgxR0ZzL0CcswVxPCwBo+nLX87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDSIyGcNtKJmGcFwXvWZ50PCzWKIArUoDGjY4Pmdb40=;
 b=WNEgxzadxISr9ICkGWHgKfwyTWuxjDi6ETKo+/IPGvAXU8quOEmo30OqCoNUdee9bm5KACQo9Vy9R72c8JQ3B293jFZUjF6xiF2eV4Abbreq4uHcuxzvx+WYhwgJ3LVEdA2VuwxhRwQHbaPopkMDK4SoZTTZqJEgiGEkfoLYRHmszVrADXn265tV1zE2S9T5p6R4PVPgsSOEgXILDtTL7OvZbRppZ2qhjFZmyVciarfUwlSuhM+cLCtTK8c2oFHqkymicJs7m6yWtTPIXlPvwDB+1GDmgLF0Z17NwIQx2DfNO+8v9WNo3YMsOARfmbVSEWaPlIH9h081vBTrOBQcbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT2PR01MB10585.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 16:14:14 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a5d:d20d:1c9d:58b7]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a5d:d20d:1c9d:58b7%2]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 16:14:14 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Tracing a docker containerized java application from
 the host
Thread-Index: AQHZV5sAB+QoDrSPA0i1xbmgzC1wCK79lHFD
Date: Thu, 16 Mar 2023 16:14:14 +0000
Message-ID: <YT2PR01MB598409B4EB4A498DFDF47B5EBCBC9@YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM>
References: <CAMxxxdPaVF+gd-TK73XYpSQstmFtH98DVyo2SfoHqbH_+c2rDw@mail.gmail.com>
In-Reply-To: <CAMxxxdPaVF+gd-TK73XYpSQstmFtH98DVyo2SfoHqbH_+c2rDw@mail.gmail.com>
Accept-Language: en-CA, en-GB, fr-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB5984:EE_|YT2PR01MB10585:EE_
x-ms-office365-filtering-correlation-id: 899b3771-bfc9-46e9-5d0d-08db26397c2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PkZuamu0vI5qV+GJkcNht+ElnhHVP33qxAhea9mC+DrRWe3GNhM69W7vvJlYjYBsxiQzuaKC+Ty/AJxbJErWo+hvqmOFAGAmU6ZfOpZUUe7q7qR01ppONUwEpI3OWMcpU0TQZ8wqc1iB6fKFFC+a6VoMzlgcQVTM7BXkmYgrrO2nIzG6iCg31ixW/VdbZdJcN3nK6+DCj9vQY+Kfq0iLINobja3sfgCDYptQwOnXA+pS4RuLwGKnusy5rtodNItIRlv125pZ9fEOD8AZRV4gtPGkxWFZNdY8tya+c4iwu7xWN+sExHI3BwIqAqG1Ep9V7XrJG/1NJKZ8bPaga6iynTbuYbQw/3Yie6UBSK+cQ6F/H5B65qH9EFXEGN5JgvVI7PjVOYJ1hrUSBwRniJTKyC7odUKZE4e8/M6qkVfuxqYv+cft1geK7OwZMJQBDsA5WUFEQSe1Sk7VkxatxKcH3rLdARqus2wnFiRQux3iDZVG2zUIYz0eqwC+34JOnWj9pAHjQ/2dWeGBCE1C8j9mxxxwog+d3oPux8+IDsqZ+EV/gFyc5p1K5QPhAxj3Kn3btYo7jBXX5DuF7re7KOfeLh0KLTKsvzNf6HQuQjBpJX8vxeiykMkY/gKfvoM+YHrNVJQmjhmLhE4wks8frHSylXgRk6IfD3WMvHpK2gxnphamt8Qhzu3/GmfP/+iOfcEMtM83X4dJvImKKsUFwyPDLKeV3jh0eqCByjd5peo50lU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(39830400003)(366004)(346002)(396003)(136003)(451199018)(19627405001)(52536014)(41300700001)(5660300002)(8936002)(2906002)(86362001)(38070700005)(166002)(33656002)(38100700002)(122000001)(478600001)(71200400001)(7696005)(91956017)(66556008)(66476007)(66446008)(64756008)(76116006)(8676002)(6916009)(966005)(66946007)(55016003)(66574015)(83380400001)(4326008)(316002)(186003)(9686003)(26005)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uDOCL4btFm234rop3coUbHZJzj64/8xuEQVNGxdjZYXMpL0CsOy0HxxCTF?=
 =?iso-8859-1?Q?AebyBDbOFvXqA/zijCNgX8gd9hifpPBH8XsEYLC1pEVJoKtX10DVCtjfZw?=
 =?iso-8859-1?Q?KVCs5XP2VriM9IDP2pcZyVFTetOeoh0umBcf8ghdb5XPXcgb8J+If2+AKF?=
 =?iso-8859-1?Q?V7zaRN0aRvSHr95/Cu7ELZVDaLn2vWkgREb/pDQEb0ZZegkX5nZVGA6VWe?=
 =?iso-8859-1?Q?VUxzjJV1rr/87tuayYjR4SX92iQH9OBwrqSS5oTDlN3B20CcoT4aGCvGW8?=
 =?iso-8859-1?Q?7lpT42nCYpxyonECJiJTyA5aZ3xIsCkPdRZZj6uKMmeINk5yGGct908NYZ?=
 =?iso-8859-1?Q?1q5SXu1UkKw05FB2IqOfgyE+NwZTOtPRgQffoGhw+qFv5F4suptk8gm2vt?=
 =?iso-8859-1?Q?gKAahGODPs5Zh+aHpFwLt2gCrRD8En/INTbnPHXrcE8rAyYGFtwluDxyje?=
 =?iso-8859-1?Q?pKUAHVmNnpLzzX7M+7GCYQbTFjOo5YQLdUG4KPeNPLAuI/Z5JGhsvz89CJ?=
 =?iso-8859-1?Q?BDuoPH7oYp/8fqbCWecz/Hp65KC6nCwSsTJIXBEypS0aqM90u9altyTNf6?=
 =?iso-8859-1?Q?2gClmBQwu6xq9wLt0aR0Z9HbzimYYupXK+qt1BXfHk0eBwqM8yLt2e93Rt?=
 =?iso-8859-1?Q?2VFDZdqUZpxsvFXHXs/IefGRT/sA5PWZAwLWyoFHc5oM9sFCBdwjv3XOs0?=
 =?iso-8859-1?Q?8X6DIsStYCoAKO17eJfq8fRXb+c0qEpQGVEifu39iICCLAPN3EvNbvkbuW?=
 =?iso-8859-1?Q?yDmC1SJQqr+iNlMMSMpKle9ZiyYFVLvmjkcgRfUxBM4D3KYLM8XAQlGgcL?=
 =?iso-8859-1?Q?hCTSdOTkvVJeuY0GQRyQbQuDsoJWNXXb1lGhcZDHpnnZOQ9enezC906zpi?=
 =?iso-8859-1?Q?iG0OavQZ5lONNILL23s3oWEvbqG3ebhnAhSe9GGoVab1PqB1/929m1TKs7?=
 =?iso-8859-1?Q?fXXUid6W/AdXwbtY2CY8izLug4Ct6yBFpmbmtYbAuql04hdGvRgVk3topE?=
 =?iso-8859-1?Q?/j/T62Y3VjmPim0xo5Gxs7gJYytYmVY3n7b7SmNw8Fp3b+c2SpnmMwQmAF?=
 =?iso-8859-1?Q?vKsaCQORIaDDdWaQ8BMDo5ZtrXtasKYufNQrWLKP9NokDQ7Pvx4CKUBX9K?=
 =?iso-8859-1?Q?dN1aqqMPY16/7VkEwMMXVmdaTvhGWBBXjjAHRNwWr4KxdbiXFWdih81ycM?=
 =?iso-8859-1?Q?34PwAmKG2Ua659GJGxa4IRLZpoi05X9RRi6B3EKyY+mDz9ev0y8xpNgOwe?=
 =?iso-8859-1?Q?wotaxIA73o2rqLOBNJR05afIJyil7R0DVeGENbt+ylMnF7PSicCWs+JV3p?=
 =?iso-8859-1?Q?bnVgalXYNDjBnu6YqyWJRMTcuc/36yOqWHyeLLGk2FR0Bv62Dozk8HU3Q5?=
 =?iso-8859-1?Q?Y1UwFXCw4jM3iS8n0W0jfzh2uwNj01UOAucYYWZzvp4O9s2+R8OpsAbItZ?=
 =?iso-8859-1?Q?W0Icaf2B6GaGyjTis3xG07acGbU9CvQa0ZpLb0ojVDOxS2oa4eFHqilYa/?=
 =?iso-8859-1?Q?7h7ja/N436CzeEtRMoke8phgiJfMig8jYeQh//zyxa7XtD+a/Lc2ZdVJsI?=
 =?iso-8859-1?Q?8tzD/fVi8nrhs90pGOVWSuhIAxUG1SkqIqzFlxO0qi0qnryrEJmC6Mcnyc?=
 =?iso-8859-1?Q?saNt3cXEhGcuQTPrvlYEsOjUzII80DhWkw?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 899b3771-bfc9-46e9-5d0d-08db26397c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 16:14:14.1214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiuThtaBPnE1rZWEi+sfla3jf11DyNKg3e2pupq7UEi0tTf8fVjp1oVOfz8NsWTc/z1x2vRk0PIemMU92y2bWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10585
Subject: Re: [lttng-dev] Tracing a docker containerized java application
 from the host
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jgalar@efficios.com>
Content-Type: multipart/mixed; boundary="===============2051222145675919907=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2051222145675919907==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_YT2PR01MB598409B4EB4A498DFDF47B5EBCBC9YT2PR01MB5984CANP_"

--_000_YT2PR01MB598409B4EB4A498DFDF47B5EBCBC9YT2PR01MB5984CANP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Adel,

The java tracing facilities make use of an agent that communicates with the=
 session deamon through a TCP socket. You must to ensure your java applicat=
ion can connect to the session daemon's 'agent-tcp-port'.

https://lttng.org/man/8/lttng-sessiond/v2.13/#doc-opt--agent-tcp-port

Is that port properly exposed by your container configuration?

J=E9r=E9mie

--
J=E9r=E9mie Galarneau
EfficiOS Inc.
https://www.efficios.com
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Adel Belkh=
iri via lttng-dev <lttng-dev@lists.lttng.org>
Sent: March 15, 2023 20:03
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Tracing a docker containerized java application from t=
he host

Hello everyone,

I am reaching out to seek assistance in tracing an instrumented Java applic=
ation running within a Docker container from the host side.

In my setup, the LTTng session daemon, running on the host side, indicates =
that application registration has been completed (please refer to the logs)=
. However, when running the command "lttng list --jul," no registered appli=
cations are displayed. Although the application successfully creates the "L=
ttngLogHandler" object and attaches it to the logger, no traces are generat=
ed.

To allow the application to access the lttng socket file, the host's /var/r=
un/lttng directory is shared with the container at launch (using the comman=
d "sudo docker run -p 8080:8080 -v /var/run/lttng:/var/run/lttng sample-ima=
ge"). I am only interested in collecting userspace Java (--jul) traces.

I would greatly appreciate any assistance or guidance that you can provide.=
 Thank you for your time.

Additional details include:

Ubuntu 22.04
Kernel: 5.15.0-60-generic
LTTng session daemon version: 2.13.2
Docker version 20.10.21, build 20.10.21-0ubuntu1~22.04.2
Regards,
Adel Belkhiri

--_000_YT2PR01MB598409B4EB4A498DFDF47B5EBCBC9YT2PR01MB5984CANP_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Hi Adel,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
The java tracing facilities make use of an agent that communicates with the=
 session deamon through a TCP socket. You must to ensure your java applicat=
ion can connect to the session daemon's 'agent-tcp-port'.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<a href=3D"https://lttng.org/man/8/lttng-sessiond/v2.13/#doc-opt--agent-tcp=
-port" id=3D"LPNoLPOWALinkPreview">https://lttng.org/man/8/lttng-sessiond/v=
2.13/#doc-opt--agent-tcp-port</a><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
Is that port properly exposed by your container configuration?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">J=E9r=E9mie</span><br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
J=E9r=E9mie Galarneau</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div>EfficiOS Inc.</div>
<a href=3D"https://www.efficios.com" data-loopstyle=3D"link">https://www.ef=
ficios.com</a><br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of Adel Belkhiri via lttng-dev &lt=
;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> March 15, 2023 20:03<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> [lttng-dev] Tracing a docker containerized java application=
 from the host</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div>Hello everyone,<br>
<br>
I am reaching out to seek assistance in tracing an instrumented Java applic=
ation running within a Docker container from the host side.<br>
<br>
In my setup, the LTTng session daemon, running on the host side, indicates =
that application registration has been completed (please refer to the logs)=
. However, when running the command &quot;lttng list --jul,&quot; no regist=
ered applications are displayed. Although
 the application successfully creates the &quot;LttngLogHandler&quot; objec=
t and attaches it to the logger, no traces are generated.<br>
<br>
To allow the application to access the lttng socket file, the host's /var/r=
un/lttng directory is shared with the container at launch (using the comman=
d &quot;sudo docker run -p 8080:8080 -v /var/run/lttng:/var/run/lttng sampl=
e-image&quot;). I am only interested in collecting
 userspace Java (--jul) traces.<br>
<br>
I would greatly appreciate any assistance or guidance that you can provide.=
 Thank you for your time.<br>
<br>
Additional details include:<br>
<br>
Ubuntu 22.04<br>
Kernel: 5.15.0-60-generic<br>
LTTng session daemon version: 2.13.2<br>
Docker version 20.10.21, build 20.10.21-0ubuntu1~22.04.2<br>
Regards,</div>
<div>Adel Belkhiri&nbsp;<br>
</div>
</div>
</div>
</body>
</html>

--_000_YT2PR01MB598409B4EB4A498DFDF47B5EBCBC9YT2PR01MB5984CANP_--

--===============2051222145675919907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2051222145675919907==--
