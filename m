Return-Path: <SRS0=lmbG=E6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B9C2D0E4
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Nov 2020 21:33:22 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9491B206E0
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Nov 2020 21:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="CW5StY4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9491B206E0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CgchG60K2z1N5X;
	Tue, 24 Nov 2020 16:33:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606253600;
	bh=U/7xFjN7e9RaxCQo6UCYyRNca9qLVhWtoxqxVfpL2Y8=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CW5StY4lc2OOS1uGLyhObG1Vn8C5IbmIMcKvPRTgjbgjY/Sg7YPb2erwuOUIJNhai
	 hXGPUMNuY/lXUOg8PEKWsTnb8Ezr8LyS+dIdDOJdaVEG3tCINkQvZWh2x14aGiUdoP
	 MMATKB8s7C1uMKQCTDP/H6jg7OiWlPhI1a6PLB7QntcZ9TeXxSiDu28QaXF1qkzHbR
	 6Vp+mpcq5SKeEiFStDJgEIL/W5+uRfnzJu3OZ8YDfzjN6g+dRGmtrXHejrCivhEqiO
	 00j+r45FFtJ9j0Ux0LystO0gHNEO1InuPp660ChzNK/m/YKZjYQRKIK6cA5Wn9w97H
	 ebXwrRUhudW+w==
Received: from mx0a-0014fe01.pphosted.com (mx0a-0014fe01.pphosted.com
 [67.231.144.99])
 by lists.lttng.org (Postfix) with ESMTPS id 4CgchD4DZ0z1Ngq
 for <lttng-dev@lists.lttng.org>; Tue, 24 Nov 2020 16:33:16 -0500 (EST)
Received: from pps.filterd (m0099259.ppops.net [127.0.0.1])
 by mx0a-0014fe01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0AOKvAKG025785; Tue, 24 Nov 2020 14:02:42 -0700
Received: from mail.ballaerospace.com ([162.18.172.11])
 by mx0a-0014fe01.pphosted.com with ESMTP id 35185688jk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Tue, 24 Nov 2020 14:02:42 -0700
Received: from ex2016-co-03.AERO.BALL.COM (10.72.9.80) by
 ex2016-co-02.AERO.BALL.com (10.72.9.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.1466.3; Tue, 24 Nov 2020 14:02:41 -0700
Received: from ex2016-co-03.AERO.BALL.COM ([fe80::a55a:f7d9:c791:da55]) by
 ex2016-co-03.AERO.BALL.com ([fe80::a55a:f7d9:c791:da55%12]) with mapi id
 15.01.1466.003; Tue, 24 Nov 2020 14:02:41 -0700
To: 'Jonathan Rajotte-Julien' <jonathan.rajotte-julien@efficios.com>
CC: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
Thread-Topic: [EXTERNAL] Re: [lttng-dev] lttng 2.12 install
Thread-Index: Ada/Y4SGFTZ5vBbyTkeGMcaNOjy/7AARMrIAALtoxFAAEQjhAAANZ8CA
Date: Tue, 24 Nov 2020 21:02:41 +0000
Message-ID: <aefcb4673adb4b3980bb0612a81f8d87@ball.com>
References: <326539938460471c975e791ce6b1c775@ball.com>
 <20201120184746.GF8709@joraj-alpa>
 <8602eba582ba4806b5bf307cceef521d@ball.com>
 <20201124202138.GA769862@joraj-alpa>
In-Reply-To: <20201124202138.GA769862@joraj-alpa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcandlYmVyMVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTYzMmFiZTVlLTJlOTgtMTFlYi04MGQ4LTAwNTA1NmJiMzk0Y1xhbWUtdGVzdFw2MzJhYmU2MC0yZTk4LTExZWItODBkOC0wMDUwNTZiYjM5NGNib2R5LnR4dCIgc3o9IjU1MDUiIHQ9IjEzMjUwNzI1MzYwOTAwNDM5MiIgaD0iRjRHcGU1VkV0RVVzc3ZKclVYQzU1bXo4cTgwPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-originating-ip: [10.72.63.11]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-24_08:2020-11-24,
 2020-11-24 signatures=0
Subject: Re: [lttng-dev] [EXTERNAL] Re:  lttng 2.12 install
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
From: "Weber, John via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Weber, John" <jweber1@ball.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Ok, it I get what you're saying then I am modifying make on the command lin=
e while running make? Still the same problem. I don't think it is using the=
 gcc I am specifying as it continues to look in: /usr/src/kernels/3.10.0-11=
27.19.1.el7.x86_64/
And I suspect it is still seeing the OS version of gcc (4.8.5) instead of t=
he 6.3.1 provided by devtoolset-6.
Do you have some pixy dust??

----------------------------
John Weber
Ball Aerospace
ITS ND System Administrator =

10 Longs Peak Dr., Broomfield, CO 80021
C: 303-807-3608   P: 303-234-2103
E: jweber1@ball.com
=A0
=A0

=A0

=A0

-----Original Message-----
From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com> =

Sent: Tuesday, November 24, 2020 1:22 PM
To: Weber, John <jweber1@ball.com>
Cc: 'lttng-dev@lists.lttng.org' <lttng-dev@lists.lttng.org>
Subject: Re: [EXTERNAL] Re: [lttng-dev] lttng 2.12 install

Hi John,

AFAIK, you should be able to do so using something similar to the following:

  make CC=3D"your_compiler" HOSTCC=3D"your_compiler" ...

Cheers


On Tue, Nov 24, 2020 at 07:22:10PM +0000, Weber, John wrote:
> Hi, thanks for your reply. So, on my system there are 2 gcc's. one =

> installed by the OS and the other by installation of devtooset-6. Upon =

> checking the versions of both I have 4.8.5 installed by OS in /usr/bin =

> the other one from devtoolset is 6.3.1. Your reference to check =

> /proc/version shows that it sees 4.8.5. how can I manipulate the =

> install to use the gcc from /opt/rh/devtoolset-6/root/bin/gcc (which =

> is 6.3.1)
> =

> ----------------------------
> John Weber
> Ball Aerospace
> ITS ND System Administrator
> 10 Longs Peak Dr., Broomfield, CO 80021
> C: 303-807-3608   P: 303-234-2103
> E: jweber1@ball.com
> =A0
> =A0
> =

> =A0
> =

> =A0
> =

> -----Original Message-----
> From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
> Sent: Friday, November 20, 2020 11:48 AM
> To: Weber, John <jweber1@ball.com>
> Cc: 'lttng-dev@lists.lttng.org' <lttng-dev@lists.lttng.org>
> Subject: [EXTERNAL] Re: [lttng-dev] lttng 2.12 install
> =

> Hi John,
> =

> This does not seems to be directly related to the lttng-modules project.
> =

> This errors seems to arise because of the compiler you are using to compi=
le lttng-modules (kernel modules). The RETPOLINE check is part of the kerne=
l build system, not directly lttng-modules.
> =

> I would recommend that you take a look at the /proc/version file and the =
compiler that was used to compile your kernel. =

> =

> Also note that EfficiOS [1] provide commercial support if you ever need m=
ore in-depth support. =

> =

> Cheers
> =

> [1] =

> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.efficios.com_
> contact_&d=3DDwIBAg&c=3DjF7FvYH6t0RX1HrEjVCgHQ&r=3Dt_BRyMysL9XIchJvkrT9wQ=
&m=3D
> EB0u_nTE1tUx4ZXA7ENPxCS2zGFrbf0ZpfI5DiP051o&s=3DJumKvFuRjeKw-8NQkpWd1nN8
> ZOHAo-JMUMiqWc2Oq9o&e=3D
> =

> On Fri, Nov 20, 2020 at 05:43:00PM +0000, Weber, John via lttng-dev wrote:
> > Hi, I have a centos 7.8 workstation that I'm trying to install lttng-mo=
dules & lttng-tools from source. Based on your install instructions I'm wor=
king on installing the modules part first and its failing. I am getting the=
 error:
> > Make entering directory /usr/src/kernels/3.10.0-1127.19.1.el7.x86_64
> > Arch/x86/Makefile:166 *** CONFIG_RETPOLINE=3Dy, but not supported by =

> > the compiler. Compiler update recommended... stop
> > Make: modules error 2
> > =

> > Help, how can I get this program to install? Im stuck. Also, my work en=
vironment is classified so there is no access to internet from high side.
> > =

> > ----------------------------
> > John Weber
> > Ball Aerospace
> > ITS ND System Administrator
> > 10 Longs Peak Dr., Broomfield, CO 80021
> > C: 303-807-3608   P: 303-234-2103
> > E: jweber1@ball.com
> > =

> > =

> > [cid:image001.jpg@01D6BF29.AD6C5250]
> > =

> > =

> > [cid:image002.jpg@01D6BF29.AD6C5250]<http://www.ball.com/aerospace>
> > =

> > This message and any enclosures are intended only for the addressee.  =

> > Please notify the sender by email if you are not the intended =

> > recipient.  If you are not the intended recipient, you may not use, =

> > copy, disclose, or distribute this message or its contents or =

> > enclosures to any other person and any such actions may be unlawful.
> > Ball reserves the right to monitor and review all messages and enclosur=
es sent to or from this email address.
> =

> =

> =

> =

> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.lttng.org
> > _c =

> > gi-2Dbin_mailman_listinfo_lttng-2Ddev&d=3DDwIBAg&c=3DjF7FvYH6t0RX1HrEjVC
> > gH
> > Q&r=3Dt_BRyMysL9XIchJvkrT9wQ&m=3DEB0u_nTE1tUx4ZXA7ENPxCS2zGFrbf0ZpfI5DiP
> > 05 1o&s=3DtlmdamhJeWU81ADw4gyy0TeCGIhuLXutgPxwQNZsQUk&e=3D
> =

> =

> --
> Jonathan Rajotte-Julien
> EfficiOS
> =

> This message and any enclosures are intended only for the addressee.  =

> Please notify the sender by email if you are not the intended =

> recipient.  If you are not the intended recipient, you may not use, =

> copy, disclose, or distribute this message or its contents or =

> enclosures to any other person and any such actions may be unlawful.  =

> Ball reserves the right to monitor and review all messages and enclosures=
 sent to or from this email address.

--
Jonathan Rajotte-Julien
EfficiOS

This message and any enclosures are intended only for the addressee.  Pleas=
e =

notify the sender by email if you are not the intended recipient.  If you a=
re =

not the intended recipient, you may not use, copy, disclose, or distribute =
this =

message or its contents or enclosures to any other person and any such acti=
ons =

may be unlawful.  Ball reserves the right to monitor and review all message=
s =

and enclosures sent to or from this email address.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
