From: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Subject: Re: [PATCH RFC lttng-tools] Testpoint mechanism
Date: Tue, 11 Sep 2012 19:18:16 -0400
Message-ID: <CAEzWAeK5rh5Qb4421bkjhfsFHwYpeuRk1_SEwtpXjbUoWoCAnw__28804.3338842273$1347405537$gmane$org@mail.gmail.com>
References: <1347396978-4661-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0024990273=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TBZip-0004cZ-MC
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 19:18:24 -0400
Received: by qafk30 with SMTP id k30so2236413qaf.14
	for <lttng-dev@lists.lttng.org>; Tue, 11 Sep 2012 16:18:18 -0700 (PDT)
In-Reply-To: <1347396978-4661-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0024990273==
Content-Type: multipart/alternative; boundary=20cf300fb3bd10965704c9754a3a

--20cf300fb3bd10965704c9754a3a
Content-Type: text/plain; charset=ISO-8859-1

I'm not sure I understand the goal of this feature. Can you explain more?
On Sep 11, 2012 4:56 PM, "Christian Babeux" <christian.babeux@efficios.com>
wrote:

> Hi,
>
> This is a RFC for a testpoint mechanism to ease and improve testing
> efforts of the LTTng codebase.
>
> Motivation
> ----------
>
> The main goal behind the testpoint mechanism is to be able to test and
> validate failure cases in different portion of the LTTng codebase. It
> could also be used by developers as a debugging aid.
>
> By injecting code at runtime in the lttng daemons/processes/executables,
> we can painlessly trigger faulty behavior, test errors paths or even
> reproduce race conditions by introducing or exacerbating delays between
> threads.
>
> Requirements
> ------------
>
> The testpoint mechanism should be able to be triggered via scripts to
> automate testing efforts.
>
> Ideally, the testpoint mechanism should *NOT* incur a significant
> performance hit if we want to leave it always on, in a similar fashion
> to the assert() macros.
>
> By leaving it always on, any user is able to use our tests and validate
> the behavior of his installation via a simple 'make check' execution.
>
> Proposed solution
> -----------------
>
> This patch introduce two new macros: TESTPOINT_DECL(name)
> and testpoint(name).
>
> Here a quick example that shows how to use the testpoint mechanism:
>
> file: main.c
> #include <stdio.h>
> #include <common/testpoint/testpoint/testpoint.h>
>
> /* Testpoint declaration */
> TESTPOINT_DECL(interesting_function)
>
> void interesting_function(void)
> {
>         testpoint(interesting_function);
>         /* Some processing that can fail */
>         ...
> }
>
> int main(int argc, char *argv[])
> {
>         interesting_function();
>         ...
>         printf("End");
> }
>
> file: testpoint.c
> #include <stdio.h>
> void __testpoint_interesting_function(void)
> {
>         printf("In testpoint of interesting function!");
> }
>
> Compile:
> gcc -o test main.c
> gcc -fPIC -shared -o testpoint.so testpoint.c
>
> Run:
> > ./test
>   End
> > export LTTNG_TESTPOINT_ENABLE=1
> > LD_PRELOAD=testpoint.so ./test
>   In testpoint of interesting function!
>   End
> > export LTTNG_TESTPOINT_ENABLE=0
> > LD_PRELOAD=testpoint.so ./test
>   End
>
> The testpoint mechanism is triggered via the preloading of a shared
> object containing the appropriate testpoint symbols and by setting the
> LTTNG_TESTPOINT_ENABLE environment variable.
>
> The check on this environment variable is done on the application startup
> with the help of a constructor (lttng_testpoint_check) which toggle a
> global
> state variable indicating whether or not the testpoints should be
> activated.
>
> When enabled, the testpoint() macro calls an underlying wrapper specific to
> the testpoint and simply try to lookup the testpoint symbol via a dlsym()
> call.
>
> When disabled, the testpoint() call will only incur an additionnal test
> per testpoint on a global variable. This performance 'hit' should be
> acceptable for production use.
>
> As stated previously, the testpoint mechanism should be *always on*.
> It can be explicitly disabled via CFLAGS="-DNTESTPOINT" in a way similar
> to NDEBUG and assert().
>
> Comments, thoughts?
>
> Thanks,
>
> Christian Babeux (1):
>   New testpoint mechanism to instrument LTTng binaries for testing
>     purpose
>
>  configure.ac                     |  1 +
>  src/common/Makefile.am           |  2 +-
>  src/common/testpoint/Makefile.am |  6 +++
>  src/common/testpoint/testpoint.c | 43 +++++++++++++++++++++
>  src/common/testpoint/testpoint.h | 81
> ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 132 insertions(+), 1 deletion(-)
>  create mode 100644 src/common/testpoint/Makefile.am
>  create mode 100644 src/common/testpoint/testpoint.c
>  create mode 100644 src/common/testpoint/testpoint.h
>
> --
> 1.7.11.4
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--20cf300fb3bd10965704c9754a3a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>I&#39;m not sure I understand the goal of this feature. Can you explain =
more? </p>
<div class=3D"gmail_quote">On Sep 11, 2012 4:56 PM, &quot;Christian Babeux&=
quot; &lt;<a href=3D"mailto:christian.babeux@efficios.com">christian.babeux=
@efficios.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
Hi,<br>
<br>
This is a RFC for a testpoint mechanism to ease and improve testing<br>
efforts of the LTTng codebase.<br>
<br>
Motivation<br>
----------<br>
<br>
The main goal behind the testpoint mechanism is to be able to test and<br>
validate failure cases in different portion of the LTTng codebase. It<br>
could also be used by developers as a debugging aid.<br>
<br>
By injecting code at runtime in the lttng daemons/processes/executables,<br=
>
we can painlessly trigger faulty behavior, test errors paths or even<br>
reproduce race conditions by introducing or exacerbating delays between<br>
threads.<br>
<br>
Requirements<br>
------------<br>
<br>
The testpoint mechanism should be able to be triggered via scripts to<br>
automate testing efforts.<br>
<br>
Ideally, the testpoint mechanism should *NOT* incur a significant<br>
performance hit if we want to leave it always on, in a similar fashion<br>
to the assert() macros.<br>
<br>
By leaving it always on, any user is able to use our tests and validate<br>
the behavior of his installation via a simple &#39;make check&#39; executio=
n.<br>
<br>
Proposed solution<br>
-----------------<br>
<br>
This patch introduce two new macros: TESTPOINT_DECL(name)<br>
and testpoint(name).<br>
<br>
Here a quick example that shows how to use the testpoint mechanism:<br>
<br>
file: main.c<br>
#include &lt;stdio.h&gt;<br>
#include &lt;common/testpoint/testpoint/testpoint.h&gt;<br>
<br>
/* Testpoint declaration */<br>
TESTPOINT_DECL(interesting_function)<br>
<br>
void interesting_function(void)<br>
{<br>
=A0 =A0 =A0 =A0 testpoint(interesting_function);<br>
=A0 =A0 =A0 =A0 /* Some processing that can fail */<br>
=A0 =A0 =A0 =A0 ...<br>
}<br>
<br>
int main(int argc, char *argv[])<br>
{<br>
=A0 =A0 =A0 =A0 interesting_function();<br>
=A0 =A0 =A0 =A0 ...<br>
=A0 =A0 =A0 =A0 printf(&quot;End&quot;);<br>
}<br>
<br>
file: testpoint.c<br>
#include &lt;stdio.h&gt;<br>
void __testpoint_interesting_function(void)<br>
{<br>
=A0 =A0 =A0 =A0 printf(&quot;In testpoint of interesting function!&quot;);<=
br>
}<br>
<br>
Compile:<br>
gcc -o test main.c<br>
gcc -fPIC -shared -o testpoint.so testpoint.c<br>
<br>
Run:<br>
&gt; ./test<br>
=A0 End<br>
&gt; export LTTNG_TESTPOINT_ENABLE=3D1<br>
&gt; LD_PRELOAD=3Dtestpoint.so ./test<br>
=A0 In testpoint of interesting function!<br>
=A0 End<br>
&gt; export LTTNG_TESTPOINT_ENABLE=3D0<br>
&gt; LD_PRELOAD=3Dtestpoint.so ./test<br>
=A0 End<br>
<br>
The testpoint mechanism is triggered via the preloading of a shared<br>
object containing the appropriate testpoint symbols and by setting the<br>
LTTNG_TESTPOINT_ENABLE environment variable.<br>
<br>
The check on this environment variable is done on the application startup<b=
r>
with the help of a constructor (lttng_testpoint_check) which toggle a globa=
l<br>
state variable indicating whether or not the testpoints should be activated=
.<br>
<br>
When enabled, the testpoint() macro calls an underlying wrapper specific to=
<br>
the testpoint and simply try to lookup the testpoint symbol via a dlsym()<b=
r>
call.<br>
<br>
When disabled, the testpoint() call will only incur an additionnal test<br>
per testpoint on a global variable. This performance &#39;hit&#39; should b=
e<br>
acceptable for production use.<br>
<br>
As stated previously, the testpoint mechanism should be *always on*.<br>
It can be explicitly disabled via CFLAGS=3D&quot;-DNTESTPOINT&quot; in a wa=
y similar<br>
to NDEBUG and assert().<br>
<br>
Comments, thoughts?<br>
<br>
Thanks,<br>
<br>
Christian Babeux (1):<br>
=A0 New testpoint mechanism to instrument LTTng binaries for testing<br>
=A0 =A0 purpose<br>
<br>
=A0<a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a> =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A01 +<br>
=A0src/common/Makefile.am =A0 =A0 =A0 =A0 =A0 | =A02 +-<br>
=A0src/common/testpoint/Makefile.am | =A06 +++<br>
=A0src/common/testpoint/testpoint.c | 43 +++++++++++++++++++++<br>
=A0src/common/testpoint/testpoint.h | 81 ++++++++++++++++++++++++++++++++++=
++++++<br>
=A05 files changed, 132 insertions(+), 1 deletion(-)<br>
=A0create mode 100644 src/common/testpoint/Makefile.am<br>
=A0create mode 100644 src/common/testpoint/testpoint.c<br>
=A0create mode 100644 src/common/testpoint/testpoint.h<br>
<br>
--<br>
1.7.11.4<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div>

--20cf300fb3bd10965704c9754a3a--


--===============0024990273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0024990273==--
