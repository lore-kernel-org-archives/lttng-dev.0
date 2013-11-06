From: Paul Thomas <paul.thomas@ise.bc.ca>
Subject: Re: Building Babeltrace
Date: Wed, 6 Nov 2013 20:22:47 +0000
Message-ID: <F98AC8DFC04DC741915F3DFB00515DBEE8972799__34393.1801653982$1383769474$gmane$org@Thetis.ISE-DOM.local>
References: <F98AC8DFC04DC741915F3DFB00515DBEE8972716@Thetis.ISE-DOM.local>
	<F98AC8DFC04DC741915F3DFB00515DBEE897275C@Thetis.ISE-DOM.local>
	<CA+jJMxt1ANnowdofJweazFts5f+Rarnx0gwwmDUh-UyMvRYjVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]
	helo=co9outboundpool.messaging.microsoft.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paul.thomas@ise.bc.ca>) id 1Ve9d2-0006x9-4h
	for lttng-dev@lists.lttng.org; Wed, 06 Nov 2013 15:23:09 -0500
In-Reply-To: <CA+jJMxt1ANnowdofJweazFts5f+Rarnx0gwwmDUh-UyMvRYjVg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?=27J=E9r=E9mie_Galarneau=27?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> -----Original Message-----
> From: jeremie.galarneau@gmail.com =

> [mailto:jeremie.galarneau@gmail.com] On Behalf Of J=E9r=E9mie Galarneau
> Sent: Wednesday, November 06, 2013 11:58 AM
> To: Paul Thomas
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Building Babeltrace
> =

~~snip~~
> =

> Let me know if you still can't build babeltrace with the =

> latest master.
> =

> J=E9r=E9mie
> =

> >
> > Thanks,
> >
> > Paul
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =

> =

> =

> =

> -- =

> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
> =


Hi,

Encountered this link error:

Making all in converter
make[2]: Entering directory `/rt_linux/babeltrace/converter'
  CC     babeltrace.o
  CCLD   babeltrace
../formats/ctf/.libs/libbabeltrace-ctf.so: undefined reference to `g_hash_t=
able_add'
../formats/ctf/.libs/libbabeltrace-ctf.so: undefined reference to `g_ptr_ar=
ray_new_full'
../formats/ctf/.libs/libbabeltrace-ctf.so: undefined reference to `g_hash_t=
able_contains'
collect2: ld returned 1 exit status
make[2]: *** [babeltrace] Error 1
make[2]: Leaving directory `/rt_linux/babeltrace/converter'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/rt_linux/babeltrace'
make: *** [all] Error 2

Good advice, then I will switch to compiling from tarball,
maybe try rebuilding from git master sometime later.

Thanks,

Paul =
