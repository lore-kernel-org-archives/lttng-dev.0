From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: supporting new processor
Date: Mon, 22 Apr 2013 10:17:30 -0400
Message-ID: <CA+jJMxuvWRgyhzu4=QUh0+TR=9Lp1BV7PcHJHuj-LOgPDFTDUQ__17795.4914783642$1366640285$gmane$org@mail.gmail.com>
References: <CANJoRMRRWiHAL=fcP717Dv9QmZVJBjpLjB0pBEioewtni8QkLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f180.google.com ([74.125.82.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UUHYm-0007UI-Py
	for lttng-dev@lists.lttng.org; Mon, 22 Apr 2013 10:17:37 -0400
Received: by mail-we0-f180.google.com with SMTP id x43so2245431wey.11
	for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2013 07:17:30 -0700 (PDT)
In-Reply-To: <CANJoRMRRWiHAL=fcP717Dv9QmZVJBjpLjB0pBEioewtni8QkLw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Madhusudan Bhat <madhu.b77@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

Generally speaking, URCU is the most architecture-specific library of
the project and it does support MIPS. Once it is compiled and
installed, you should be able to build lttng-ust, lttng-tools and the
kernel modules.

I'd recommend running each project's test suite since I don't think
that architecture has been thoroughly tested. Let us know if you
encounter any problem on your particular architecture.

Regards,
J=E9r=E9mie

On Mon, Apr 22, 2013 at 1:30 AM, Madhusudan Bhat <madhu.b77@gmail.com> wrot=
e:
> Hi All,
>
> I need to support lttng tools, I have new MIPS based multi core processor=
 on
> which 3.7 linux kernel boots up.
>
> To support lttng tools, does it require any drivers/kernel hook ups to new
> processor? Or is it independent of processor architecture?
>
> For ex, to support Oprofile tools, we need to provide oprofile driver whi=
ch
> is specific to particular processor. In similar ways,any thing is required
> to support lttng tools?
>
> thanks,
> Madhu.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
