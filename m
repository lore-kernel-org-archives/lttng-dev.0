From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [GSoC 2013] projects information
Date: Mon, 15 Apr 2013 12:44:13 -0400
Message-ID: <CA+jJMxuFw-cH-firnyUKMh6djMAH818PVDRPauJr_800sEYLnQ__23706.0664840557$1366044292$gmane$org@mail.gmail.com>
References: <1365761741.59268.YahooMailNeo@web122204.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1URmVw-0004S3-2f
	for lttng-dev@lists.lttng.org; Mon, 15 Apr 2013 12:44:20 -0400
Received: by mail-wg0-f41.google.com with SMTP id e11so357052wgh.4
	for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2013 09:44:14 -0700 (PDT)
In-Reply-To: <1365761741.59268.YahooMailNeo@web122204.mail.ne1.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Claudiu Olteanu <olteanu.claudiu@ymail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Claudiu,

I'm the mentor assigned to the prospective "Trace probe support in C++" pro=
ject.

I'd recommend you get familiar with one of the lttng-ust example
application (in doc/examples), compile and run it, and read back the
resulting trace using Babeltrace. This will give you an idea of how
tracepoints are integrated in an application to be instrumented. I
have recently proposed a patch that adds example applications and
plain, automake-less, Makefiles to lttng-ust[1]. Clone my personal
development branch[2] to find it already applied.

You will also want to have a look at "tests/hello.cxx" in lttng-ust's
source tree which demonstrates that a C++ application can be compiled
even though a tracepoint header file is included. As explained in that
test's README, the tracepoint provider is compiled as a C library and
then linked into an application compiled as C++.

The objective of this project is to eliminate this intermediate step
and let C++ developers build them directly into their application
as-is. I can only suggest you try to compile your test application and
providers as C++ and work your way through the errors and warnings.
You'll never let anyone tell you C and C++ are the same again!

Thanks for reaching out,
J=E9r=E9mie

[1] http://lists.lttng.org/pipermail/lttng-dev/2013-April/020029.html
[2] git clone -b documentation git://github.com/jgalar/lttng-ust.git

On Fri, Apr 12, 2013 at 6:15 AM, Claudiu Olteanu
<olteanu.claudiu@ymail.com> wrote:
> Hi there!
>
> My name is Claudiu Olteanu, I'm from Bucharest, Romania and I study at the
> University 'Politehnica' of Bucharest, the Faculty of Automatic Control a=
nd
> Computers Science. I'm a third year student and I would like to participa=
te
> to GSoC this summer. After I took a look at the projects list I decided t=
hat
> it would be interesting and motivating to work on one of these projects :
>  - Trace probe support in C++
>  - Development of an strace-alike wrapper
>
> I will appreciate it if you give me more details about them and some advi=
ce
> that can put me on track.
>
> You can find my CV here[1] in case you want to know more about me.
>
> Regards,
> Claudiu
>
> [1] -
> https://docs.google.com/file/d/0BwSntkUS-WYzVUVoZkYxdzNvNmc/edit?usp=3Dsh=
aring
>
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
