Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6A0C636D4
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Feb 2023 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1676476648;
	bh=oQAeALQgxu9HSeELW1OuxA55IuzqrM8hah/kDxWn0d8=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=VMwmB9SoF/MGDBGGYwDF0H8USSftGdQR2iIK2RoFdxiLE7Lr1EWKG6ahMjumQ4Kaf
	 K3oa5VEFXwQU8DJ9fbFBo4IcMolKDIFXqeEeF5mNKQ/6oi/xmrhRvdFFZqLfve53mh
	 6hjgH4YF19t+SiJuloNC6gi2Q3gY6TZfU01aQlzYodPm4QYoKofpMjRj/1ZglTsGgB
	 03Jsac4t7LN412Jry7admP4jJ/aAlkUMfkWNqzxaKs44ywZGeu3lwkpBSrCA/GNuGY
	 kxp5+CyDat8KU0xmzaah6GtPbCwgfAQmMTzjC6KobogIPhbB3AN830Nrza3BmJyW0M
	 3mDh/DnXMSaHQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PH2lX2Z9tz1dmH;
	Wed, 15 Feb 2023 10:57:28 -0500 (EST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by lists.lttng.org (Postfix) with ESMTP id 4PH1xY5zdJz1f0h
 for <lttng-dev@lists.lttng.org>; Wed, 15 Feb 2023 10:21:05 -0500 (EST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31FBwHwW019153
 for <lttng-dev@lists.lttng.org>; Wed, 15 Feb 2023 14:56:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3np20a3t40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Wed, 15 Feb 2023 14:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/F04TGz/wT44nWY6knQT1nKkKHt6c4jTf960ZS32QW/8axUwojcft3dVK/vd3NOIgKjFe1btcygjTCyi3FNSLOa6hi+UXQ2OuSSA5m8buGjuN3MfS8GkbXeFtbkWok/TWga/9zT0aeZBYoIGvYj7jxbEE7EQ9HVQMRvfEBNSGuXeqiZTkO8YG/U/AVv+bNQ+hfteDCBdHCTtYsflkQM/aIFiXlkodWfJnOFgBGRf4Akb1Xz9iC74tDCBrWB1MhZSwSDx3NImrRqHeNP2HpZf/6P/DnlIgxwc8CkxZCvXJprMIC8/b0Xqtgh9VDLioH7CPD2Bht1DzoN5qvFlG9Fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvLv9HPUg0eUvKB2+pwfx1bcKlQw0JgN/v1SyZa/8PE=;
 b=Z3KNqiGejvmZD5LBMC9SLp+25xF8tlDOZPBP4KuT4ibS1gH1ChYW100mON/mQISjK8x5a0YW+IIrov3QUi4U24J+gyNymjJNcUgzD9b/O2IAl+TOwKv6vig+IpuYWgHo3USQnr0GKRQsFsN9UuzwU/0BiW7pOcnXfwXeCmrrFqaXlZNKZvHcGu+cu41BQ0wFv5Bu4mHwqMJt7mps5N8JX8BwlZ9lFS2gssUWvaeoaCqVDYlRKj3HoB7R78mr08sVvCPMQX1TbleV17SrWj510s4klgGDzAkeC6zuug6cyXZTchmlNqV6Izf8yC0q7j7GBm15cPY9kTbK24J/YecROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB3765.namprd11.prod.outlook.com (2603:10b6:a03:f6::25)
 by SA2PR11MB4779.namprd11.prod.outlook.com (2603:10b6:806:11a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 14:56:48 +0000
Received: from BYAPR11MB3765.namprd11.prod.outlook.com
 ([fe80::af0a:c45e:8bd9:c6a1]) by BYAPR11MB3765.namprd11.prod.outlook.com
 ([fe80::af0a:c45e:8bd9:c6a1%4]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 14:56:48 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: LTTng bugs repository - pending administrator approval
Thread-Index: AdlBTLs/DPG0L297Q8mydLw8dgJdVg==
Date: Wed, 15 Feb 2023 14:56:48 +0000
Message-ID: <BYAPR11MB3765008946045C0150271D6E94A39@BYAPR11MB3765.namprd11.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3765:EE_|SA2PR11MB4779:EE_
x-ms-office365-filtering-correlation-id: d74b58c7-94e2-4e20-5691-08db0f64dcfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZcJD/nuCUsZO3Kszag4VPaEudiYkGCQrgMccysrKaoYgAqK/WJPWRUHdWbDmP3XSV+VT5UoZH1Snugl377cu4Q4ThH2+A3/poPLsbjTq1k67vtG6DXRhgxV97qwDU7DKeGYzaC9TvBuAJdtEKb6bntVpdTaU8XWksCg4WSVUb+dTN/gcGwRnggp828qsEWc/Kic7VHwd90Vt9TYJoE5VkqlYARJTJxibZ6liaobxMe5JLK0mYnq7X4RhdKgr1l4D+DKwoijHQNGrY+RF5R9Juwfgv6j9bCJ0VQ2jZZ0PHU9P1xoZki6cW0kNgDlVYD+zLl18YRQxBzBgG7bqpYJW0XDSloyWUQk9Pu0YohB4ChtdLjVFOnI2dqKUJX7tILHHcCkSxhiJKQQlg3VlsjHVI72goQUZJnXWJWoiEF9UvrFAHkUlkJGijkE0xybQKnEUcH04qyZa4oDZl7h2T3ooZ++Zc7peEClxqm4V4ceqVMt/DxGyobbsGu19ujuizBBalp0YmutO2AW6gepLZqLwei+d7UKf7Hh3oZVlOIXQoKhJkf2U8gSDOfTQ0qQY0fFGMSHUNO4ghEcPZLbTB8OuvhlvySlC6ddNnymHQuMGC7iCK6IMUtVCPTBzWenrGOoNOxxvhxRL6au3wF1cv7DZeROoXiLufVyMFgw4sSdqpAammiDwa6Pw1AbVIIZR9MKY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB3765.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39850400004)(376002)(346002)(366004)(136003)(451199018)(52536014)(316002)(478600001)(86362001)(55236004)(966005)(71200400001)(7696005)(55016003)(6506007)(122000001)(38100700002)(166002)(33656002)(2906002)(9686003)(186003)(38070700005)(5660300002)(26005)(4744005)(83380400001)(76116006)(66946007)(41300700001)(8676002)(66476007)(64756008)(66446008)(66556008)(6916009)(9326002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Ge4C7bm1tKrK9n/IiePzCEtiWXdaQmqEYY61OYuiUlaenYcvMGQaVmQsRZq?=
 =?us-ascii?Q?/3+49ci1Pz6TYDbybZv9NBYrZvOeTNRLdGPUc6BojcoKY4zgjj1J22zqhR0S?=
 =?us-ascii?Q?DAzL42Szj+Nm0IAVkR+5KLtzVNQnUazLAIWpZZT3qCPvhjx86osgOYt9IZCC?=
 =?us-ascii?Q?ttC1uxk/DdUQ91qe2qthm7l02v2PY1O2moHo+AVK9v6IG0vKJFAgC5bqFxA8?=
 =?us-ascii?Q?iBPHXJHaeRwobxBfS3Hq/LM2J5suYUWA2kBDGyHLNdVHE4icahagexh3Fu0L?=
 =?us-ascii?Q?c3nvSexfMUb+NnwWmOeqqYv01TYbDJ1eBju6T+9Vl6kynFBTfsPV3D41JpNe?=
 =?us-ascii?Q?khxdCFa7eSmriphVYhemPDFBqJY5Plwo+O8Q+1haw160xuHaX6g/rZqY2ymu?=
 =?us-ascii?Q?bIp5DwvG2zX9qbv8Bg0G3aKLR2k/4bpMTZvNK2xCyqDFEx0PLj3FmitW3rom?=
 =?us-ascii?Q?GTAGrQR8WRV+ODNlnBdVYfrHwPzLBE50BzqCohw/165jhSUX/fmt5rI+G0EB?=
 =?us-ascii?Q?h3P/pWeNPUCqkhaDcSTCW0uA4gDIKMfg3k6L+6+8LtBpcEUWWBDAGJ/ivtpJ?=
 =?us-ascii?Q?IE6hCAyuF6cZtSZSkgK3fdCRuhVbQKsj/DpGxcnnQJDLUh+k2+iwESgbKGDg?=
 =?us-ascii?Q?Ep/oQ99xvXubxrZa5wXz2tBRdicXUPHEK8uWV4eYANFhAt2KAic9wmO+4R9J?=
 =?us-ascii?Q?qnczz+QoFeA4HLEO+sZ5EYhlUlNe/MP7kNFT6i/tKvoxFnB5tbg4OhqTdeeq?=
 =?us-ascii?Q?9GqUpqGx6OkT84Q+MIGxGsjnbTXEVI4Y2aXsauLMHffzu1CoZ+5fSujLyEx3?=
 =?us-ascii?Q?LuCTsdB3lhyy15nI/97LOpXv3gdaQU+lyRf+PmJFkic7/lQdhD8cQQ68TMw0?=
 =?us-ascii?Q?1fFSOvjeDCmicOfG09479w5wlwEIX7l3EuNevvX1dZuMePPNoMpSXJtYym3F?=
 =?us-ascii?Q?/AVklPGNZWhnKEJ4CNdfZrTAqri5dMhzoZCIGlTE6GV3y43PtaWPkBfbeC8E?=
 =?us-ascii?Q?7v8xYaJV23H5krumH9qmG7Mpt+jbunnFpwcyGD1P0l/pFmeElk5ynMipshbL?=
 =?us-ascii?Q?Vy5jvYFCImwAOhkmZ1mCtsH8frrzzry1JI4+EFRo3q2Xj2gD9NTDEe1Vif3w?=
 =?us-ascii?Q?oOtxXjH8BlFrROVYFCe5BJ2q9RomIBnUnOq79KWkXXTzssnLCZzkYWpbVIlB?=
 =?us-ascii?Q?ZH3rpoaPbYGtoCmax8nLc8xKsev96k0ovmoeHEt1KaRlmyZ6nIYieaJM2L2A?=
 =?us-ascii?Q?/JQqjHxJPL4ccu0FnLwwykZHCk05IFZoa9L57eLlsDFVq1GWZv3m8NfdoRcB?=
 =?us-ascii?Q?LjdHeoSi0KrsnPkm6fgCd6PlcLhJQLUUjh9Lo4YgF4+k3PPsA1ebVlUo+SLK?=
 =?us-ascii?Q?/12oCcOxfWThszYmU5PtoQWwnVolkik2dW3AUGp4GWpC2X4lPuwlN5HVGTub?=
 =?us-ascii?Q?9zRJhNQisvRf+ImNnJySJZ/x4xkyO90k8gKWLCCjLeLNBjRdVCQbtBXK/WUw?=
 =?us-ascii?Q?SGDKtiU2t0uTvDEyiit+Bd/p/SDuFCz37+3M+7vqBbWoPt9bXxIW42cOW9+0?=
 =?us-ascii?Q?HgLX+0PKUqSv4hMjIWN6V1eRf5O1uL+cwdoflT/K?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3765.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74b58c7-94e2-4e20-5691-08db0f64dcfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 14:56:48.1128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGg/MyvSc151NdkgrIWmmaiyGDMjDMrG2ygZgd+ekXHVSfEXn8NMNLBgjo8Vy4ZmnBQYf2eVvBAMEhBa3vyRqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4779
X-Proofpoint-ORIG-GUID: agm9MtDxfiTTySdX_m6fG0GKfmiH_Cft
X-Proofpoint-GUID: agm9MtDxfiTTySdX_m6fG0GKfmiH_Cft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=452 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302150134
X-Mailman-Approved-At: Wed, 15 Feb 2023 10:57:22 -0500
Subject: [lttng-dev] LTTng bugs repository - pending administrator approval
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
From: "Rus, Sani via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Rus, Sani" <Sani.Rus@windriver.com>
Content-Type: multipart/mixed; boundary="===============3088077528188352530=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3088077528188352530==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR11MB3765008946045C0150271D6E94A39BYAPR11MB3765namp_"

--_000_BYAPR11MB3765008946045C0150271D6E94A39BYAPR11MB3765namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

a couple of days ago I registered at LTTng bugs repository - https://bugs.l=
ttng.org/, but I still can not sign in. At the login I get the "Your accoun=
t was created and is now pending administrator approval." message.

Do you know when the registration request will be approved? Should I contac=
t someone in addition?

Sani



--_000_BYAPR11MB3765008946045C0150271D6E94A39BYAPR11MB3765namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-CA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">a couple of days ago I registered at LTTng bugs repo=
sitory -
<a href=3D"https://bugs.lttng.org/">https://bugs.lttng.org/</a>, but I stil=
l can not sign in. At the login I get the &quot;Your account was created an=
d is now pending administrator approval.&quot; message.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Do you know when the registration request will be ap=
proved? Should I contact someone in addition?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sani<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BYAPR11MB3765008946045C0150271D6E94A39BYAPR11MB3765namp_--

--===============3088077528188352530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3088077528188352530==--
