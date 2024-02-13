Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5D2C4829A
	for <lttng-dev@archiver.kernel.org>; Tue, 13 Feb 2024 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1707834221;
	bh=FdbNsSOWoAeIpt6YifwW3CGnb2YiFahQFCNhbmGf7Fo=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=v5dClC9ltlDyZMDNdl7Hi7C6sm/ApOP2km1rUC0jS/rfbDFEZFSJIcxc0Igvg4O/S
	 IY137cFhj4dclY0wHG991n5nsKyu5fsjMPX8n5tr5LSjtcHsG3rFVpN9GML6UCk3CW
	 SZDkarDWjUxBB/0zL42wMIXmZ5FWxWv5g6L/w6pvso/fmq+P5WInh9eNkPorEWOi2S
	 ro+Ev1800elNBbSTZAw94S8N2Yxs5dt1PuYD8rY3U7YRQgQVNzcHcFpx9D2n+jJC+w
	 CEciHEElVPcnL0RIlVzyqU2Ynvsdzi/JRsHyRGmz+lqxUKoQwTK/O+fb2wRmu9/1Bc
	 yueeYHTwzTsbg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TZ3Tm3c7Pz22cS;
	Tue, 13 Feb 2024 09:23:40 -0500 (EST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 by lists.lttng.org (Postfix) with ESMTPS id 4TZ3Tk4ldwz22Rm
 for <lttng-dev@lists.lttng.org>; Tue, 13 Feb 2024 09:23:38 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3ej7MXzu8y99YiPTbhnEjQ5IEzUD5tOWe4eaGpD2XLVfKDmR4L2Udj41P+0RNX2lZvGtZuAu6/FrMwj3neN0bUn1WKtEIqVn+9aqezqSjUdbmtqjEzjq6MXu55u+sEQSli53yhWF0rjaQw0GIYEq2+HdrfJd6uAk2vwMDjyaDeMDaB2AfvSo5uAOTpj9q312A2Eav49Qx/L6heeF0MkROi4PNm+/wqsIHHu88POVR4XOBn3FQcmFhKDDKwlFKF96XjrvUndxKcHk/wXuHCcy5hF+7oOg+ZWrEscThittQMm1NeijgyIRekIT84YQhE5tZckRIz2C8Uqwo1Co4SgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrRQF/2ptmvEYBY1tJ+NOJ1S9daQ33jUUebQzDIGBZs=;
 b=H6qJm3ZxFLNmZPXfeb4RKSfz1Hmtr4ggPJVwGsZIYXUV6dU/JvHirrzDSPfrzLcg8OG06qfGtzermQ/Xecwv/JzdikY5+IJFeTLwb2/qJlOZSLffP6kgh1pdQVj70sRrCHrQkrUU+VmDqA1sDIBqnLZ2MRUi0sNOCBNUD1DDagpD/knpfuRRo6gRCXFF/Gbvf1u0bw+AF/j+sofxVNT2/48Cltv7CM8CnMB77BWX5JXCdu+cgrEl7d6UzrvjteDLVlF1bKEa2YlyKFeT3YO5rxDqx8TAKQOfYL3QyqHs8etn5u9FzQwPC979EMI5rTLvElxKIGvMl4BM04wW61V3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 14:23:35 +0000
Received: from MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::63f7:10a5:21bf:c1a]) by MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::63f7:10a5:21bf:c1a%3]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 14:23:35 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Crash in application due to watchdog timeout with python3 lttng 
Thread-Index: AQHaXoaat9RDuJ44UU6XCWc2w8dXCA==
Date: Tue, 13 Feb 2024 14:23:35 +0000
Message-ID: <MW3PR12MB4555D9C015549D882B1FE87BD94F2@MW3PR12MB4555.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4555:EE_|MW3PR12MB4362:EE_
x-ms-office365-filtering-correlation-id: 41d90cfb-ac17-4d88-c4a0-08dc2c9f5d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +myumQsJHIr3ugN2gL1TWFSMp81D/seKIoOiL9d2I7LB0RC+7h4IvPMv+yPBJAFFSbcqKXqvk739f/BY4CD+bCsDC4EB6vuYU3QmYKGU2nZ7ywed9HLtHQ8fFaH6PEJbgQqa4cYhoZ1+r0xvRbhnRFFqtVXbE1ghpjCKqjvr+MvrSljr+nfDruWVPJPqtxTJq9GfSNx8wKON7LgbMPo57rDfmEIOVzYe5YUVjWmc0okJemxBSK8CvSY0LEfJIXIFYUUig7egRtR8+OdxGDmuIR56jj8XP+qm2TVsJjIrCU0IicCDtRozUvSL58mNhcGAASTzTMpVeJbnsAmF9xpGcWcaX2jrYUPASo6ANVyhZusrsiQ5YlX6VSjwKjkhrfP7422HbRSAGy5JVPEvebLZlnduTY734xUfqR4x8dOcSKDDsqRo0kFO6DYV3wUA/Q5UgdwOjVCnPmug/vZHfMYZauvwCccJW08432k618zRFikkG+BBh2t2TqwAAibgJkKdLxZdU2N2z1r/xs65Y2OA3ZAQYJkrW5R/sTQtwFV9o+tFLjHMflOdpK4KiXRwRQNOnghK/is070MtXA/ycOJJ+3J1CIEL9eq2ckuF8+ROblPYRpEFVlhnyoCMwAMKoTBU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(316002)(71200400001)(19627405001)(5660300002)(2906002)(66946007)(66556008)(76116006)(66476007)(86362001)(66446008)(52536014)(64756008)(6506007)(6916009)(8676002)(8936002)(91956017)(9686003)(7696005)(38070700009)(478600001)(26005)(41300700001)(122000001)(4743002)(83380400001)(33656002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Xb1pvBvSJ5HLlyhslBzdLPkaQ1T+IxaUqObQLazbfGLzkQ0+mZh2gxNvVb?=
 =?iso-8859-1?Q?GSKTu39/c0pddBnsGo1Z/a089a7qPa/6hV8J/QwGd9jHdOZgpnt5LdYz3t?=
 =?iso-8859-1?Q?KILFegjfEJbGui0N2UUWecNAcrZ8l295Yb2xceQUNv2RpSNy2PIyb99MAI?=
 =?iso-8859-1?Q?tKZG9dVZ4J//BN3yRRMy8DGlSQxUw8+eIaSfBRumzCphRw44jbPOGmHque?=
 =?iso-8859-1?Q?ChpAE4f1Op+SKl2GQNSKFQdz6BO/xC9yAACsk682E54f8dQpbKOS4FbT1E?=
 =?iso-8859-1?Q?XIWRsBpk+TteEzDvThe8Ad5vmAmpB0r/yccXvA8PQwGAaXKvnxvoRQpoOh?=
 =?iso-8859-1?Q?ZzHMVjYx+c9wgDAJS51qNYC01VF3NJ0IGP6vBSsoUnqEEKta3HA+fEl+kQ?=
 =?iso-8859-1?Q?PgWSStHuByefKvy7/+dtxx4iwKwzMQ2HSvMTS53XpsMsUMg6PRZloP/FFM?=
 =?iso-8859-1?Q?aZ3n1ZGbWUS8MUgF+LCDBtoj2u7S9nRDiIdB+tBwRJobiCnt8nIU8jJbX+?=
 =?iso-8859-1?Q?eGMVEF1wR2UXksxeMVqrXshcvhoZ/Fk1Xvns0CO9cI5IcmQNRTzvrXcEAX?=
 =?iso-8859-1?Q?2hyeVNy3X01mD6HJKd9tgirrO3dpgTkEirOqfe4Uj1ZtvV2c9nmlZ4CI1e?=
 =?iso-8859-1?Q?c09192U1TbMhGUaUUiVYDeRUZtlti1kuR3tVVIabEcL0aHrQ5/PTPMHViW?=
 =?iso-8859-1?Q?/bhzT2Mh1JNPqKNY3HDM8WKcUDw3YxEYLEtB+otEjxTjW6rUmNEWQO3+K6?=
 =?iso-8859-1?Q?C4oHKNPmRSVsLMwJk1LcHhtvOrnferO3himXA8vs0ozwvb8vUFeQy1ZSub?=
 =?iso-8859-1?Q?M8HzjW/oMC9cAdO79ahKy/0CgW4X4EKTfo53Y6WZFj6BCxWSkHW0TPfn8x?=
 =?iso-8859-1?Q?q3ReJaJ3M91lG4ACgc8Ihno4Numt7wQABjRLEx2CIWO93MzMxUi3m4NL9N?=
 =?iso-8859-1?Q?bhI28onqkRoAm0sUSL1p0TOPUpnhC4afMW9G9R+Hj254VtUoWGTd79WY2o?=
 =?iso-8859-1?Q?DMMvC+tv9L9VUuYljpJ3NTyh9BdVbjsrUKMvw3PBMDJT17NTVZOhK7yEgt?=
 =?iso-8859-1?Q?dsIUKM5kBQiY6YdVR4VAURetbQQWJ15hmqhBZTbOM4HVYF2YxiQvO6AwEq?=
 =?iso-8859-1?Q?4eERLbvyYeqBpT0V4Axl2UMRHBEsCp9IV1KdjUbcDRr4MzCYJQ5bv34sYr?=
 =?iso-8859-1?Q?88gZhFJoICJpRdimjs0XyOuzpwbMGLKleTqcWdAjAQzr8AVFXfx9gm47d5?=
 =?iso-8859-1?Q?h35g4lNx23lj6jfn2Xx+WZ6k1YYQb0r+Rh8GGC2f8DvD/mPxtGbC5tORzy?=
 =?iso-8859-1?Q?P/UnSts+1O2B6bmmtKbO/zs1tTs+zktU4q7oAF5ZSqR5mTc22u3fh49Vbk?=
 =?iso-8859-1?Q?nLHvztcsZ2WAZJX5JALW1BembGbSc6BXWE2UIMz5gC+5pPP6+eDEPeFCLk?=
 =?iso-8859-1?Q?9JcvuUpgEHPkTgwnVaBWvgxCV/nPtVXPVpStYqFb0vuPcwoQzlUX614Ybb?=
 =?iso-8859-1?Q?kWwyhXTLXhMGd3J2z5ESRdpeAjfSDHWX3uogTEmVUmeMLCzkXMfjb7HPpI?=
 =?iso-8859-1?Q?jfOUWGn52/uIsWIumOGGDo/cVtjC5Gqyt2yIGYMlxwjbpmg2cNbyKxkMm1?=
 =?iso-8859-1?Q?vmUu0RSksIqDE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d90cfb-ac17-4d88-c4a0-08dc2c9f5d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 14:23:35.3676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpIRSSTw1RCpEd2CFCXUmDF3+mrDqLhNA6uJbdywpVrgLdisJSSmTKvqjQDUyX4oa4fzUnSX9oqIb0lfmv4c9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
Subject: [lttng-dev] Crash in application due to watchdog timeout with
 python3 lttng
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
From: Lakshmi Deverkonda via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lakshmi Deverkonda <laksd@nvidia.com>
Content-Type: multipart/mixed; boundary="===============5966129563293313972=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5966129563293313972==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4555D9C015549D882B1FE87BD94F2MW3PR12MB4555namp_"

--_000_MW3PR12MB4555D9C015549D882B1FE87BD94F2MW3PR12MB4555namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

We are able to integrate python3 lttng module in our application(python3 ba=
sed). However, we are seeing that whenever the application terminates, ther=
e is watchdog timeout due to timeout in joining the threads. What could be =
the reason for this ? Does lttng module hold any thread event locks ?
We are completely blocked on this issue. Could you please help ?

Here is the snippet of the core dump

(gdb) py-bt
Traceback (most recent call first):
  File "/usr/lib/python3.7/threading.py", line 1048, in _wait_for_tstate_lo=
ck
    elif lock.acquire(block, timeout):
  File "/usr/lib/python3.7/threading.py", line 1032, in join
    self._wait_for_tstate_lock()
  File "/usr/lib/python3/dist-packages/h.py", line 231, in JoinThreads
    self.TT.join()
  File "/usr/sbin/c", line 1466, in do_exit
    H.JoinThreads()
  File "/usr/sbin/c", line 7201, in main
    do_exit(nlm, status)
  File "/usr/sbin/c", line 7233, in <module>
    main()
(gdb)

On a parallel note, thanks to Kienan who has been trying to provide pointer=
s on various issues reported so far.

Need help on this issue as well.
Thanks in advance,

Regards,
Lakshmi



--_000_MW3PR12MB4555D9C015549D882B1FE87BD94F2MW3PR12MB4555namp_
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
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
" class=3D"elementToProof">Hi,&nbsp;</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);" class=3D"elementToProof"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);" class=3D"elementToProof">We are able to integrat=
e python3 lttng module in our application(python3
 based). However, we are seeing that whenever the application terminates, t=
here is watchdog timeout due to timeout in joining the threads. What could =
be the reason for this ? Does lttng module hold any thread event locks ?&nb=
sp;</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">We are completely blocked on this issue. Could you please help ?</span></=
div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
"><br>
</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">Here is the snippet of the core dump&nbsp;</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
"><br>
</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">(gdb) py-bt</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">Traceback (most recent call first):</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; File &quot;/usr/lib/python3.7/threading.py&quot;, line 1048, in _w=
ait_for_tstate_lock</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; &nbsp; elif lock.acquire(block, timeout):</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; File &quot;/usr/lib/python3.7/threading.py&quot;, line 1032, in jo=
in</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; &nbsp; self._wait_for_tstate_lock()</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; File &quot;/usr/lib/python3/dist-packages/h.py&quot;, line 231, in=
 JoinThreads</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; &nbsp; self.TT.join()</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; File &quot;/usr/sbin/c&quot;, line 1466, in do_exit</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; &nbsp; H.JoinThreads()</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; File &quot;/usr/sbin/c&quot;, line 7201, in main</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; &nbsp; do_exit(nlm, status)</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; File &quot;/usr/sbin/c&quot;, line 7233, in &lt;module&gt;</span><=
/div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">&nbsp; &nbsp; main()</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">(gdb)</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
"><br>
</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">On a parallel note, thanks to Kienan who has been trying to provide point=
ers on various issues reported so
 far.</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
"><br>
</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">Need help on this issue as well.&nbsp;</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">Thanks in advance,</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
"><br>
</span></div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">Regards,&nbsp;</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Lakshmi</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<br>
</body>
</html>

--_000_MW3PR12MB4555D9C015549D882B1FE87BD94F2MW3PR12MB4555namp_--

--===============5966129563293313972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5966129563293313972==--
