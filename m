Return-Path: <SRS0=lmbG=E6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09ADC2D0E4
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Nov 2020 19:22:30 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8693206B5
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Nov 2020 19:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="ho1gqNOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8693206B5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CgYnH3hRGz1Nb9;
	Tue, 24 Nov 2020 14:22:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606245748;
	bh=ZQ6HHVu20RLQOknHcYqJTTK/dbjRgyCYAGKy25JAQIw=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ho1gqNOp2s4MKYqFBGGU72kf1yieidQG1ABe3RRnQ+6Vx7GB7QfsZ4WNPZ9RQGqW8
	 e4xWFxgA0bbPRB2OLvwqYDe18+Lre++ApddKjPBYxraV5wR/O3HzKUEfLIg0XkzR0o
	 krgSbmFxQfWBnBmXRTknSecpFB9s33Di58kQrFlgXHFIoGktpoi/UuVQFSxD63KxCs
	 ee0+gy+Z/92JD4nNTn5O6W26oigTCUY2SGJce5nRuVC+vYTJdrNTindzvT9ZBBFUjX
	 YtlCjP/UPp52wPh0jy9hCR78yXZMFALQFBmMcXOil3At3CGLG0O/agPnhvfGVMq8kE
	 gGUyLJRnlQhxQ==
Received: from mx0a-0014fe01.pphosted.com (mx0b-0014fe01.pphosted.com
 [208.86.201.212])
 by lists.lttng.org (Postfix) with ESMTPS id 4CgYnF67kMz1NKH
 for <lttng-dev@lists.lttng.org>; Tue, 24 Nov 2020 14:22:25 -0500 (EST)
Received: from pps.filterd (m0046820.ppops.net [127.0.0.1])
 by m0046820.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0AOJGsq5006329;
 Tue, 24 Nov 2020 12:22:12 -0700
Received: from mail.ballaerospace.com ([162.18.172.11])
 by m0046820.ppops.net with ESMTP id 3516he89vx-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT);
 Tue, 24 Nov 2020 12:22:12 -0700
Received: from ex2016-co-04.AERO.BALL.COM (10.72.9.137) by
 ex2016-co-01.AERO.BALL.com (10.72.9.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.1466.3; Tue, 24 Nov 2020 12:22:11 -0700
Received: from ex2016-co-03.AERO.BALL.COM (10.72.9.80) by
 ex2016-co-04.AERO.BALL.com (10.72.9.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.1466.3; Tue, 24 Nov 2020 12:22:10 -0700
Received: from ex2016-co-03.AERO.BALL.COM ([fe80::a55a:f7d9:c791:da55]) by
 ex2016-co-03.AERO.BALL.com ([fe80::a55a:f7d9:c791:da55%12]) with mapi id
 15.01.1466.003; Tue, 24 Nov 2020 12:22:10 -0700
To: 'Jonathan Rajotte-Julien' <jonathan.rajotte-julien@efficios.com>
CC: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
Thread-Topic: [EXTERNAL] Re: [lttng-dev] lttng 2.12 install
Thread-Index: Ada/Y4SGFTZ5vBbyTkeGMcaNOjy/7AARMrIAALtoxFA=
Date: Tue, 24 Nov 2020 19:22:10 +0000
Message-ID: <8602eba582ba4806b5bf307cceef521d@ball.com>
References: <326539938460471c975e791ce6b1c775@ball.com>
 <20201120184746.GF8709@joraj-alpa>
In-Reply-To: <20201120184746.GF8709@joraj-alpa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcandlYmVyMVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTU4ODQyYWU5LTJlOGEtMTFlYi04MGQ4LTAwNTA1NmJiMzk0Y1xhbWUtdGVzdFw1ODg0MmFlYi0yZThhLTExZWItODBkOC0wMDUwNTZiYjM5NGNib2R5LnR4dCIgc3o9IjM2NjgiIHQ9IjEzMjUwNzE5MzMwMDg0MzI5MyIgaD0ieGxZZGpQZXgwNHgrSm9XY0pjMEhKb2lFUWl3PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-originating-ip: [10.72.63.11]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-24_06:2020-11-24,
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

Hi, thanks for your reply. So, on my system there are 2 gcc's. one installe=
d by the OS and the other by installation of devtooset-6. Upon checking the=
 versions of both I have 4.8.5 installed by OS in /usr/bin the other one fr=
om devtoolset is 6.3.1. Your reference to check /proc/version shows that it=
 sees 4.8.5. how can I manipulate the install to use the gcc from /opt/rh/d=
evtoolset-6/root/bin/gcc (which is 6.3.1)

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

Sent: Friday, November 20, 2020 11:48 AM
To: Weber, John <jweber1@ball.com>
Cc: 'lttng-dev@lists.lttng.org' <lttng-dev@lists.lttng.org>
Subject: [EXTERNAL] Re: [lttng-dev] lttng 2.12 install

Hi John,

This does not seems to be directly related to the lttng-modules project.

This errors seems to arise because of the compiler you are using to compile=
 lttng-modules (kernel modules). The RETPOLINE check is part of the kernel =
build system, not directly lttng-modules.

I would recommend that you take a look at the /proc/version file and the co=
mpiler that was used to compile your kernel. =


Also note that EfficiOS [1] provide commercial support if you ever need mor=
e in-depth support. =


Cheers

[1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.efficios.com=
_contact_&d=3DDwIBAg&c=3DjF7FvYH6t0RX1HrEjVCgHQ&r=3Dt_BRyMysL9XIchJvkrT9wQ&=
m=3DEB0u_nTE1tUx4ZXA7ENPxCS2zGFrbf0ZpfI5DiP051o&s=3DJumKvFuRjeKw-8NQkpWd1nN=
8ZOHAo-JMUMiqWc2Oq9o&e=3D =


On Fri, Nov 20, 2020 at 05:43:00PM +0000, Weber, John via lttng-dev wrote:
> Hi, I have a centos 7.8 workstation that I'm trying to install lttng-modu=
les & lttng-tools from source. Based on your install instructions I'm worki=
ng on installing the modules part first and its failing. I am getting the e=
rror:
> Make entering directory /usr/src/kernels/3.10.0-1127.19.1.el7.x86_64
> Arch/x86/Makefile:166 *** CONFIG_RETPOLINE=3Dy, but not supported by the =

> compiler. Compiler update recommended... stop
> Make: modules error 2
> =

> Help, how can I get this program to install? Im stuck. Also, my work envi=
ronment is classified so there is no access to internet from high side.
> =

> ----------------------------
> John Weber
> Ball Aerospace
> ITS ND System Administrator
> 10 Longs Peak Dr., Broomfield, CO 80021
> C: 303-807-3608   P: 303-234-2103
> E: jweber1@ball.com
> =

> =

> [cid:image001.jpg@01D6BF29.AD6C5250]
> =

> =

> [cid:image002.jpg@01D6BF29.AD6C5250]<http://www.ball.com/aerospace>
> =

> This message and any enclosures are intended only for the addressee.  =

> Please notify the sender by email if you are not the intended =

> recipient.  If you are not the intended recipient, you may not use, =

> copy, disclose, or distribute this message or its contents or =

> enclosures to any other person and any such actions may be unlawful.  =

> Ball reserves the right to monitor and review all messages and enclosures=
 sent to or from this email address.




> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.lttng.org_c
> gi-2Dbin_mailman_listinfo_lttng-2Ddev&d=3DDwIBAg&c=3DjF7FvYH6t0RX1HrEjVCgH
> Q&r=3Dt_BRyMysL9XIchJvkrT9wQ&m=3DEB0u_nTE1tUx4ZXA7ENPxCS2zGFrbf0ZpfI5DiP05
> 1o&s=3DtlmdamhJeWU81ADw4gyy0TeCGIhuLXutgPxwQNZsQUk&e=3D


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
