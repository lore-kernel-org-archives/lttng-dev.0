Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8584C4332F
	for <lttng-dev@archiver.kernel.org>; Wed, 14 Dec 2022 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1671049220;
	bh=R4Agy7GolJ+FPATDPZO1XD2pJ55Y9/MCFmST2nppkmE=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SVLFzcKupPo9tkGu8Qca8st5MtaSaYC3yl+EBAUoh+vWXiagrkz0IWkrk2OpsNp/c
	 XWGQOnf+TKMxL9nUuACMilrtxLFafF9qn/e/CADZDp+DS9YfZbmNhylQIrc4ZvZ0Wf
	 ymjFa3FwqK7g4Eol/p61kJAMapIKa7h9EwrUqAGWONESQk6tPGmTFn6/0fJgcdcHVC
	 AjtdzhtBx/twzk5tkvUAwx70iRy8rrSKElfSjSJQkD9ERGL9XPRi8J8oCmCQtKvdAt
	 WKIQtOe1BIVoRnmSPq9b/PA+VMWR1K7+hgnkP/i6J5D3wAnCoN9dCgHmgeJFLg36jN
	 hrrrCihf6rfQQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NXRYv64RJzT9P;
	Wed, 14 Dec 2022 15:20:17 -0500 (EST)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2076.outbound.protection.outlook.com [40.107.116.76])
 by lists.lttng.org (Postfix) with ESMTPS id 4NXRYq6bMmz1DQF
 for <lttng-dev@lists.lttng.org>; Wed, 14 Dec 2022 15:20:15 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3TXBjlP5uwJJjb+DFfLr5A7tGc56nxlUl7yl+1ISU6hZO6PnoMy85vBDjOp6fP5t5zjG0KpT5Du8URflWkrTFN2sQ1oR/o1qt8s1Np4AVzrAj6utaZBRLL0QUF1NBO3hPVBLJRZGyNs4yENMApFO2WlU649PDbokhPVCOAI8Om2p8DhwaMAILHBD+oaoZZ7MVEVILiJMgC2TDyLD/XqxlJ7Sgo90HUqtLOFnQMC5UTExK1617ObFjGxXDgt0Rm/Zkyj951Y7T6qERxktzKf2JknCkS3I15WX9VfYX6ZaumkvLY8kWLj2SxWs/VJtQL+fgdV+7mZ4S6+VpLPZxh0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp7I5r7dFSx7rDeJN48pI6tHvdcYmb48eHvyrIAeXVU=;
 b=ZsUJyYEiegLIACYs2p9vwXwkDqbW0axMSM7wmah4jVqamJXkzvcPMlw6nzqFq9478E7iqIVn9/PVU5DK1Km4JOTffpb+mOTs6fgYVwWc3IUy56At7DNkywSdG0wZUYUFS9X+1nnsaTm5xNqFkmRhvxbznaF/Lb+37Bv36J0tFzVIUsvBwbY0VfaU2xORAQNOoTr6cQz7XwooIpXHuUcJh7P+hre88wqPEJXFiq0OYw4eXDcPeNiPMToYTovIW+tVl9GRB2mozauo7YGrgKSjOi5TFikr9K4m1d50cSOsphkDRpIqQsD5mDGa1/Me98l7f3PES7befTTbYgr+t2SKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YQXPR01MB6268.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:20:08 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::eed5:b4fc:c863:b2a]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::eed5:b4fc:c863:b2a%7]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 20:20:08 +0000
To: Alistair Francis <alistair.francis@opensource.wdc.com>, Alistair Francis
 <alistair23@gmail.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] [PATCH v2] Tests: select_poll_epoll: Add support for
 _time64
Thread-Index: AQHY6g8aVPHrj85HnEOIWGAQavFTk65rjgmAgAKQG9M=
Date: Wed, 14 Dec 2022 20:20:08 +0000
Message-ID: <YT2PR01MB598408FB1F15EAE0FDF96E3FBCE09@YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM>
References: <20221027055428.406908-1-alistair.francis@opensource.wdc.com>
 <CAKmqyKO2Kv72-c98_nC-Aprf8gFUJYrW1=kUkhf7B=cHMwmdtQ@mail.gmail.com>
In-Reply-To: <CAKmqyKO2Kv72-c98_nC-Aprf8gFUJYrW1=kUkhf7B=cHMwmdtQ@mail.gmail.com>
Accept-Language: en-CA, en-GB, fr-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB5984:EE_|YQXPR01MB6268:EE_
x-ms-office365-filtering-correlation-id: 1a73e944-8847-4299-c347-08dade10985b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aFxnHsmkIX0usESk5aCnWAzZP0udf+dezBiWhiJddB6BBTVlT9MAnfvwLc1UsdHMfIG1N+L/c5f9yp5mpEUUQLzHGKe1FcBiKTt9OxZkzAq8zrsl7GCIyHk2Um98J6hXJ7Jqc3y34c5YkqZsL+4Y+lD0L6r1NMmmt3hVHIBhLU70T6nAokWGxuKuWhaa6tw7xWIdxbdDVMy1hR3KfzksHr9xtCOPNLaa5aKKkJQdncuYferJ/SkfFcDlwnXxouNKUjMJup6AQ3iVqcZ3V8qWqsjHvLsKyIErJGqAkRaPxHpg23ayHk4UusEnJsOFTQh9qmMx5WFEmbwltMSU0J2RX4kSXB/Myi0iogRKqkt/WHiwJXturF8c9dAza9FAa/Ro0O6TX5zNeqmdtXnAoJoHKP2QEs5PGULZGKvWL68lgpsjma6q0Jv1jl3Ax/A2mgiLl72Dsp2NUAmwp4CT67r+rfO5y/C2CvUbRWlMOjusQLNAB+yfTtpprvmwxbFEX94UToNV/6kKPyYDn5brm8xv2qVa9IyqbdrmAm/bThnIDoMD6Q8Fx4dRb9372ESQZ3jTjXyazgKN9CnHqcM5+0n4znPE/bMcVnjRPWCo2oMrCL5dP+9EkmEVJgwrA+QsWEOWm1+5VsRz0VjsTIjNxwR2KiYS4BPnTUgzff9P0E6N3sd0MkzA4MXdxZ0/Sdr6Zmeqi6j1PfzJtkd0QYe3Fqa7qz/sNVF83NqHtDYLRrgdRcSgwl6O3stphcJI0fxA4+o5GP1P36LYS36cd3WuoTu8Jw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(39830400003)(136003)(346002)(376002)(366004)(396003)(451199015)(52536014)(41300700001)(38070700005)(5660300002)(8936002)(33656002)(86362001)(9686003)(71200400001)(478600001)(76116006)(966005)(6506007)(64756008)(7696005)(91956017)(66946007)(4326008)(66556008)(66446008)(8676002)(53546011)(66476007)(316002)(66574015)(19627405001)(26005)(110136005)(55016003)(83380400001)(30864003)(38100700002)(122000001)(2906002)(166002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ECLSTY0ctGANLJySRgzJci+OVWjgrB5jWsuJgEP67hIgbl4zMWHe0NqvhC?=
 =?iso-8859-1?Q?lPit4dWj8mTGw7F/bAJMn5dS5PMsYgVb6dhqjmZwAXEtqNnUYy2bbQBUIr?=
 =?iso-8859-1?Q?BdkJHKmEwyhQOdj5lL3vDD1C0XgBVzlHa6MSFnKWA3WpViofK1IP0rSVKg?=
 =?iso-8859-1?Q?1ApM+4kiVCwHDSykomPYSRDUps4LSm5n/CVcZruO/RCMlbQoRCRMOtnI+V?=
 =?iso-8859-1?Q?QBCpjnb7nBMd/olOqPVWvLQLcX9ryGAmnZmCUW8dtK9vDfRDg3DnUnSnkC?=
 =?iso-8859-1?Q?Jy7srJ0RemFMa1aunlzF4b5d41jZ9NP1vZlLNPKiTI8qjEHg7nWZt+moNr?=
 =?iso-8859-1?Q?2kEHMZhpsvKmNT4BzJeql+k0h8yk9ssZwofldnj0xNlZBZYAwWJxT6waU3?=
 =?iso-8859-1?Q?jwng9+AVeEfsopIvHa5pE+zjrlaBEfXGKSvb00C4WuJprgsH/vr0nJVRnF?=
 =?iso-8859-1?Q?G6KQ6rBBbG4nH+CRllrFIK0Pf/VweVyDEym2WlrEw320mS4oNOwDsdolEq?=
 =?iso-8859-1?Q?/WGfnnE2QelZ9bw+6NL2fwWZzwKSJvpNv7USrOryoYWOC1Kuv5yt4MtInf?=
 =?iso-8859-1?Q?PlpWU4l8gSFBX8nJlCjBUXFtNo+edsZ6t6z8qTOxOyEbLTVfPUpotkmvq+?=
 =?iso-8859-1?Q?YtyIqFEvfFGKoGxBp+KsPXwjewwscg3vcIKgMI59yDtjATRWmW6IWyqOy7?=
 =?iso-8859-1?Q?KMjPL+69heDQityglnh7Z7WI3LWnsvPiRrFlDA5HKT73URqdH8XuosvfRE?=
 =?iso-8859-1?Q?J+0oisjcOWJ25ZmnOQV3/qzDvBAW/s4c6W5lhYjBmv8jfjEJH//u6ElMWf?=
 =?iso-8859-1?Q?B9jl/EAT1EX+94LIWsj7hgBT0t/kKHwTWIFAE+V65/UeHWNHv4KQae8vb7?=
 =?iso-8859-1?Q?srOVuNYA9alY/ZrKFhhSLae7QqC0RXIUZatYau30O6PCQKcufz+9cYUuSE?=
 =?iso-8859-1?Q?z6iWdN8Vy3Ium5OuxmhvdoQ4c7TCSFsD7tzj2unbj40APRyghGILQ8TASB?=
 =?iso-8859-1?Q?pX0nniVS0xCeCEgW8zK4xTccr3uulbXMI97y5P3b1aphVFe16RtNjQ1lz/?=
 =?iso-8859-1?Q?4kNfXd3BZlAskaq3JMhY7dFqbiG0LmobRNDuv7yU3jvzJryLLgx9XHNryY?=
 =?iso-8859-1?Q?k9U56KSyztfR4epFMGiFX3KNfPjWPqL3gqrEhxBd5Q85AbE2Waxm1DhkX/?=
 =?iso-8859-1?Q?Paq6MCN96+jJpt6wTyU167JF8+YjbFs+jZ7kAYH2yXB/EhC/iqhPT4JjM4?=
 =?iso-8859-1?Q?xfJcA0TJW4r248tZd+nW/UnYkH6gvorT/HQLnXFof5Wg87dAQSC3Q6vb9r?=
 =?iso-8859-1?Q?WzwXnTsvtLiSLI2fE23J4OaWZqfKAE/zAuhLVpLk6vH457wUJVxa6Ya/xg?=
 =?iso-8859-1?Q?gnB1TP3v8+0omDwJ2xwUcySRimywekS7y/UanW4NO++BuoqnWAZrgFDlcK?=
 =?iso-8859-1?Q?mAPBMFqWju74jhKWg1UVe98mN1oA5QUpPHtrxZOm+zBYx++04HCQt4hk1I?=
 =?iso-8859-1?Q?zBaAITJ3IoOwrJMllSq0Bk2PkD03EG9QQEeU8WKEPMVEkVp4yTsn2YhQR2?=
 =?iso-8859-1?Q?6xF4PjdSCbpNDlF+SQ5g95k3qgkdx8tPoIdrsxp4vbIH+xM9lVzeABRh4X?=
 =?iso-8859-1?Q?1wBRhGMGWifYo+eUGK8P0fnVy26DZs+u5l?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a73e944-8847-4299-c347-08dade10985b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 20:20:08.3183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLVBo5SDkyPxNkuXsjZSLDUWN4UBVzFm0fgy3gTVcBr0Y93NYGp5o2A2ugbwMm2Nw83K/7qpS1F0TYBKn8pHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6268
Subject: Re: [lttng-dev] [PATCH v2] Tests: select_poll_epoll: Add support
 for _time64
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
Content-Type: multipart/mixed; boundary="===============8385060106106983395=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8385060106106983395==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_YT2PR01MB598408FB1F15EAE0FDF96E3FBCE09YT2PR01MB5984CANP_"

--_000_YT2PR01MB598408FB1F15EAE0FDF96E3FBCE09YT2PR01MB5984CANP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

The patch you submitted doesn't pass on x86 and x86-64.

I have written an alternative patch that works on the 32/64 variants of ARM=
 and x86. I could only verify that it builds on RISC-V 64.

Are you able to compile-test it on RISC-V 32?

https://review.lttng.org/c/lttng-tools/+/8907

Thanks,
J=E9r=E9mie


--
J=E9r=E9mie Galarneau
EfficiOS Inc.
https://www.efficios.com
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Alistair F=
rancis via lttng-dev <lttng-dev@lists.lttng.org>
Sent: December 13, 2022 00:09
To: Alistair Francis <alistair.francis@opensource.wdc.com>
Cc: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [PATCH v2] Tests: select_poll_epoll: Add support f=
or _time64

On Thu, Oct 27, 2022 at 3:54 PM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Add support for the  64-bit time_t syscalls SYS_ppoll_time64
> and SYS_pselect6_time64.
>
> These are the syscalls that exist 32-bit platforms since the 5.1 kernel.
> 32-bit platforms with a 64-bit time_t only have these and don't have the
> original syscalls (such as 32-bit RISC-V).
>
> Fixes: https://github.com/lttng/lttng-tools/pull/162
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Ping!

Alistair

> ---
> To keep the test_cases[] array clean I have implemented the functions
> for all builds, but the functions are a no-op if the syscall is missing.
>
> v2:
>  - Split out a seperate _time64 test
>
>  tests/regression/kernel/select_poll_epoll.cpp | 184 ++++++++++++++++++
>  1 file changed, 184 insertions(+)
>
> diff --git a/tests/regression/kernel/select_poll_epoll.cpp b/tests/regres=
sion/kernel/select_poll_epoll.cpp
> index c0b688217..dfaab52c8 100644
> --- a/tests/regression/kernel/select_poll_epoll.cpp
> +++ b/tests/regression/kernel/select_poll_epoll.cpp
> @@ -5,6 +5,7 @@
>   *
>   */
>
> +#include <errno.h>
>  #include <fcntl.h>
>  #include <limits.h>
>  #include <poll.h>
> @@ -48,10 +49,14 @@ int lttng_opt_quiet, lttng_opt_verbose, lttng_opt_mi;
>
>  static void run_working_cases(FILE *validation_output_file);
>  static void pselect_invalid_fd(FILE *validation_output_file);
> +static void pselect_time64_invalid_fd(FILE *validation_output_file);
>  static void test_ppoll_big(FILE *validation_output_file);
>  static void ppoll_fds_buffer_overflow(FILE *validation_output_file);
> +static void ppoll_time64_fds_buffer_overflow(FILE *validation_output_fil=
e);
>  static void pselect_invalid_pointer(FILE *validation_output_file);
> +static void pselect_time64_invalid_pointer(FILE *validation_output_file)=
;
>  static void ppoll_fds_ulong_max(FILE *validation_output_file);
> +static void ppoll_time64_fds_ulong_max(FILE *validation_output_file);
>  static void epoll_pwait_invalid_pointer(FILE *validation_output_file);
>  static void epoll_pwait_int_max(FILE *validation_output_file);
>  static void ppoll_concurrent_write(FILE *validation_output_file);
> @@ -69,10 +74,14 @@ const struct test_case {
>         { .run =3D run_working_cases, .produces_validation_info =3D true,=
 .timeout =3D -1 },
>         { .run =3D run_working_cases, .produces_validation_info =3D true,=
 .timeout =3D 1 },
>         { .run =3D pselect_invalid_fd, .produces_validation_info =3D fals=
e, .timeout =3D 0 },
> +       { .run =3D pselect_time64_invalid_fd, .produces_validation_info =
=3D false, .timeout =3D 0 },
>         { .run =3D test_ppoll_big, .produces_validation_info =3D false, .=
timeout =3D 0 },
>         { .run =3D ppoll_fds_buffer_overflow, .produces_validation_info =
=3D false, .timeout =3D 0 },
> +       { .run =3D ppoll_time64_fds_buffer_overflow, .produces_validation=
_info =3D false, .timeout =3D 0 },
>         { .run =3D pselect_invalid_pointer, .produces_validation_info =3D=
 false, .timeout =3D 0 },
> +       { .run =3D pselect_time64_invalid_pointer, .produces_validation_i=
nfo =3D false, .timeout =3D 0 },
>         { .run =3D ppoll_fds_ulong_max, .produces_validation_info =3D fal=
se, .timeout =3D 0 },
> +       { .run =3D ppoll_time64_fds_ulong_max, .produces_validation_info =
=3D false, .timeout =3D 0 },
>         { .run =3D epoll_pwait_invalid_pointer, .produces_validation_info=
 =3D true, .timeout =3D 0 },
>         { .run =3D epoll_pwait_int_max, .produces_validation_info =3D tru=
e, .timeout =3D 0 },
>         { .run =3D ppoll_concurrent_write, .produces_validation_info =3D =
false, .timeout =3D 0 },
> @@ -440,6 +449,44 @@ end:
>         return;
>  }
>
> +/*
> + * Ask for 100 FDs in a buffer for allocated for only 1 FD, should
> + * segfault (eventually with a "*** stack smashing detected ***" message=
).
> + * The event should contain an array of 100 FDs filled with garbage.
> + */
> +static
> +void ppoll_time64_fds_buffer_overflow(
> +               FILE *validation_output_file __attribute__((unused)))
> +{
> +#ifdef SYS_ppoll_time64
> +       struct pollfd ufds[NB_FD];
> +       char buf[BUF_SIZE];
> +       int ret;
> +
> +       ufds[0].fd =3D wait_fd;
> +       ufds[0].events =3D POLLIN|POLLPRI;
> +
> +       /*
> +        * As there is no timeout value, we don't convert to/from
> +        * 64/32-bit time_t.
> +        */
> +       ret =3D syscall(SYS_ppoll_time64, ufds, 100, NULL, NULL);
> +       /*
> +        * There is no fallback to SYS_ppoll, we expect SYS_ppoll_time64
> +        * to work and if it doesn't we fail.
> +        */
> +
> +       if (ret < 0) {
> +               PERROR("ppoll_time64");
> +       } else if (ret > 0) {
> +               ret =3D read(wait_fd, buf, BUF_SIZE);
> +               if (ret < 0) {
> +                       PERROR("[ppoll_time64] read");
> +               }
> +       }
> +#endif
> +}
> +
>  /*
>   * Ask for 100 FDs in a buffer for allocated for only 1 FD, should
>   * segfault (eventually with a "*** stack smashing detected ***" message=
).
> @@ -449,6 +496,7 @@ static
>  void ppoll_fds_buffer_overflow(
>                 FILE *validation_output_file __attribute__((unused)))
>  {
> +#ifdef SYS_ppoll
>         struct pollfd ufds[NB_FD];
>         char buf[BUF_SIZE];
>         int ret;
> @@ -466,6 +514,46 @@ void ppoll_fds_buffer_overflow(
>                         PERROR("[ppoll] read");
>                 }
>         }
> +#endif
> +}
> +
> +/*
> + * Ask for ULONG_MAX FDs in a buffer for allocated for only 1 FD, should
> + * cleanly fail with a "Invalid argument".
> + * The event should contain an empty array of FDs and overflow =3D 1.
> + */
> +static
> +void ppoll_time64_fds_ulong_max(FILE *validation_output_file __attribute=
__((unused)))
> +{
> +#ifdef SYS_ppoll_time64
> +       struct pollfd ufds[NB_FD];
> +       char buf[BUF_SIZE];
> +       int ret;
> +
> +       ufds[0].fd =3D wait_fd;
> +       ufds[0].events =3D POLLIN|POLLPRI;
> +
> +       /*
> +        * As there is no timeout value, we don't convert to/from
> +        * 64/32-bit time_t.
> +        */
> +       ret =3D syscall(SYS_ppoll_time64, ufds, ULONG_MAX, NULL, NULL);
> +       /*
> +        * There is no fallback to SYS_ppoll, we expect SYS_ppoll_time64
> +        * to work and if it doesn't we fail.
> +        */
> +
> +       if (ret < 0 && errno !=3D ENOSYS) {
> +               /* Expected error. */
> +       } else if (errno =3D=3D ENOSYS) {
> +               PERROR("[ppoll_time64] missing syscall");
> +       } else if (ret > 0) {
> +               ret =3D read(wait_fd, buf, BUF_SIZE);
> +               if (ret < 0) {
> +                       PERROR("[ppoll_time64] read");
> +               }
> +       }
> +#endif
>  }
>
>  /*
> @@ -476,6 +564,7 @@ void ppoll_fds_buffer_overflow(
>  static
>  void ppoll_fds_ulong_max(FILE *validation_output_file __attribute__((unu=
sed)))
>  {
> +#ifdef SYS_ppoll
>         struct pollfd ufds[NB_FD];
>         char buf[BUF_SIZE];
>         int ret;
> @@ -492,6 +581,59 @@ void ppoll_fds_ulong_max(FILE *validation_output_fil=
e __attribute__((unused)))
>                         PERROR("[ppoll] read");
>                 }
>         }
> +#endif
> +}
> +
> +/*
> + * Pass an invalid file descriptor to pselect6(). The syscall should ret=
urn
> + * -EBADF. The recorded event should contain a "ret =3D -EBADF (-9)".
> + */
> +static
> +void pselect_time64_invalid_fd(FILE *validation_output_file __attribute_=
_((unused)))
> +{
> +#ifdef SYS_pselect6_time64
> +       fd_set rfds;
> +       int ret;
> +       int fd;
> +       char buf[BUF_SIZE];
> +
> +       /*
> +        * Open a file, close it and use the closed FD in the pselect6 ca=
ll.
> +        */
> +       fd =3D open("/dev/null", O_RDONLY);
> +       if (fd =3D=3D -1) {
> +               PERROR("open");
> +               goto error;
> +       }
> +
> +       ret =3D close(fd);
> +       if (ret =3D=3D -1) {
> +               PERROR("close");
> +               goto error;
> +       }
> +
> +       FD_ZERO(&rfds);
> +       FD_SET(fd, &rfds);
> +
> +       ret =3D syscall(SYS_pselect6_time64, fd + 1, &rfds, NULL, NULL, N=
ULL, NULL);
> +       /*
> +        * There is no fallback to SYS_pselect6, we expect SYS_pselect6_t=
ime64
> +        * to work and if it doesn't we fail.
> +        */
> +
> +       if (ret =3D=3D -1 && errno !=3D ENOSYS) {
> +               /* Expected error. */
> +       } else if (errno =3D=3D ENOSYS) {
> +               PERROR("[pselect_time64] missing syscall");
> +       } else if (ret) {
> +               ret =3D read(wait_fd, buf, BUF_SIZE);
> +               if (ret < 0) {
> +                       PERROR("[pselect_time64] read");
> +               }
> +       }
> +error:
> +       return;
> +#endif
>  }
>
>  /*
> @@ -501,6 +643,7 @@ void ppoll_fds_ulong_max(FILE *validation_output_file=
 __attribute__((unused)))
>  static
>  void pselect_invalid_fd(FILE *validation_output_file __attribute__((unus=
ed)))
>  {
> +#ifdef SYS_pselect6
>         fd_set rfds;
>         int ret;
>         int fd;
> @@ -525,6 +668,7 @@ void pselect_invalid_fd(FILE *validation_output_file =
__attribute__((unused)))
>         FD_SET(fd, &rfds);
>
>         ret =3D syscall(SYS_pselect6, fd + 1, &rfds, NULL, NULL, NULL, NU=
LL);
> +
>         if (ret =3D=3D -1) {
>                 /* Expected error. */
>         } else if (ret) {
> @@ -535,6 +679,44 @@ void pselect_invalid_fd(FILE *validation_output_file=
 __attribute__((unused)))
>         }
>  error:
>         return;
> +#endif
> +}
> +
> +/*
> + * Invalid pointer as writefds, should output a ppoll event
> + * with 0 FDs.
> + */
> +static
> +void pselect_time64_invalid_pointer(
> +               FILE *validation_output_file __attribute__((unused)))
> +{
> +#ifdef SYS_pselect6_time64
> +       fd_set rfds;
> +       int ret;
> +       char buf[BUF_SIZE];
> +       void *invalid =3D (void *) 0x42;
> +
> +       FD_ZERO(&rfds);
> +       FD_SET(wait_fd, &rfds);
> +
> +       ret =3D syscall(SYS_pselect6_time64, 1, &rfds, (fd_set *) invalid=
, NULL, NULL,
> +                       NULL);
> +       /*
> +        * There is no fallback to SYS_pselect6, we expect SYS_pselect6_t=
ime64
> +        * to work and if it doesn't we fail.
> +        */
> +
> +       if (ret =3D=3D -1 && errno !=3D ENOSYS) {
> +               /* Expected error. */
> +       } else if (errno =3D=3D ENOSYS) {
> +               PERROR("[pselect_time64] missing syscall");
> +       } else if (ret) {
> +               ret =3D read(wait_fd, buf, BUF_SIZE);
> +               if (ret < 0) {
> +                       PERROR("[pselect_time64] read");
> +               }
> +       }
> +#endif
>  }
>
>  /*
> @@ -545,6 +727,7 @@ static
>  void pselect_invalid_pointer(
>                 FILE *validation_output_file __attribute__((unused)))
>  {
> +#ifdef SYS_pselect6
>         fd_set rfds;
>         int ret;
>         char buf[BUF_SIZE];
> @@ -563,6 +746,7 @@ void pselect_invalid_pointer(
>                         PERROR("[pselect] read");
>                 }
>         }
> +#endif
>  }
>
>  /*
> --
> 2.37.3
>
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--_000_YT2PR01MB598408FB1F15EAE0FDF96E3FBCE09YT2PR01MB5984CANP_
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
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">Hi Alistair,</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">The patch you submitted do=
esn't pass on x86 and x86-64.</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">I have written an alternat=
ive patch that works on the 32/64 variants
 of ARM and x86. I could only verify that it builds on RISC-V 64.</span></d=
iv>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">Are you able to compile-te=
st it on RISC-V 32?</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof ContentPasted0"><a href=3D"=
https://review.lttng.org/c/lttng-tools/+/8907" id=3D"LPlnk816749">https://r=
eview.lttng.org/c/lttng-tools/+/8907</a><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">Thanks,</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">J=E9r=E9mie</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof"><br>
</span></div>
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
<a href=3D"https://www.efficios.com">https://www.efficios.com</a><br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of Alistair Francis via lttng-dev =
&lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> December 13, 2022 00:09<br>
<b>To:</b> Alistair Francis &lt;alistair.francis@opensource.wdc.com&gt;<br>
<b>Cc:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> Re: [lttng-dev] [PATCH v2] Tests: select_poll_epoll: Add su=
pport for _time64</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Oct 27, 2022 at 3:54 PM Alistair Francis<b=
r>
&lt;alistair.francis@opensource.wdc.com&gt; wrote:<br>
&gt;<br>
&gt; From: Alistair Francis &lt;alistair.francis@wdc.com&gt;<br>
&gt;<br>
&gt; Add support for the&nbsp; 64-bit time_t syscalls SYS_ppoll_time64<br>
&gt; and SYS_pselect6_time64.<br>
&gt;<br>
&gt; These are the syscalls that exist 32-bit platforms since the 5.1 kerne=
l.<br>
&gt; 32-bit platforms with a 64-bit time_t only have these and don't have t=
he<br>
&gt; original syscalls (such as 32-bit RISC-V).<br>
&gt;<br>
&gt; Fixes: <a href=3D"https://github.com/lttng/lttng-tools/pull/162">https=
://github.com/lttng/lttng-tools/pull/162</a><br>
&gt; Signed-off-by: Alistair Francis &lt;alistair.francis@wdc.com&gt;<br>
<br>
Ping!<br>
<br>
Alistair<br>
<br>
&gt; ---<br>
&gt; To keep the test_cases[] array clean I have implemented the functions<=
br>
&gt; for all builds, but the functions are a no-op if the syscall is missin=
g.<br>
&gt;<br>
&gt; v2:<br>
&gt;&nbsp; - Split out a seperate _time64 test<br>
&gt;<br>
&gt;&nbsp; tests/regression/kernel/select_poll_epoll.cpp | 184 ++++++++++++=
++++++<br>
&gt;&nbsp; 1 file changed, 184 insertions(+)<br>
&gt;<br>
&gt; diff --git a/tests/regression/kernel/select_poll_epoll.cpp b/tests/reg=
ression/kernel/select_poll_epoll.cpp<br>
&gt; index c0b688217..dfaab52c8 100644<br>
&gt; --- a/tests/regression/kernel/select_poll_epoll.cpp<br>
&gt; +++ b/tests/regression/kernel/select_poll_epoll.cpp<br>
&gt; @@ -5,6 +5,7 @@<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; */<br>
&gt;<br>
&gt; +#include &lt;errno.h&gt;<br>
&gt;&nbsp; #include &lt;fcntl.h&gt;<br>
&gt;&nbsp; #include &lt;limits.h&gt;<br>
&gt;&nbsp; #include &lt;poll.h&gt;<br>
&gt; @@ -48,10 +49,14 @@ int lttng_opt_quiet, lttng_opt_verbose, lttng_opt_=
mi;<br>
&gt;<br>
&gt;&nbsp; static void run_working_cases(FILE *validation_output_file);<br>
&gt;&nbsp; static void pselect_invalid_fd(FILE *validation_output_file);<br=
>
&gt; +static void pselect_time64_invalid_fd(FILE *validation_output_file);<=
br>
&gt;&nbsp; static void test_ppoll_big(FILE *validation_output_file);<br>
&gt;&nbsp; static void ppoll_fds_buffer_overflow(FILE *validation_output_fi=
le);<br>
&gt; +static void ppoll_time64_fds_buffer_overflow(FILE *validation_output_=
file);<br>
&gt;&nbsp; static void pselect_invalid_pointer(FILE *validation_output_file=
);<br>
&gt; +static void pselect_time64_invalid_pointer(FILE *validation_output_fi=
le);<br>
&gt;&nbsp; static void ppoll_fds_ulong_max(FILE *validation_output_file);<b=
r>
&gt; +static void ppoll_time64_fds_ulong_max(FILE *validation_output_file);=
<br>
&gt;&nbsp; static void epoll_pwait_invalid_pointer(FILE *validation_output_=
file);<br>
&gt;&nbsp; static void epoll_pwait_int_max(FILE *validation_output_file);<b=
r>
&gt;&nbsp; static void ppoll_concurrent_write(FILE *validation_output_file)=
;<br>
&gt; @@ -69,10 +74,14 @@ const struct test_case {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D run_working=
_cases, .produces_validation_info =3D true, .timeout =3D -1 },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D run_working=
_cases, .produces_validation_info =3D true, .timeout =3D 1 },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D pselect_inv=
alid_fd, .produces_validation_info =3D false, .timeout =3D 0 },<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D pselect_time64_invali=
d_fd, .produces_validation_info =3D false, .timeout =3D 0 },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D test_ppoll_=
big, .produces_validation_info =3D false, .timeout =3D 0 },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D ppoll_fds_b=
uffer_overflow, .produces_validation_info =3D false, .timeout =3D 0 },<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D ppoll_time64_fds_buff=
er_overflow, .produces_validation_info =3D false, .timeout =3D 0 },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D pselect_inv=
alid_pointer, .produces_validation_info =3D false, .timeout =3D 0 },<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D pselect_time64_invali=
d_pointer, .produces_validation_info =3D false, .timeout =3D 0 },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D ppoll_fds_u=
long_max, .produces_validation_info =3D false, .timeout =3D 0 },<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D ppoll_time64_fds_ulon=
g_max, .produces_validation_info =3D false, .timeout =3D 0 },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D epoll_pwait=
_invalid_pointer, .produces_validation_info =3D true, .timeout =3D 0 },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D epoll_pwait=
_int_max, .produces_validation_info =3D true, .timeout =3D 0 },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .run =3D ppoll_concu=
rrent_write, .produces_validation_info =3D false, .timeout =3D 0 },<br>
&gt; @@ -440,6 +449,44 @@ end:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +/*<br>
&gt; + * Ask for 100 FDs in a buffer for allocated for only 1 FD, should<br=
>
&gt; + * segfault (eventually with a &quot;*** stack smashing detected ***&=
quot; message).<br>
&gt; + * The event should contain an array of 100 FDs filled with garbage.<=
br>
&gt; + */<br>
&gt; +static<br>
&gt; +void ppoll_time64_fds_buffer_overflow(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; FILE *validation_output_file __attribute__((unused)))<br>
&gt; +{<br>
&gt; +#ifdef SYS_ppoll_time64<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pollfd ufds[NB_FD];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf[BUF_SIZE];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ufds[0].fd =3D wait_fd;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ufds[0].events =3D POLLIN|POLLPR=
I;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * As there is no timeout v=
alue, we don't convert to/from<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 64/32-bit time_t.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D syscall(SYS_ppoll_time64=
, ufds, 100, NULL, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * There is no fallback to =
SYS_ppoll, we expect SYS_ppoll_time64<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to work and if it doesn'=
t we fail.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PERROR(&quot;ppoll_time64&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ret &gt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D read(wait_fd, buf, BUF_SIZE);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PERROR(&quo=
t;[ppoll_time64] read&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#endif<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; /*<br>
&gt;&nbsp;&nbsp; * Ask for 100 FDs in a buffer for allocated for only 1 FD,=
 should<br>
&gt;&nbsp;&nbsp; * segfault (eventually with a &quot;*** stack smashing det=
ected ***&quot; message).<br>
&gt; @@ -449,6 +496,7 @@ static<br>
&gt;&nbsp; void ppoll_fds_buffer_overflow(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; FILE *validation_output_file __attribute__((unuse=
d)))<br>
&gt;&nbsp; {<br>
&gt; +#ifdef SYS_ppoll<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pollfd ufds[NB_=
FD];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf[BUF_SIZE];<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; @@ -466,6 +514,46 @@ void ppoll_fds_buffer_overflow(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P=
ERROR(&quot;[ppoll] read&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#endif<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Ask for ULONG_MAX FDs in a buffer for allocated for only 1 FD, sho=
uld<br>
&gt; + * cleanly fail with a &quot;Invalid argument&quot;.<br>
&gt; + * The event should contain an empty array of FDs and overflow =3D 1.=
<br>
&gt; + */<br>
&gt; +static<br>
&gt; +void ppoll_time64_fds_ulong_max(FILE *validation_output_file __attrib=
ute__((unused)))<br>
&gt; +{<br>
&gt; +#ifdef SYS_ppoll_time64<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pollfd ufds[NB_FD];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf[BUF_SIZE];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ufds[0].fd =3D wait_fd;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ufds[0].events =3D POLLIN|POLLPR=
I;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * As there is no timeout v=
alue, we don't convert to/from<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 64/32-bit time_t.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D syscall(SYS_ppoll_time64=
, ufds, ULONG_MAX, NULL, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * There is no fallback to =
SYS_ppoll, we expect SYS_ppoll_time64<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to work and if it doesn'=
t we fail.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0 &amp;&amp; errno =
!=3D ENOSYS) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Expected error. */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (errno =3D=3D ENOSYS) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PERROR(&quot;[ppoll_time64] missing syscall&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ret &gt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D read(wait_fd, buf, BUF_SIZE);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PERROR(&quo=
t;[ppoll_time64] read&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#endif<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; /*<br>
&gt; @@ -476,6 +564,7 @@ void ppoll_fds_buffer_overflow(<br>
&gt;&nbsp; static<br>
&gt;&nbsp; void ppoll_fds_ulong_max(FILE *validation_output_file __attribut=
e__((unused)))<br>
&gt;&nbsp; {<br>
&gt; +#ifdef SYS_ppoll<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pollfd ufds[NB_=
FD];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf[BUF_SIZE];<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; @@ -492,6 +581,59 @@ void ppoll_fds_ulong_max(FILE *validation_output_=
file __attribute__((unused)))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P=
ERROR(&quot;[ppoll] read&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#endif<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Pass an invalid file descriptor to pselect6(). The syscall should =
return<br>
&gt; + * -EBADF. The recorded event should contain a &quot;ret =3D -EBADF (=
-9)&quot;.<br>
&gt; + */<br>
&gt; +static<br>
&gt; +void pselect_time64_invalid_fd(FILE *validation_output_file __attribu=
te__((unused)))<br>
&gt; +{<br>
&gt; +#ifdef SYS_pselect6_time64<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd_set rfds;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf[BUF_SIZE];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Open a file, close it an=
d use the closed FD in the pselect6 call.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd =3D open(&quot;/dev/null&quot=
;, O_RDONLY);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fd =3D=3D -1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PERROR(&quot;open&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto error;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D close(fd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D -1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PERROR(&quot;close&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto error;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FD_ZERO(&amp;rfds);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FD_SET(fd, &amp;rfds);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D syscall(SYS_pselect6_tim=
e64, fd + 1, &amp;rfds, NULL, NULL, NULL, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * There is no fallback to =
SYS_pselect6, we expect SYS_pselect6_time64<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to work and if it doesn'=
t we fail.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D -1 &amp;&amp; err=
no !=3D ENOSYS) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Expected error. */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (errno =3D=3D ENOSYS) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PERROR(&quot;[pselect_time64] missing syscall&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D read(wait_fd, buf, BUF_SIZE);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PERROR(&quo=
t;[pselect_time64] read&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +error:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +#endif<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; /*<br>
&gt; @@ -501,6 +643,7 @@ void ppoll_fds_ulong_max(FILE *validation_output_f=
ile __attribute__((unused)))<br>
&gt;&nbsp; static<br>
&gt;&nbsp; void pselect_invalid_fd(FILE *validation_output_file __attribute=
__((unused)))<br>
&gt;&nbsp; {<br>
&gt; +#ifdef SYS_pselect6<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd_set rfds;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd;<br>
&gt; @@ -525,6 +668,7 @@ void pselect_invalid_fd(FILE *validation_output_fi=
le __attribute__((unused)))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FD_SET(fd, &amp;rfds);=
<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D syscall(SYS_ps=
elect6, fd + 1, &amp;rfds, NULL, NULL, NULL, NULL);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D -1) {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* Expected error. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ret) {<br>
&gt; @@ -535,6 +679,44 @@ void pselect_invalid_fd(FILE *validation_output_f=
ile __attribute__((unused)))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; error:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +#endif<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Invalid pointer as writefds, should output a ppoll event<br>
&gt; + * with 0 FDs.<br>
&gt; + */<br>
&gt; +static<br>
&gt; +void pselect_time64_invalid_pointer(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; FILE *validation_output_file __attribute__((unused)))<br>
&gt; +{<br>
&gt; +#ifdef SYS_pselect6_time64<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd_set rfds;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf[BUF_SIZE];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *invalid =3D (void *) 0x42;=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FD_ZERO(&amp;rfds);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FD_SET(wait_fd, &amp;rfds);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D syscall(SYS_pselect6_tim=
e64, 1, &amp;rfds, (fd_set *) invalid, NULL, NULL,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * There is no fallback to =
SYS_pselect6, we expect SYS_pselect6_time64<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to work and if it doesn'=
t we fail.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D -1 &amp;&amp; err=
no !=3D ENOSYS) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Expected error. */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (errno =3D=3D ENOSYS) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PERROR(&quot;[pselect_time64] missing syscall&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D read(wait_fd, buf, BUF_SIZE);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PERROR(&quo=
t;[pselect_time64] read&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#endif<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; /*<br>
&gt; @@ -545,6 +727,7 @@ static<br>
&gt;&nbsp; void pselect_invalid_pointer(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; FILE *validation_output_file __attribute__((unuse=
d)))<br>
&gt;&nbsp; {<br>
&gt; +#ifdef SYS_pselect6<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd_set rfds;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf[BUF_SIZE];<br=
>
&gt; @@ -563,6 +746,7 @@ void pselect_invalid_pointer(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P=
ERROR(&quot;[pselect] read&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#endif<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; /*<br>
&gt; --<br>
&gt; 2.37.3<br>
&gt;<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http=
s://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_YT2PR01MB598408FB1F15EAE0FDF96E3FBCE09YT2PR01MB5984CANP_--

--===============8385060106106983395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8385060106106983395==--
