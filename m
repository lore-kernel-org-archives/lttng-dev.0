Return-Path: <SRS0=lmbG=E6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A49C2D0E4
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Nov 2020 21:18:55 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B251320715
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Nov 2020 21:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="KHcCw5iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B251320715
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CgcMb4w5Dz1Ngp;
	Tue, 24 Nov 2020 16:18:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606252732;
	bh=LeVW933IjpGPinvhEEn6lHQTarQfrF9tZKBx0lB7C0w=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KHcCw5iCF/IKKlFIE9kie6q4aYFnhYT+RSWODqZXuESF8Nwi3l6veyIRXu5mAMo9J
	 8Z42ibWKJDBN/j9LvyEY6XBRkJywqdW3TuscdZizBEqI+OoZEh+aihcxQi5k4bw/SE
	 zXn5K7pMgSFyuS3eMkvC8iMf6rmqX76Inlgbc8svPzGWm0GlnJBT3XSdMvtjTRXmOq
	 +jeStD58+eFheGqBkiIL63a/IfgpDGMPCf9mdxYWvadN3fl0gGOMstldoWqSD6cqic
	 AOI+P63LlJATA3t44tuIT2F3HCojNjycji3JDKZahvfzIRZwK+S4k+LlhR88hFp8Ft
	 IraVG3ai4sBDA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CgcMY6mMlz1Ngn
 for <lttng-dev@lists.lttng.org>; Tue, 24 Nov 2020 16:18:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 992372748C7;
 Tue, 24 Nov 2020 16:18:43 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id cvnaO56_HDbt; Tue, 24 Nov 2020 16:18:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 288C6274C25;
 Tue, 24 Nov 2020 16:18:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 288C6274C25
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id zoapK_wAmRjn; Tue, 24 Nov 2020 16:18:43 -0500 (EST)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id F0861274948;
 Tue, 24 Nov 2020 16:18:42 -0500 (EST)
Date: Tue, 24 Nov 2020 16:18:42 -0500
To: "Weber, John" <jweber1@ball.com>
Message-ID: <20201124211842.GB769862@joraj-alpa>
References: <326539938460471c975e791ce6b1c775@ball.com>
 <20201120184746.GF8709@joraj-alpa>
 <8602eba582ba4806b5bf307cceef521d@ball.com>
 <20201124202138.GA769862@joraj-alpa>
 <aefcb4673adb4b3980bb0612a81f8d87@ball.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aefcb4673adb4b3980bb0612a81f8d87@ball.com>
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
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Tue, Nov 24, 2020 at 09:02:41PM +0000, Weber, John wrote:
> Ok, it I get what you're saying then I am modifying make on the command l=
ine while running make?

Yeah.

> Still the same problem. I don't think it is using the gcc I am specifying=
 as it continues to look in: /usr/src/kernels/3.10.0-1127.19.1.el7.x86_64/

This is normal since you are compiling the modules against that source tree.

> And I suspect it is still seeing the OS version of gcc (4.8.5) instead of=
 the 6.3.1 provided by devtoolset-6.

At this point, I would take a look at the actual package installed that pro=
vide gcc
4.8.5 and have a look at what is available from centos/redhjat and also may=
be ping
a centos mailing list. You can CC me on that email if you feel like
it just in case it turn out the problem is on our side.

> Do you have some pixy dust??

Sadly, no. Others might have some left...

> =

> ----------------------------
> John Weber
> Ball Aerospace
> ITS ND System Administrator =

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
> From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com> =

> Sent: Tuesday, November 24, 2020 1:22 PM
> To: Weber, John <jweber1@ball.com>
> Cc: 'lttng-dev@lists.lttng.org' <lttng-dev@lists.lttng.org>
> Subject: Re: [EXTERNAL] Re: [lttng-dev] lttng 2.12 install
> =

> Hi John,
> =

> AFAIK, you should be able to do so using something similar to the followi=
ng:
> =

>   make CC=3D"your_compiler" HOSTCC=3D"your_compiler" ...
> =

> Cheers
> =

> =

> On Tue, Nov 24, 2020 at 07:22:10PM +0000, Weber, John wrote:
> > Hi, thanks for your reply. So, on my system there are 2 gcc's. one =

> > installed by the OS and the other by installation of devtooset-6. Upon =

> > checking the versions of both I have 4.8.5 installed by OS in /usr/bin =

> > the other one from devtoolset is 6.3.1. Your reference to check =

> > /proc/version shows that it sees 4.8.5. how can I manipulate the =

> > install to use the gcc from /opt/rh/devtoolset-6/root/bin/gcc (which =

> > is 6.3.1)
> > =

> > ----------------------------
> > John Weber
> > Ball Aerospace
> > ITS ND System Administrator
> > 10 Longs Peak Dr., Broomfield, CO 80021
> > C: 303-807-3608   P: 303-234-2103
> > E: jweber1@ball.com
> > =A0
> > =A0
> > =

> > =A0
> > =

> > =A0
> > =

> > -----Original Message-----
> > From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
> > Sent: Friday, November 20, 2020 11:48 AM
> > To: Weber, John <jweber1@ball.com>
> > Cc: 'lttng-dev@lists.lttng.org' <lttng-dev@lists.lttng.org>
> > Subject: [EXTERNAL] Re: [lttng-dev] lttng 2.12 install
> > =

> > Hi John,
> > =

> > This does not seems to be directly related to the lttng-modules project.
> > =

> > This errors seems to arise because of the compiler you are using to com=
pile lttng-modules (kernel modules). The RETPOLINE check is part of the ker=
nel build system, not directly lttng-modules.
> > =

> > I would recommend that you take a look at the /proc/version file and th=
e compiler that was used to compile your kernel. =

> > =

> > Also note that EfficiOS [1] provide commercial support if you ever need=
 more in-depth support. =

> > =

> > Cheers
> > =

> > [1] =

> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.efficios.com_
> > contact_&d=3DDwIBAg&c=3DjF7FvYH6t0RX1HrEjVCgHQ&r=3Dt_BRyMysL9XIchJvkrT9=
wQ&m=3D
> > EB0u_nTE1tUx4ZXA7ENPxCS2zGFrbf0ZpfI5DiP051o&s=3DJumKvFuRjeKw-8NQkpWd1nN8
> > ZOHAo-JMUMiqWc2Oq9o&e=3D
> > =

> > On Fri, Nov 20, 2020 at 05:43:00PM +0000, Weber, John via lttng-dev wro=
te:
> > > Hi, I have a centos 7.8 workstation that I'm trying to install lttng-=
modules & lttng-tools from source. Based on your install instructions I'm w=
orking on installing the modules part first and its failing. I am getting t=
he error:
> > > Make entering directory /usr/src/kernels/3.10.0-1127.19.1.el7.x86_64
> > > Arch/x86/Makefile:166 *** CONFIG_RETPOLINE=3Dy, but not supported by =

> > > the compiler. Compiler update recommended... stop
> > > Make: modules error 2
> > > =

> > > Help, how can I get this program to install? Im stuck. Also, my work =
environment is classified so there is no access to internet from high side.
> > > =

> > > ----------------------------
> > > John Weber
> > > Ball Aerospace
> > > ITS ND System Administrator
> > > 10 Longs Peak Dr., Broomfield, CO 80021
> > > C: 303-807-3608   P: 303-234-2103
> > > E: jweber1@ball.com
> > > =

> > > =

> > > [cid:image001.jpg@01D6BF29.AD6C5250]
> > > =

> > > =

> > > [cid:image002.jpg@01D6BF29.AD6C5250]<http://www.ball.com/aerospace>
> > > =

> > > This message and any enclosures are intended only for the addressee.  =

> > > Please notify the sender by email if you are not the intended =

> > > recipient.  If you are not the intended recipient, you may not use, =

> > > copy, disclose, or distribute this message or its contents or =

> > > enclosures to any other person and any such actions may be unlawful.
> > > Ball reserves the right to monitor and review all messages and enclos=
ures sent to or from this email address.
> > =

> > =

> > =

> > =

> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.lttng.org
> > > _c =

> > > gi-2Dbin_mailman_listinfo_lttng-2Ddev&d=3DDwIBAg&c=3DjF7FvYH6t0RX1HrE=
jVC
> > > gH
> > > Q&r=3Dt_BRyMysL9XIchJvkrT9wQ&m=3DEB0u_nTE1tUx4ZXA7ENPxCS2zGFrbf0ZpfI5=
DiP
> > > 05 1o&s=3DtlmdamhJeWU81ADw4gyy0TeCGIhuLXutgPxwQNZsQUk&e=3D
> > =

> > =

> > --
> > Jonathan Rajotte-Julien
> > EfficiOS
> > =

> > This message and any enclosures are intended only for the addressee.  =

> > Please notify the sender by email if you are not the intended =

> > recipient.  If you are not the intended recipient, you may not use, =

> > copy, disclose, or distribute this message or its contents or =

> > enclosures to any other person and any such actions may be unlawful.  =

> > Ball reserves the right to monitor and review all messages and enclosur=
es sent to or from this email address.
> =

> --
> Jonathan Rajotte-Julien
> EfficiOS
> =

> This message and any enclosures are intended only for the addressee.  Ple=
ase =

> notify the sender by email if you are not the intended recipient.  If you=
 are =

> not the intended recipient, you may not use, copy, disclose, or distribut=
e this =

> message or its contents or enclosures to any other person and any such ac=
tions =

> may be unlawful.  Ball reserves the right to monitor and review all messa=
ges =

> and enclosures sent to or from this email address.

-- =

Jonathan Rajotte-Julien
EfficiOS
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
