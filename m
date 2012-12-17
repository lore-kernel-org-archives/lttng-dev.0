From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: tracepoint generation is fragile wrt macro	expansion
Date: Mon, 17 Dec 2012 15:54:40 -0500
Message-ID: <20121217205440.GA11058__14735.2902371951$1355777727$gmane$org@Krystal>
References: <CAPkDDd4UfCdhoY0s1Es55NkuXNt4qFa4v1wiLDXutcqHOvPMCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tkhhx-00026J-K4
	for lttng-dev@lists.lttng.org; Mon, 17 Dec 2012 15:54:41 -0500
Content-Disposition: inline
In-Reply-To: <CAPkDDd4UfCdhoY0s1Es55NkuXNt4qFa4v1wiLDXutcqHOvPMCg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?S=E9bastien_Barth=E9l=E9my?= <barthelemy@crans.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* S=E9bastien Barth=E9l=E9my (barthelemy@crans.org) wrote:
> Hello,
> =

> please find attached a small patch which demonstrates the problem.
> =

> The patch simply renames the test file ust_tests_hello.h into
> ust_tests-linux-hello.h. The build then fails on linux because the "linux"
> in
> =

>     #define TRACEPOINT_INCLUDE_FILE ./ust_tests-linux-hello.h
> =

> gets expanded to "1", and it then tries to include ust_tests-1-hello.h.

Good point ! Here is the fix:

commit 41858e2b6e81ee5e02eccdd7467b9239d4cdf726
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Dec 17 15:36:08 2012 -0500

    Fix: don't do macro expansion in tracepoint file name
    =

    Change the API in a backward compatible way: previously, probe headers
    would do e.g.
    =

     #define TRACEPOINT_INCLUDE_FILE ./ust_tests-linux-hello.h

    but e.g. "linux" here would be expanded to "1", which is bad.
    =

    Fix this by allowing those headers to do:
 =

     #define TRACEPOINT_INCLUDE "./ust_tests-linux-hello.h"
   =

    instead. We still support the old TRACEPOINT_INCLUDE_FILE for backward
    compatibility.
    =

    Reported-by: S=E9bastien Barth=E9l=E9my <barthelemy@crans.org>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> =

> I do not know if this can be fixed, hopefully you'll have a better idea.
> =

> I came into the problem because I generate the tracepoint definition file
> (=E0 la lttng-gen-tp) but define TRACEPOINT_INCLUDE_FILE to the full path=
 of
> the generated file, which happens to be in the build directory, something
> like .../build-sys-linux-x86_64/..., So I'm more exposed.
> =

> Maybe a possible solution would involve __FILE__?

Nope, unfortunately, __FILE__ always expands to the file in which
__FILE__ is located, not, e.g., the header referring to a macro
containing __FILE__.

Please let me know if the patch above works for you,

Thanks,

Mathieu


> =

> Cheers
> =

> -- S=E9bastien


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
