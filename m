Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F9FC00528
	for <lttng-dev@archiver.kernel.org>; Tue,  1 Aug 2023 20:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1690920958;
	bh=KyUxct68qwXoVjIfQ4Q+jccgagyhPPN3qcGUk4CS+0M=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=YQGRxh2Pol2ZuQp7WfqyC3V+OxMR4BjqTKH+x53dIXZSJQQnIn5ofOUOo+N+3Ux7p
	 XlEb+U7EOFIx/gF+SBciOza3ZgC4pKSQSTRIjBXN+UMqDowakpg95+vyw4qd6sAg9R
	 3jlvLaZpA5JHqN5yiI/Pc5Q2tkw/C2Cvy0/+SI70KW8a/qxUeytJSmNXoV/mj+ebQd
	 xtRjTjuSKTgrrp6lY6eunKHBSO0jMVFZGwueBUaQk0c+LisdnN/OC338KVlenNVErS
	 Cx1Hu/UZIqevdmEx3c8+tCbish9tfmLKSqz3EA3RCbDTFaAGyhjCr1EPhrIvbbdoWx
	 Ft3r8PlSfrjSw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RFmZj6Zn7z2Gnm;
	Tue,  1 Aug 2023 16:15:57 -0400 (EDT)
Received: from mx0f-0014fe02.gpphosted.com (mx0f-0014fe02.gpphosted.com
 [67.231.155.114])
 by lists.lttng.org (Postfix) with ESMTPS id 4RFkcW2BJyz2H0X
 for <lttng-dev@lists.lttng.org>; Tue,  1 Aug 2023 14:47:23 -0400 (EDT)
Received: from pps.filterd (m0210943.ppops.net [127.0.0.1])
 by mx0e-0014fe02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 371AsdRp013663; Tue, 1 Aug 2023 18:38:03 GMT
Received: from usg02-bn3-obe.outbound.protection.office365.us
 (mail-bn3usg02lp0143.outbound.protection.office365.us [23.103.199.143])
 by mx0e-0014fe02.pphosted.com (PPS) with ESMTPS id 3s4v5khm3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Aug 2023 18:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=IU54odMz28IPGllPs8gUwlm0ICJFPpj3FDoerrarBPob9HVuI9ZkMtVlDT16evMoI3bxX0l9xJfdLnyIGfvTDeYdtxixJ7MN0AmfBYnMMED8syPyU/PoiTGWOvD7SH/wtK5/ZYLNn5rJqjbmFCnwqpN7t2SS1NJwf/OFqoxgsVToPVa3k8+HHtadq1XABj0NWjPkKHLL0el/77RngaUH9sEuc+cRPV7ym5ug7anSoYFL0ccw8PO2QTU5iXapNmWyps60iWtocRlNav7vjJU3VkpuU0fyOk5FLDKP2bWFUEy+vw9zH0RsEeg1Hqgj6i0YF5qJZGPg57yt9puKwvtZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkc6h7plXvSVru5ucZniJ9Dsr/WfqN3eA3JzWLLQyQk=;
 b=ulIuouusgOoynte72nntHpICAlZBQDme+4kZ4AcYAijlkTJiVx0UwgmvMqw2T38LRcxPqeAzX9l9EKAERST+AOaxI3JnF+0q0MayDK9bh+zxW+fuS6WWfXG4A3P9+r0GnLNkOmvS7wvxsYJnySM5uHJYuFReGCs6I7RbSxamUXJAtFGS6AKEZ02JpTAGn4zrgFAA4MUYq9qKW2TYWbJ/mlDQW96U6nKzQc3Upn708AFlOckZdY/OFMYshR1xRN6eY1z/Z7dX+X8GQzH9kbkjX/jrrrLXSN17Nf+2HxdpD+hd8BaVKY5wEcVqNgqjZoKUH5bz8BaerR3tQ1fpfQzm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ballaerospace.com; dmarc=pass action=none
 header.from=ballaerospace.com; dkim=pass header.d=ballaerospace.com; arc=none
Received: from BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:16f::10)
 by BN0P110MB1434.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:181::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 18:37:58 +0000
Received: from BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fdc1:ea94:bb8f:7ddb]) by BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM
 ([fe80::fdc1:ea94:bb8f:7ddb%4]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 18:37:58 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [EXTERNAL] Re: [lttng-dev] Status of LTTng-scope and
 Lttng-analyses
Thread-Index: AQHZua2X0FVnjl5QPUmhulwhRf7CPa/BIdQAgBS1Lzw=
Date: Tue, 1 Aug 2023 18:37:58 +0000
Message-ID: <BN0P110MB0967A44E8E48B2C03878D429920AA@BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM>
References: <BN0P110MB0967334AFD6A7CF8DDD3BFBC9238A@BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM>
 <a750cc37-76de-d717-3cce-d26974ca52ea@efficios.com>
In-Reply-To: <a750cc37-76de-d717-3cce-d26974ca52ea@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0P110MB0967:EE_|BN0P110MB1434:EE_
x-ms-office365-filtering-correlation-id: 500c61c7-6f8d-4106-7b36-08db92be6dde
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gJ35dzxTF+Syve3tgGkWPs2z7s1z1Jzizih66VZuqi6rWYyTtGqnJiZf0eJH9MpHoxAMpLQy6EDm0r4E3TRPL0VEzopBloJaJ9r2UpEBiJn5CdU34LNRfdUGf/3xz5L6vLpZLeN4gca4CKllpgF1NVa7Gi1RASnlvnmdexrTeDO9Lh3jGFS5JbWecLor/AQxTFfTPjTpVxSIPQhZP0ojJhdbJKt4SiZLhixkiBRQ0Qdw4NBo67IulAyPW3QPAQToQFGjtU6GJPIryFBX12TXidx1Y+/lk6XOKLfrkGiMVOdnIpt7h13Y/xbe5aaPUAf/YnZpM7f8nIAY8+d2Cuso4K9JRtPBkR/JbARXz4wrHPGqroGXDQPUqB6UNW0cMTzJ5yXYBDK2trTcm5jD/ALRtFZtz8oFUt68Fxck9rVBOc59sp/M8bm3R2DsaHhVUIh+Xg403bTQ3IZm6u5Bw6+k6CXvxaFPKt2Dj4CIalZlOc8AvaTXeGzOqFBP7UlBBs4kY6uZ5/IbysBixPcXq4dbsx0pN6ZdNOOkbtSTDnrp8S7SVpgFxpLQ765Gmkpx7EA3kZG5EWgnx6QKL9Y59dbFCVrKIWgUmpXL2AaVS2n3qdU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39830400003)(366004)(396003)(451199021)(52536014)(110136005)(9686003)(122000001)(966005)(166002)(26005)(8676002)(6506007)(33656002)(7696005)(76116006)(41320700001)(8936002)(5660300002)(55016003)(53546011)(66476007)(64756008)(71200400001)(66446008)(66556008)(66946007)(4326008)(2906002)(83380400001)(38070700005)(41300700001)(19627405001)(508600001)(86362001)(186003)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: +Ln5QfAiPmFV5foblXOzivDMKvSie+QVePDse1ocn5cPbCFMi2J6g3sOfviPN370WUn5nqRorpJ1Nbc6T+7RfXNb2iLyL68nugcum+6KImvX5rRut2oGjQ/KCeTo+y6ELG5JfNWWVkp9KfJCLYAd0VseDJLkRzUADTda0nZLmOfs951JUDQuBO5rQlyknlDcE2nBylZHHJSmfjgrUQecWmzle6c8QxzP1Zhy9YvvLydjlo6EBkSZZM4pTybXXd5iM4YH+Z9p0n1/23Bs285AMssoxee8mSWvd2voPz+22aj5jTCwYINJsWOAyyyNDO0y/R+E8QvUKU9AMIC5Wci+PurUfHIS7iFMBSAzVHT6RssIjR8Q9NdLZDAkHircerfSZkytvbYaYoCmmN0kSbOmECAPASeJ+lZcAGhXrgTuiwQ=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PFivxGl9fA4H7WG42dt+RZGT/PClffrYMDX3T/i1fUesRUTh//I0Y2b4stuPgRBRrIguqiL52HdWq/afLt7Ike6Gz9wzCXquRiwHtfBifBdVu1Zz5X2md84caqUQhC51iCYuuehlGRg8ElCQbG6GX99QALlt3/obSoZqJnakjKv/r06jwXcij4P90EfeKo/LC7EzlWUl+f/gywqfCsG+BoO4ZdmfRa7y9zWpjRUr5k5y8M8DgG/Jbi5oUj6xKYhQlzWbCj/SWxT7lZCgDDb0CVVbhUDClcNMtMqMe42Xvw6L2vMD6cpG5vTFKlFstFNlyvqHZ+V5OKituPpVhdgrmra5WUyUNidagGd+T6DexIWPrtQ4edJt4xJb1ELGibmyxP87PFfwN6WBAv4xex9qQ2fqZ6AM50YC7rTM/6UdZSwQfdQvmd2kMavsF+tuxC29BvTQxpx+kRMRcbartTd4RlKNm4KrsR3eAhRG8U4IlstOeDGOuEdrrMZenzSXO/qtsT4zFp6dgsYvrpHaMtOJ4CGvKIPDwIUUV6KqTX+lWaFCuK79og1K0epk0wfioBKlxP99DNic50xwT2XXZ3ipF+rxOJGPn7I518ki3N9ArlaXaHdXjEbtmhrYF68nWM6ws554IZPyHbvOXmZnXrWA8lbrxoeanvZhYnOmxfri0czpIQB0XfrJMUNJHmUWjZx/FteDJcb2VYq0ZpKUhju/RLI1FBZXYIts6hbGhYKQ5RNwgDDyGX/eIxbjL2sR1KBVCBya980xWvzN1qe0B9mwsdTMBXENvjsyx1J7p3vVPsqI5UcDfz4bUSgkeo5E1zy4bcVG/WlLMmhtD3Z8YSmK8LXxZrywghTLIKEyuDFTpQA=
X-OriginatorOrg: Ballaerospace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 500c61c7-6f8d-4106-7b36-08db92be6dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 18:37:58.7646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cb0751b7-e940-4c3b-b051-95460db7f4d7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB1434
X-Proofpoint-GUID: lvSgGmFZIcPWPMzluVaqnscACTNEpPDk
X-Proofpoint-ORIG-GUID: lvSgGmFZIcPWPMzluVaqnscACTNEpPDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_16,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010167
X-Mailman-Approved-At: Tue, 01 Aug 2023 16:15:57 -0400
Subject: Re: [lttng-dev] [EXTERNAL] Re: Status of LTTng-scope and
 Lttng-analyses
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
From: "Cook, Layne via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Cook, Layne" <Layne.Cook@ballaerospace.com>
Content-Type: multipart/mixed; boundary="===============4152858818765213265=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4152858818765213265==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN0P110MB0967A44E8E48B2C03878D429920AABN0P110MB0967NAMP_"

--_000_BN0P110MB0967A44E8E48B2C03878D429920AABN0P110MB0967NAMP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for the reply Mathieu. We are going to go with Trace Compass.

Could I hit you with one more question? I've been unable to find an answer =
on the web.

When I build lttng-modules using the sources and instructions from here<htt=
ps://github.com/lttng/lttng-modules/blob/master/README.md#kernel-built-in-s=
upport>, it fails because it cannot sign the kernel modules with keys. Duri=
ng the  "make modules_install" phase, it gives these messages for each modu=
le:

At main.c:160:
- SSL error:02001002:system library:fopen:No such file or directory: crypto=
/bio/bss_file.c:69
- SSL error:2006D080:BIO routines:BIO_new_file:no such file: crypto/bio/bss=
_file.c:76
sign-file: certs/signing_key.pem: No such file or directory
  INSTALL /root/lttng-modules-master/src/lib/lttng-lib-ring-buffer.ko

Subsequently, the modules fail to load with an error:
modprobe: ERROR: could not insert 'lttng_ring_buffer_client_discard': Requi=
red key not available

I'm am installing on a RHEL8 system. Is this because RHEL8 is not supported=
 as an official Enterprise release? Have the keys and/or their locations ch=
anged for RHEL8?

Thanks,

LC
layne.cook@ballaerospace.com
________________________________
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sent: Wednesday, July 19, 2023 8:09 AM
To: Cook, Layne <Layne.Cook@ballaerospace.com>; lttng-dev@lists.lttng.org <=
lttng-dev@lists.lttng.org>
Cc: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: [EXTERNAL] Re: [lttng-dev] Status of LTTng-scope and Lttng-analyse=
s

On 7/18/23 15:27, Cook, Layne via lttng-dev wrote:
> Can you tell me the status of the beta projects listed on the web site?
>
> LTTng scope
> LTTng analyses
>
> The github projects haven't had an activity for quite a while. Have
> these projects been abandoned, or superceded by something else?

Hi Layne,

Thanks for your interest in those projects!

The LTTng scope beta project was an attempt at doing a significant UX
redesign of Trace Compass, starting from a use-cases/user workflow
perspective. We currently don't have the resources/funding/staff to
work on this project further, so it has not progressed for a while.

You should look at the Trace Compass and VSCode trace extension
projects instead, which have a lot more activity:

https://urldefense.us/v3/__https://tracecompass.org__;!!LNnLTj473Oq-L_5O-MA=
pfw!itm5HF-sPBKIyjFB3RohR9bQQPAiezGuN0s4IGMJQ-4HqkYlCNLHc3e9tJ6Zl_S4J6DtTNo=
7QeOQGjNezadNyIoevmmmSCqGL7Y$
https://urldefense.us/v3/__https://github.com/eclipse-cdt-cloud/vscode-trac=
e-extension__;!!LNnLTj473Oq-L_5O-MApfw!itm5HF-sPBKIyjFB3RohR9bQQPAiezGuN0s4=
IGMJQ-4HqkYlCNLHc3e9tJ6Zl_S4J6DtTNo7QeOQGjNezadNyIoevmmmwRBeFCI$

The LTTng analyses beta project is a set of python scripts to analyze
LTTng traces. Our original intent with that project was that EfficiOS
would fund the work to create those analyses as prototypes in Python,
and eventually customers would fund the rather large amount of work
required to go from a prototype (slow scripts) to a production quality
project (faster C++ implementation, generic state tracking module).
Unfortunately, this never materialized, so this beta project has been
on the back burner as well.

In the recent years we have focused our efforts on the Babeltrace 2
project and on CTF2 (Common Trace Format version 2).

Feel free to have a look at Trace Compass and VSCode trace extension, and
please let us know if LTTng scope and LTTng analyses fill a gap that is
not covered by those other tools.

Thanks,

Mathieu

>
> Thanks,
>
> LC
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://urldefense.us/v3/__https://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev__;!!LNnLTj473Oq-L_5O-MApfw!itm5HF-sPBKIyjFB3RohR9bQQPAiezGuN0s=
4IGMJQ-4HqkYlCNLHc3e9tJ6Zl_S4J6DtTNo7QeOQGjNezadNyIoevmmmqyhp8ro$

--
Mathieu Desnoyers
EfficiOS Inc.
https://urldefense.us/v3/__https://www.efficios.com__;!!LNnLTj473Oq-L_5O-MA=
pfw!itm5HF-sPBKIyjFB3RohR9bQQPAiezGuN0s4IGMJQ-4HqkYlCNLHc3e9tJ6Zl_S4J6DtTNo=
7QeOQGjNezadNyIoevmmmVNGqlAY$


--_000_BN0P110MB0967A44E8E48B2C03878D429920AABN0P110MB0967NAMP_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks for the reply Mathieu. We are going to go with Trace Compass.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Could I hit you with one more question? I've been unable to find an answer =
on the web.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
When I build lttng-modules using the sources and instructions from <a href=
=3D"https://github.com/lttng/lttng-modules/blob/master/README.md#kernel-bui=
lt-in-support" title=3D"https://github.com/lttng/lttng-modules/blob/master/=
README.md#kernel-built-in-support" id=3D"LPlnk825714">
here</a>, it fails because it cannot sign the kernel modules with keys. Dur=
ing the&nbsp; &quot;make modules_install&quot; phase, it gives these messag=
es for each module:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
At main.c:160:
<div class=3D"ContentPasted0">- SSL error:02001002:system library:fopen:No =
such file or directory: crypto/bio/bss_file.c:69</div>
<div class=3D"ContentPasted0">- SSL error:2006D080:BIO routines:BIO_new_fil=
e:no such file: crypto/bio/bss_file.c:76</div>
<div class=3D"ContentPasted0">sign-file: certs/signing_key.pem: No such fil=
e or directory</div>
<div class=3D"ContentPasted0">&nbsp; INSTALL /root/lttng-modules-master/src=
/lib/lttng-lib-ring-buffer.ko</div>
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Subsequently, the modules fail to load with an error:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<span data-contrast=3D"auto" class=3D"TextRun SCXO234394666 BCX8" lang=3D"E=
N" style=3D"margin: 0px; user-select: text; text-align: left; font-size: 11=
pt; font-family: Calibri, sans-serif; line-height: 18px; font-variant-ligat=
ures: none !important; background-color: rgb(255, 255, 255);"><span class=
=3D"SpellingError SCXO234394666 BCX8 ContentPasted1" style=3D"margin:0px;us=
er-select:text;background-repeat:repeat-x;background-position:left bottom;b=
ackground-image:url(&quot;data:image/gif;base64,R0lGODlhBQAEAJECAP////8AAAA=
AAAAAACH5BAEAAAIALAAAAAAFAAQAAAIIlGAXCCHrTCgAOw=3D=3D&quot;:base64,R0lGODlh=
BQAEAJECAP////8AAAAAAAAAACH5BAEAAAIALAAAAAAFAAQAAAIIlGAXCCHrTCgAOw=3D=3D&qu=
ot;);border-bottom:1px solid transparent">modprobe</span><span class=3D"Nor=
malTextRun SCXO234394666 BCX8 ContentPasted1" style=3D"margin:0px;user-sele=
ct:text">:
 ERROR: could not insert '</span><span class=3D"SpellingError SCXO234394666=
 BCX8 ContentPasted1" style=3D"margin:0px;user-select:text;background-repea=
t:repeat-x;background-position:left bottom;background-image:url(&quot;data:=
image/gif;base64,R0lGODlhBQAEAJECAP////8AAAAAAAAAACH5BAEAAAIALAAAAAAFAAQAAA=
IIlGAXCCHrTCgAOw=3D=3D&quot;:base64,R0lGODlhBQAEAJECAP////8AAAAAAAAAACH5BAE=
AAAIALAAAAAAFAAQAAAIIlGAXCCHrTCgAOw=3D=3D&quot;);border-bottom:1px solid tr=
ansparent">lttng_ring_buffer_client_discard</span><span class=3D"NormalText=
Run SCXO234394666 BCX8 ContentPasted1" style=3D"margin:0px;user-select:text=
">':
 Required key not available</span></span><span class=3D"EOP SCXO234394666 B=
CX8 ContentPasted1" style=3D"margin: 0px; user-select: text; text-align: le=
ft; font-size: 11pt; line-height: 18px; font-family: Calibri, sans-serif; b=
ackground-color: rgb(255, 255, 255);">&nbsp;</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<span class=3D"EOP SCXO234394666 BCX8 ContentPasted1" style=3D"margin: 0px;=
 user-select: text; text-align: left; font-size: 11pt; line-height: 18px; f=
ont-family: Calibri, sans-serif; background-color: rgb(255, 255, 255);"><br=
>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<span class=3D"EOP SCXO234394666 BCX8 ContentPasted1" style=3D"margin: 0px;=
 user-select: text; text-align: left; font-size: 12pt; line-height: normal;=
 font-family: Calibri, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); b=
ackground-color: rgb(255, 255, 255);">I'm
 am installing on a RHEL8 system. Is this because RHEL8 is not supported as=
 an official Enterprise release? Have the keys and/or their locations chang=
ed for RHEL8?</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<span class=3D"EOP SCXO234394666 BCX8 ContentPasted1" style=3D"margin: 0px;=
 user-select: text; text-align: left; font-size: 12pt; line-height: normal;=
 font-family: Calibri, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); b=
ackground-color: rgb(255, 255, 255);"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<span class=3D"EOP SCXO234394666 BCX8 ContentPasted1" style=3D"margin: 0px;=
 user-select: text; text-align: left; font-size: 12pt; line-height: normal;=
 font-family: Calibri, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); b=
ackground-color: rgb(255, 255, 255);">Thanks,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<span class=3D"EOP SCXO234394666 BCX8 ContentPasted1" style=3D"margin: 0px;=
 user-select: text; text-align: left; font-size: 12pt; line-height: normal;=
 font-family: Calibri, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); b=
ackground-color: rgb(255, 255, 255);"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<span class=3D"EOP SCXO234394666 BCX8 ContentPasted1" style=3D"margin: 0px;=
 user-select: text; text-align: left; font-size: 12pt; line-height: normal;=
 font-family: Calibri, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); b=
ackground-color: rgb(255, 255, 255);">LC</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<span class=3D"EOP SCXO234394666 BCX8 ContentPasted1" style=3D"margin: 0px;=
 user-select: text; text-align: left; font-size: 12pt; line-height: normal;=
 font-family: Calibri, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0); b=
ackground-color: rgb(255, 255, 255);">layne.cook@ballaerospace.com</span></=
div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mathieu Desnoyers &lt=
;mathieu.desnoyers@efficios.com&gt;<br>
<b>Sent:</b> Wednesday, July 19, 2023 8:09 AM<br>
<b>To:</b> Cook, Layne &lt;Layne.Cook@ballaerospace.com&gt;; lttng-dev@list=
s.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Cc:</b> Matthew Khouzam &lt;matthew.khouzam@ericsson.com&gt;<br>
<b>Subject:</b> [EXTERNAL] Re: [lttng-dev] Status of LTTng-scope and Lttng-=
analyses</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 7/18/23 15:27, Cook, Layne via lttng-dev wrote:=
<br>
&gt; Can you tell me the status of the beta projects listed on the web site=
?<br>
&gt; <br>
&gt; LTTng scope<br>
&gt; LTTng analyses<br>
&gt; <br>
&gt; The github projects haven't had an activity for quite a while. Have <b=
r>
&gt; these projects been abandoned, or superceded by something else?<br>
<br>
Hi Layne,<br>
<br>
Thanks for your interest in those projects!<br>
<br>
The LTTng scope beta project was an attempt at doing a significant UX<br>
redesign of Trace Compass, starting from a use-cases/user workflow<br>
perspective. We currently don't have the resources/funding/staff to<br>
work on this project further, so it has not progressed for a while.<br>
<br>
You should look at the Trace Compass and VSCode trace extension<br>
projects instead, which have a lot more activity:<br>
<br>
<a href=3D"https://urldefense.us/v3/__https://tracecompass.org__;!!LNnLTj47=
3Oq-L_5O-MApfw!itm5HF-sPBKIyjFB3RohR9bQQPAiezGuN0s4IGMJQ-4HqkYlCNLHc3e9tJ6Z=
l_S4J6DtTNo7QeOQGjNezadNyIoevmmmSCqGL7Y$">https://urldefense.us/v3/__https:=
//tracecompass.org__;!!LNnLTj473Oq-L_5O-MApfw!itm5HF-sPBKIyjFB3RohR9bQQPAie=
zGuN0s4IGMJQ-4HqkYlCNLHc3e9tJ6Zl_S4J6DtTNo7QeOQGjNezadNyIoevmmmSCqGL7Y$</a>
<br>
<a href=3D"https://urldefense.us/v3/__https://github.com/eclipse-cdt-cloud/=
vscode-trace-extension__;!!LNnLTj473Oq-L_5O-MApfw!itm5HF-sPBKIyjFB3RohR9bQQ=
PAiezGuN0s4IGMJQ-4HqkYlCNLHc3e9tJ6Zl_S4J6DtTNo7QeOQGjNezadNyIoevmmmwRBeFCI$=
">https://urldefense.us/v3/__https://github.com/eclipse-cdt-cloud/vscode-tr=
ace-extension__;!!LNnLTj473Oq-L_5O-MApfw!itm5HF-sPBKIyjFB3RohR9bQQPAiezGuN0=
s4IGMJQ-4HqkYlCNLHc3e9tJ6Zl_S4J6DtTNo7QeOQGjNezadNyIoevmmmwRBeFCI$</a>
<br>
<br>
The LTTng analyses beta project is a set of python scripts to analyze<br>
LTTng traces. Our original intent with that project was that EfficiOS<br>
would fund the work to create those analyses as prototypes in Python,<br>
and eventually customers would fund the rather large amount of work<br>
required to go from a prototype (slow scripts) to a production quality<br>
project (faster C++ implementation, generic state tracking module).<br>
Unfortunately, this never materialized, so this beta project has been<br>
on the back burner as well.<br>
<br>
In the recent years we have focused our efforts on the Babeltrace 2<br>
project and on CTF2 (Common Trace Format version 2).<br>
<br>
Feel free to have a look at Trace Compass and VSCode trace extension, and<b=
r>
please let us know if LTTng scope and LTTng analyses fill a gap that is<br>
not covered by those other tools.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; LC<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://urldefense.us/v3/__https://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev__;!!LNnLTj473Oq-L_5O-MApfw!itm5HF-sPBKIyjFB3RohR=
9bQQPAiezGuN0s4IGMJQ-4HqkYlCNLHc3e9tJ6Zl_S4J6DtTNo7QeOQGjNezadNyIoevmmmqyhp=
8ro$">
https://urldefense.us/v3/__https://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev__;!!LNnLTj473Oq-L_5O-MApfw!itm5HF-sPBKIyjFB3RohR9bQQPAiezGuN0s4I=
GMJQ-4HqkYlCNLHc3e9tJ6Zl_S4J6DtTNo7QeOQGjNezadNyIoevmmmqyhp8ro$</a>
<br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"https://urldefense.us/v3/__https://www.efficios.com__;!!LNnLTj47=
3Oq-L_5O-MApfw!itm5HF-sPBKIyjFB3RohR9bQQPAiezGuN0s4IGMJQ-4HqkYlCNLHc3e9tJ6Z=
l_S4J6DtTNo7QeOQGjNezadNyIoevmmmVNGqlAY$">https://urldefense.us/v3/__https:=
//www.efficios.com__;!!LNnLTj473Oq-L_5O-MApfw!itm5HF-sPBKIyjFB3RohR9bQQPAie=
zGuN0s4IGMJQ-4HqkYlCNLHc3e9tJ6Zl_S4J6DtTNo7QeOQGjNezadNyIoevmmmVNGqlAY$</a>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN0P110MB0967A44E8E48B2C03878D429920AABN0P110MB0967NAMP_--

--===============4152858818765213265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4152858818765213265==--
