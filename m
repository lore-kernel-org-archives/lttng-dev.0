Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFBAC4829A
	for <lttng-dev@archiver.kernel.org>; Tue, 13 Feb 2024 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1707838528;
	bh=Whhms72zaJ8FsFv5/bTcNq/YkQk8w4Iyoe1YGdSGRoQ=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=pf0U/szVNmYh43mjTQrGBL9AF3BKbiqgDMXueeY2olnVBzHgDBCVPQtu0b+fu/tTS
	 14Z4i/DT919y5SW4KA06zO9oMMmyjntyu2GusuSVVDNN1q8ufgporplb3siw+qfNoa
	 FpwQx2n5R+WWjgsXVUo0o6E7TLYpkn40KQKaUmC4Q/FWCmA8z8VM9LFFZs6Ch7XYpl
	 HsVrC1QZ/aVUzU6VDdj6+o9tWJtdvQ6PqWrrMyijG5KRjiBCOUAlDfnkN2Hfgco+el
	 Dk1mluakTpNBGdHakBU9I6c0inR9t+tXye2wsd9vMxDBXFgzSZPdFAtPky4fldb0+t
	 Ydpr45ZLn4bTg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TZ54b22lxz22Lx;
	Tue, 13 Feb 2024 10:35:27 -0500 (EST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by lists.lttng.org (Postfix) with ESMTPS id 4TZ54Y3rTFz22cg
 for <lttng-dev@lists.lttng.org>; Tue, 13 Feb 2024 10:35:25 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmngD+5GSVZnoRctGfkl/rNmgQpFNdP+Yky6yuNJYRMVFM30x+BHLkVQDiQgpO402Fdta6umL3OaNNoWK9Ba/icrBQw8r2DX27shFAlLejHN9IMaPCFTKkqf98DsqTtthS0+9FPZExg4nrdmbzNw+TD00wzB4pFkHY006wYfD1tFXWQdb2ABb+/FRFL+tVNNvSoxNyS4fyPBjqZBXmuXcoRnHisoHX2krRStU2ZqnXALUyPaIRVADnj2pijZRcmo2w3TmC7MfX2DKDkh/Gs5cUIEEllEthwb4O+GsHGt79MMCVLI3H6EtcEYpzPD6LxrDMtRXeZ79FNDZ/zLhOcOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJUpvn2MlNnX4PfbRjUDvOgKNdwvZWO0gUELBTALJG4=;
 b=cOplhDNIdTzWCsdoQAQmQz4xCekjaUM8AlGrJLeeGhj3rYb86dls1Df3+ciErD9yUxBxAgMP4re1fpBh0+SN5fJArv1WxDV+mko7OGS7BKVp5sdaxrkLQLAjIVyL1rZBT+cKoyWaxgtXcPd2roByX3r8PSZDWVeP89JetAiseskqErhSez0lTevFw9I/KEHnckr/KLnS0oJqPhbah6hpMb4JKozgf6VOa/5QB5WWLFg/WncJjBFSYkwcXxldrDH3Na8Dn90zhDII9u5bFwKp2xMg55sNsDlyZ8EXmQuAYgCWx+i3ezbzvLl2dTcroFpVGpJQ90vAJ0Qq5cyOGL2+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Tue, 13 Feb
 2024 15:35:19 +0000
Received: from MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::63f7:10a5:21bf:c1a]) by MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::63f7:10a5:21bf:c1a%3]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 15:35:19 +0000
To: Kienan Stewart <kstewart@efficios.com>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Crash in application due to watchdog timeout with
 python3 lttng
Thread-Index: AQHaXoaat9RDuJ44UU6XCWc2w8dXCLEIY1SAgAADAqI=
Date: Tue, 13 Feb 2024 15:35:19 +0000
Message-ID: <MW3PR12MB4555080ACAE20ED17F263B8CD94F2@MW3PR12MB4555.namprd12.prod.outlook.com>
References: <MW3PR12MB4555D9C015549D882B1FE87BD94F2@MW3PR12MB4555.namprd12.prod.outlook.com>
 <3f05e93b-f57e-4d93-be45-c779cd209f44@efficios.com>
In-Reply-To: <3f05e93b-f57e-4d93-be45-c779cd209f44@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4555:EE_|IA1PR12MB8286:EE_
x-ms-office365-filtering-correlation-id: 49c537f1-b9a3-456c-3123-08dc2ca9626c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smx6KZIsEhpcOJ+u2SpdkC5SNscD7BKSEO0RiBDoJ3Ghmg+ACUfIqhWU+QFpMgw0z9HVCwv/jN+g4LFBw7wfsYCT/zIVRrLmz67HD1cCzYnA8xGlK5kRduZqwuJ4UDzgBb4K4hD2UBLyE7gkfbFY+lH7Ds27RF66CB5sk2QNJ28nEe0ZooML437DBTQhbhYaEF63rTS1INEIMwXFL7eXWNuQNajgoIyx/HGPKjnUlXVTa5TBhZoPrSLxt25Sr/qvMfDB1VGy/5an6DV23DfEkaxNe/tbSOCemOv6aFwLz61nYxoJmHz+kzGNePsx42DY16kk6f3VwH2km1/pAoXfrl3XAJI7G7Mz7LQ63wBMC4z8rBBkKoYm2KiFw+U+mBAY6vNllsghbkU7TEpHADNFY6MW2IXwTv3vLHwMQ6po8mSawSVWf56rRlII7gpoT3HBjeQnmoZY7CcbFZtBJuXXXisKpNFY+c6+BdFcmtdrkRPE3U0GL01h/wSHlKZrIzaQXwhLsHNhw6OocAov3kb+XLDU7unVSU5OjL+MfkbzDsexxiH5GTokEvsujKqmnwj7s6czHQ90pGdZ0EAejMqzAchZ9bKWpt5VrfVI9F0eoBsd1Sm8YUGLhCIgsWrU9PzYT4YcFh6+ayItSMJPyBLeCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(55016003)(19627405001)(53546011)(966005)(71200400001)(478600001)(66446008)(38070700009)(45080400002)(91956017)(64756008)(52536014)(110136005)(66946007)(66476007)(66556008)(76116006)(5660300002)(26005)(9686003)(2906002)(33656002)(38100700002)(7696005)(6506007)(86362001)(8676002)(316002)(8936002)(122000001)(166002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eeMb0k/gKiXtxuBtAVJ+Zbeummf938iTEqr64MEB+HUUF8Fjqp74O9bVref2?=
 =?us-ascii?Q?9BlWyDLbB63jQ+ByV46CuAcQEaG+m9Rm750pH5BBPIAhdvMpiDlBtowJkip6?=
 =?us-ascii?Q?2Sxe2jFLzKsYPcC+eOib7xMS7TWI3ruphk+eoo+kpDxFpWtXOw6kgBr1u10P?=
 =?us-ascii?Q?D11U1216nIwlIUSe0J4tGP9jeKkndcfzk8MBD8cEq285syb3ix2XdNpFwRUU?=
 =?us-ascii?Q?+hrJa+Z4roCSmawWZkrzdZa8EP8IV1vCcx+s8GW0gsD0G8iPBW2qDf5+G4JU?=
 =?us-ascii?Q?/jSQVAKRG4rZ0MQIBcKwdMi3J7eQ0wbMG5HTJ93W20mdb472PG8detDw4aQa?=
 =?us-ascii?Q?xL8n69QK28r+Y3u52iqJFpSeUthS3vVzOzaF7xEEu2RfJ2Mywlb5R5pKx4ER?=
 =?us-ascii?Q?L6rPcNaKiLJUfC0R/UCid3HjdDhOuMVhA4p6gSGa6fXm1Bhg0tVJE3twJSXY?=
 =?us-ascii?Q?dLz1dQJ1jJPRThxBlqW4KagNO8xobG09ozk0MSz+8mxxLV5E/jjOxgCjQiXl?=
 =?us-ascii?Q?JPM7xOqz56YURNZjSTGKTRn/Wy+8Q85k4wnT/QuvipDrd05kTaK2IWr+fXRM?=
 =?us-ascii?Q?cUTYUipfswv4oOVTW2HkHLVsD1Dv0jnRdiSpQ013JgjR8TlJvfqS4pd3D/fc?=
 =?us-ascii?Q?zrhamKWMJ8DODVrpQqkZfjVcBwFqR91RG7OfstdHdBv8Eqyp6PBoXUJZFjV6?=
 =?us-ascii?Q?M+Jfd6UHI64/ifGfpxiN80EOdAYEHd0CANSgCQu/02I9GtGfb2+xxMrB07Nh?=
 =?us-ascii?Q?yM+OluMZmzg1GO1X6M/v+EBcMXGqr1oMq9/xS6V4RAw1l2UnSBoSq2jeAEZX?=
 =?us-ascii?Q?MbXct6Z0wl6JJAIXOMOr61ETJk1L2zIgR7g7Pacr/ibnxa53cgsWHUym62KR?=
 =?us-ascii?Q?nO86K7HBhlzNFXtkzAQZmcG01I0VQizfz2Hw+OcJp4mLJvNDMn8cUjrxGVen?=
 =?us-ascii?Q?ps46tHCSnM5qiTphA2ZugrrdWUdkbbGGUjrMAA2h1c3szaZ2rwPf2FsNRzu5?=
 =?us-ascii?Q?h0PJJ48qvy/s0QmjEh3SsTccrhUmp0vQxlgSZr18OOuyEyqFxoQe5dDAEm4s?=
 =?us-ascii?Q?8SsCgvC9rhKz/svJmf22L9XS+t9fiY1OhyT3m9TK0D5+2Es5Pk0PylAVdhjE?=
 =?us-ascii?Q?h+ghWieVXjNHjOAivgm2EFYe00Swngdx0+YQQSO5SMyjUylHbChhGuJCdgYj?=
 =?us-ascii?Q?0wt0W8/tUAFZ+LYFzUuvWOAwKFI2cxPR/2QRYSk3hQrmOcZS8G2Davff9zaU?=
 =?us-ascii?Q?3CpeKoEbPUkOz0XqCGiMbnfWNt0v6uWlZGzgDXUtw1DTh9d1nKLjzlcoG8Eh?=
 =?us-ascii?Q?8us8E+cJNzZKq8irCjSE0Ry9dnKQmSbe/JlTuc5oHRkl2fHgvDKDduRnLO5u?=
 =?us-ascii?Q?aVsq5sFUOPWHR2Y0QOB52cRssXyaGRJhdkGlt3RAAR3kBZKSW9PGiSnuy0U9?=
 =?us-ascii?Q?xsNiSnlFPEClqMelgCNh8GaEGZHPhNM1Zcr8r760dQtupjrEonnp/l7Kut8u?=
 =?us-ascii?Q?ujv1M5qTMGvpgTXjoMCL+KN+H0wOd6E4P2b03M0aI9U6cVWP8e2A9MXNQ/u+?=
 =?us-ascii?Q?INDquVqqAzYb4mQDaC8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c537f1-b9a3-456c-3123-08dc2ca9626c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 15:35:19.1739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4X0Za4iZK8eVDGfn8KUFRfPlFP1dO4VerXHEZEHeQl4Pkk2+ZiF2EY0qVmjGAYG/L/DfFxBHozJ25dVDnIaMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286
Subject: Re: [lttng-dev] Crash in application due to watchdog timeout with
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
Content-Type: multipart/mixed; boundary="===============6748333623123689776=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6748333623123689776==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4555080ACAE20ED17F263B8CD94F2MW3PR12MB4555namp_"

--_000_MW3PR12MB4555080ACAE20ED17F263B8CD94F2MW3PR12MB4555namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yes. We are trying to join only the threads related to the application. The=
 timeout is happening while trying to join the threads started by the appli=
cation.

Regards,
Lakshmi
________________________________
From: Kienan Stewart <kstewart@efficios.com>
Sent: 13 February 2024 20:50
To: Lakshmi Deverkonda <laksd@nvidia.com>; lttng-dev@lists.lttng.org <lttng=
-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Crash in application due to watchdog timeout with =
python3 lttng

External email: Use caution opening links or attachments


Hi Lakshmi,

when the lttngust python agent starts, it attempts to connect to one or
more session daemons[1].

Each connection starts a thread that loops forever, retrying the
registration in case an exception occurs[2].

I don't think the it's designed to have `join()` called on those
threads, which I assume is happening in some of the code you or your
team have written.

My initial thought is that you should `join()` only the threads that
pertinent to your application, ignoring the lttngust agent threads and
then exit the application as normal.

[1]:
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Flttng%2Flttng-ust%2Fblob%2F3287f48be61ef3491aff0a80b7185ac57b3d8a5d%2=
Fsrc%2Fpython-lttngust%2Flttngust%2Fagent.py%23L334&data=3D05%7C02%7Claksd%=
40nvidia.com%7Cbdf064d348474249f14a08dc2ca755c9%7C43083d15727340c1b7db39efd=
9ccc17a%7C0%7C0%7C638434344447867621%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D7=
tmpFtjl7RkTVgYLr2YjdlPs2oM1F%2FXOg6W51mHDCws%3D&reserved=3D0<https://github=
.com/lttng/lttng-ust/blob/3287f48be61ef3491aff0a80b7185ac57b3d8a5d/src/pyth=
on-lttngust/lttngust/agent.py#L334>
[2]:
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Flttng%2Flttng-ust%2Fblob%2F3287f48be61ef3491aff0a80b7185ac57b3d8a5d%2=
Fsrc%2Fpython-lttngust%2Flttngust%2Fagent.py%23L83&data=3D05%7C02%7Claksd%4=
0nvidia.com%7Cbdf064d348474249f14a08dc2ca755c9%7C43083d15727340c1b7db39efd9=
ccc17a%7C0%7C0%7C638434344447874777%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DPK=
b8rKDWFKmuuVB4YQEL8ZtAP%2B%2BYfTniUuLN9fFBctc%3D&reserved=3D0<https://githu=
b.com/lttng/lttng-ust/blob/3287f48be61ef3491aff0a80b7185ac57b3d8a5d/src/pyt=
hon-lttngust/lttngust/agent.py#L83>

thanks,
kienan

On 2/13/24 09:23, Lakshmi Deverkonda via lttng-dev wrote:
> Hi,
>
> We are able to integrate python3 lttng module in our application(python3
> based). However, we are seeing that whenever the application terminates,
> there is watchdog timeout due to timeout in joining the threads. What
> could be the reason for this ? Does lttng module hold any thread event
> locks ?
> We are completely blocked on this issue. Could you please help ?
>
> Here is the snippet of the core dump
>
> (gdb) py-bt
> Traceback (most recent call first):
>    File "/usr/lib/python3.7/threading.py", line 1048, in
> _wait_for_tstate_lock
>      elif lock.acquire(block, timeout):
>    File "/usr/lib/python3.7/threading.py", line 1032, in join
>      self._wait_for_tstate_lock()
>    File "/usr/lib/python3/dist-packages/h.py", line 231, in JoinThreads
>      self.TT.join()
>    File "/usr/sbin/c", line 1466, in do_exit
>      H.JoinThreads()
>    File "/usr/sbin/c", line 7201, in main
>      do_exit(nlm, status)
>    File "/usr/sbin/c", line 7233, in <module>
>      main()
> (gdb)
>
> On a parallel note, thanks to Kienan who has been trying to provide
> pointers on various issues reported so far.
>
> Need help on this issue as well.
> Thanks in advance,
>
> Regards,
> Lakshmi
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&data=3D05%7C02%7Claks=
d%40nvidia.com%7Cbdf064d348474249f14a08dc2ca755c9%7C43083d15727340c1b7db39e=
fd9ccc17a%7C0%7C0%7C638434344447880631%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=
=3D2iVi8xLrTS1Dj%2FcF3V30q0OjCvMP4kTpOUSthJvnZI0%3D&reserved=3D0<https://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>

--_000_MW3PR12MB4555080ACAE20ED17F263B8CD94F2MW3PR12MB4555namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Yes. We are trying to join only the threads related to the application. The=
 timeout is happening while trying to join the threads started by the appli=
cation. &nbsp;&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Lakshmi</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kienan Stewart &lt;ks=
tewart@efficios.com&gt;<br>
<b>Sent:</b> 13 February 2024 20:50<br>
<b>To:</b> Lakshmi Deverkonda &lt;laksd@nvidia.com&gt;; lttng-dev@lists.ltt=
ng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> Re: [lttng-dev] Crash in application due to watchdog timeou=
t with python3 lttng</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">External email: Use caution opening links or attac=
hments<br>
<br>
<br>
Hi Lakshmi,<br>
<br>
when the lttngust python agent starts, it attempts to connect to one or<br>
more session daemons[1].<br>
<br>
Each connection starts a thread that loops forever, retrying the<br>
registration in case an exception occurs[2].<br>
<br>
I don't think the it's designed to have `join()` called on those<br>
threads, which I assume is happening in some of the code you or your<br>
team have written.<br>
<br>
My initial thought is that you should `join()` only the threads that<br>
pertinent to your application, ignoring the lttngust agent threads and<br>
then exit the application as normal.<br>
<br>
[1]:<br>
<a href=3D"https://github.com/lttng/lttng-ust/blob/3287f48be61ef3491aff0a80=
b7185ac57b3d8a5d/src/python-lttngust/lttngust/agent.py#L334">https://nam11.=
safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2Flttng%2F=
lttng-ust%2Fblob%2F3287f48be61ef3491aff0a80b7185ac57b3d8a5d%2Fsrc%2Fpython-=
lttngust%2Flttngust%2Fagent.py%23L334&amp;data=3D05%7C02%7Claksd%40nvidia.c=
om%7Cbdf064d348474249f14a08dc2ca755c9%7C43083d15727340c1b7db39efd9ccc17a%7C=
0%7C0%7C638434344447867621%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ=
IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&amp;sdata=3D7tmpFtj=
l7RkTVgYLr2YjdlPs2oM1F%2FXOg6W51mHDCws%3D&amp;reserved=3D0</a><br>
[2]:<br>
<a href=3D"https://github.com/lttng/lttng-ust/blob/3287f48be61ef3491aff0a80=
b7185ac57b3d8a5d/src/python-lttngust/lttngust/agent.py#L83">https://nam11.s=
afelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2Flttng%2Fl=
ttng-ust%2Fblob%2F3287f48be61ef3491aff0a80b7185ac57b3d8a5d%2Fsrc%2Fpython-l=
ttngust%2Flttngust%2Fagent.py%23L83&amp;data=3D05%7C02%7Claksd%40nvidia.com=
%7Cbdf064d348474249f14a08dc2ca755c9%7C43083d15727340c1b7db39efd9ccc17a%7C0%=
7C0%7C638434344447874777%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&amp;sdata=3DPKb8rKDWF=
KmuuVB4YQEL8ZtAP%2B%2BYfTniUuLN9fFBctc%3D&amp;reserved=3D0</a><br>
<br>
thanks,<br>
kienan<br>
<br>
On 2/13/24 09:23, Lakshmi Deverkonda via lttng-dev wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; We are able to integrate python3 lttng module in our application(pytho=
n3<br>
&gt; based). However, we are seeing that whenever the application terminate=
s,<br>
&gt; there is watchdog timeout due to timeout in joining the threads. What<=
br>
&gt; could be the reason for this ? Does lttng module hold any thread event=
<br>
&gt; locks ?<br>
&gt; We are completely blocked on this issue. Could you please help ?<br>
&gt;<br>
&gt; Here is the snippet of the core dump<br>
&gt;<br>
&gt; (gdb) py-bt<br>
&gt; Traceback (most recent call first):<br>
&gt;&nbsp;&nbsp;&nbsp; File &quot;/usr/lib/python3.7/threading.py&quot;, li=
ne 1048, in<br>
&gt; _wait_for_tstate_lock<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; elif lock.acquire(block, timeout):<br>
&gt;&nbsp;&nbsp;&nbsp; File &quot;/usr/lib/python3.7/threading.py&quot;, li=
ne 1032, in join<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self._wait_for_tstate_lock()<br>
&gt;&nbsp;&nbsp;&nbsp; File &quot;/usr/lib/python3/dist-packages/h.py&quot;=
, line 231, in JoinThreads<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.TT.join()<br>
&gt;&nbsp;&nbsp;&nbsp; File &quot;/usr/sbin/c&quot;, line 1466, in do_exit<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; H.JoinThreads()<br>
&gt;&nbsp;&nbsp;&nbsp; File &quot;/usr/sbin/c&quot;, line 7201, in main<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_exit(nlm, status)<br>
&gt;&nbsp;&nbsp;&nbsp; File &quot;/usr/sbin/c&quot;, line 7233, in &lt;modu=
le&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; main()<br>
&gt; (gdb)<br>
&gt;<br>
&gt; On a parallel note, thanks to Kienan who has been trying to provide<br=
>
&gt; pointers on various issues reported so far.<br>
&gt;<br>
&gt; Need help on this issue as well.<br>
&gt; Thanks in advance,<br>
&gt;<br>
&gt; Regards,<br>
&gt; Lakshmi<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.=
lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev&amp;data=3D05%7C02%7Cl=
aksd%40nvidia.com%7Cbdf064d348474249f14a08dc2ca755c9%7C43083d15727340c1b7db=
39efd9ccc17a%7C0%7C0%7C638434344447880631%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&amp;=
sdata=3D2iVi8xLrTS1Dj%2FcF3V30q0OjCvMP4kTpOUSthJvnZI0%3D&amp;reserved=3D0</=
a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MW3PR12MB4555080ACAE20ED17F263B8CD94F2MW3PR12MB4555namp_--

--===============6748333623123689776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6748333623123689776==--
