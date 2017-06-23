From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: liburcu's assertion failed when cannot allocate
 memory
Date: Fri, 23 Jun 2017 15:57:14 +0000 (UTC)
Message-ID: <219865926.1427.1498233433988.JavaMail.zimbra__7165.87860738418$1498233852$gmane$org@efficios.com>
References: <CA+prXCGO_VUK5Y_Rj8M2w3S6SDof4eFSVv3WLOg2+XwgiKGwCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1025521823470627785=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wvNZ22w1TztF3
 for <lttng-dev@lists.lttng.org>; Fri, 23 Jun 2017 16:04:41 +0000 (UTC)
In-Reply-To: <CA+prXCGO_VUK5Y_Rj8M2w3S6SDof4eFSVv3WLOg2+XwgiKGwCQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Denis Yevgenyevich <denis.yevgenyevich@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============1025521823470627785==
Content-Type: multipart/alternative;
	boundary="=_b3a7f61b-74c6-4b93-bf12-5953fe3c9f20"

--=_b3a7f61b-74c6-4b93-bf12-5953fe3c9f20
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jun 15, 2017, at 9:02 AM, Denis Yevgenyevich <denis.yevgenyevich@gmail.com> wrote: 

> My memory-constrained application dumps core saying

> Assertion failed: (!ret), function _cds_wfcq_init, file
> ./urcu/static/wfcqueue.h, line 107.
> Abort

> The function was called from the call_rcu thread, my app does not call wfcqueue
> directly.

> My operating system is FreeBSD-10.3, you won't reproduce the failure in Linux.
> Apparently developers assumed that pthread_mutex_init cannot fail. This
> assumption is ok for Linux, but not so with FreeBSD, which allocates mutexes
> with calloc.

> Could you please add proper error handling so that (at least) call_rcu threads
> could cope with memory allocation failures?

> Cheers...

Hi, 

There are interfaces in liburcu such as rcu_read_lock and call_rcu for which we 
don't want to impose error-handling to users. And in a vast majority of applications, 
aborting on memory allocation failure appears to be acceptable. So let's see how 
we could allow special use-cases like yours to be fulfilled without making the API 
needlessly complex. 

One possibility would be to add optional handling of out-of-memory scenarios 
through handlers registered by the application. An application could then use 
setjmp before calling liburcu functions and longjmp from the registered handler 
to recover from those errors. Of course, liburcu would have to ensure it's undoing 
its side-effects before invoking the application-provided out-of-memory handler. 

Thoughts ? 

Thanks, 

Mathieu 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_b3a7f61b-74c6-4b93-bf12-5953fe3c9f20
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><span id=3D"zwchr" data-marker=3D=
"__DIVIDER__">----- On Jun 15, 2017, at 9:02 AM, Denis Yevgenyevich &lt;den=
is.yevgenyevich@gmail.com&gt; wrote:<br></span><div data-marker=3D"__QUOTED=
_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px=
;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-deco=
ration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div di=
r=3D"ltr"><div><div><div>My memory-constrained application dumps core sayin=
g<br><br>Assertion failed: (!ret), function _cds_wfcq_init, file ./urcu/sta=
tic/wfcqueue.h, line 107.<br>Abort<br><br></div><div>The function was calle=
d from the call_rcu thread, my app does not call wfcqueue directly.<br></di=
v><div><br>My operating system is FreeBSD-10.3, you won't reproduce the fai=
lure in Linux.<br></div> Apparently developers assumed that pthread_mutex_i=
nit cannot fail. This assumption is ok for Linux, but not so with FreeBSD, =
which allocates mutexes with calloc.<br><br></div>Could you please add prop=
er error handling so that (at least) call_rcu threads could cope with memor=
y allocation failures?<br><br></div>Cheers...</div></blockquote><div><br></=
div><div>Hi,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></=
div><div>There are interfaces in liburcu such as rcu_read_lock and call_rcu=
 for which we<br data-mce-bogus=3D"1"></div><div>don't want to impose error=
-handling to users. And in a vast majority of applications,</div><div>abort=
ing on memory allocation failure appears to be acceptable. So let's see how=
</div><div>we could allow special use-cases like yours to be fulfilled with=
out making the API</div><div>needlessly complex.<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><div>One possibility would be to ad=
d optional handling of out-of-memory scenarios<br data-mce-bogus=3D"1"></di=
v><div>through handlers registered by the application. An application could=
 then use</div><div>setjmp before calling liburcu functions and longjmp fro=
m the registered handler<br data-mce-bogus=3D"1"></div><div>to recover from=
 those errors. Of course, liburcu would have to ensure it's undoing<br data=
-mce-bogus=3D"1"></div><div>its side-effects before invoking the applicatio=
n-provided out-of-memory handler.<br data-mce-bogus=3D"1"></div><div><br da=
ta-mce-bogus=3D"1"></div><div>Thoughts ?<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div>=
<div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px s=
olid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt;"><div dir=3D"ltr"><br></div><br>_______________________=
________________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng=
.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blo=
ckquote></div><br><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathi=
eu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body>=
</html>
--=_b3a7f61b-74c6-4b93-bf12-5953fe3c9f20--

--===============1025521823470627785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1025521823470627785==--
