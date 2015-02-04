From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Printing to stdout and stderr from
	the	userspace	library.
Date: Wed, 4 Feb 2015 22:46:39 +0000 (UTC)
Message-ID: <1599170581.76977.1423089999405.JavaMail.zimbra__13489.76173108$1423090043$gmane$org@efficios.com>
References: <CAJaGzgusJKn7EPb-XbZCHBSBGVh-Di9kwcLiYKh-uvTdf-NjCw@mail.gmail.com>
 <1487656020.75537.1423069899682.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0041800936=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YJ8iW-0007ur-Bz
 for lttng-dev@lists.lttng.org; Wed, 04 Feb 2015 17:46:46 -0500
In-Reply-To: <1487656020.75537.1423069899682.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Glen Keane <glenkeane.94@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0041800936==
Content-Type: multipart/alternative;
	boundary="----=_Part_76976_128762730.1423089999405"

------=_Part_76976_128762730.1423089999405
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "Glen Keane" <glenkeane.94@gmail.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Wednesday, February 4, 2015 12:11:39 PM
> Subject: Re: [lttng-dev] Printing to stdout and stderr from the userspace
> library.

> ----- Original Message -----

> > From: "Glen Keane" <glenkeane.94@gmail.com>
> 
> > To: lttng-dev@lists.lttng.org
> 
> > Sent: Wednesday, February 4, 2015 10:13:06 AM
> 
> > Subject: [lttng-dev] Printing to stdout and stderr from the userspace
> > library.
> 

> > Hey Everybody,
> 

> > I'm currently working on getting Lttng tracepoints into node.js/iojs. iojs
> > is
> > a downstream fork of node.js, which I personally hope will be merged back
> > into node.js, which will then include all my tracing work from iojs. I'm
> > currently having some trouble with lttng userspace library printing to
> > stdout/stderr from iojs however.
> 

> > I currently have a pull request issued on the iojs core (
> > https://github.com/iojs/io.js/pull/702 ) and this could hopefully mean we
> > will get lttng tracepoints into the project! :)
> 

> > I have hit an issue with my pull request, however. If you follow the link
> > above you can see @bnoordhuis asked me about a test which I had to modify
> > for this pull request. This particular test passes some variables to a
> > child
> > process, the child prints the variables to stdout/stderr, and the parent
> > takes a pipe of the childs stdout/stderr and compares it to an expected
> > stdout/stderr, and asserts they match. If they don't match, its a
> > catastrophic failure and that single test fails.
> 

> > The issue here is that when you spawn a child process in node.js and pass
> > it
> > a custom ENV variable, the ENV variables available to the child process
> > will
> > not have access to any of the ENV variables of the parent process. This
> > means there is no LTTNG_HOME or HOME env variables available to the child
> > process. This then in turn means that when lttng's userspace library is
> > instantiated it doesn't have access to either of those variables and spits
> > out this warning to stderr:
> 

> > Warning: HOME environment variable not set. Disabling LTTng-UST per-user
> > tracing.
> 

> > I accept this warning is warranted, as there is no tracing location
> > available
> > to the child process so therefore it cannot be traced, but it means that
> > the
> > test fails, as it does not expect this error to printed to stderr. I am
> > looking for a way to silence the output of the library so this test doesn't
> > need to be modified, and so I don't have to implicitly pass a child process
> > the ENV HOME variable or LTTNG-HOME variable. The ability to clear all env
> > variables being passed to a child is a design choice which is acceptable
> > behaviour of io.js.
> 

> > I did not expect a library to print to stderr/stdout however, and I feel
> > that
> > this is something that may need to approached and rectified.
> 

> It makes sense to move the output of this library somewhere else than the
> console, but where,
> and how could we override the behavior without adding an environment
> variable, which seems
> to be impossible to use in your use-case ?

Issue taken care of in lttng-ust master by only showing the lttng-ust library 
error output when either: 

LTTNG_UST_DEBUG env. var. is set, or LTTNG_UST_DEBUG 
is defined at library compile-time. 

See the following commits: 

commit d14c063ab40215ec3c99e7b68483a5e170121a09 
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
Date: Wed Feb 4 17:41:32 2015 -0500 

Update manpage about LTTNG_UST_DEBUG effect 

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 

commit 7bdd21a41092a59207958911666cbd458f93a319 
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
Date: Wed Feb 4 17:39:01 2015 -0500 

Don't output to stderr from lib unless DEBUG is activated 

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 

commit eb2b066ff35dcafa727fae7e8853a9750233063e 
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
Date: Wed Feb 4 17:33:59 2015 -0500 

Remove usterr.h, use usterr-signal-safe.h everywhere instead 

Remove minimally used code. 

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 

Since this is a behavior change, it stay in master until the 
next LTTng release cycle (2.7). 

Feedback is welcome, 

Thanks! 

Mathieu 

> Thoughts ?

> Thanks,

> Mathieu

> > Thanks for reading,
> 
> > Glen Keane.
> 

> > _______________________________________________
> 
> > lttng-dev mailing list
> 
> > lttng-dev@lists.lttng.org
> 
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_76976_128762730.1423089999405
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px s=
olid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight=
: normal; font-style: normal; text-decoration: none; font-family: Helvetica=
,Arial,sans-serif; font-size: 12pt;"><b>From: </b>"Mathieu Desnoyers" &lt;m=
athieu.desnoyers@efficios.com&gt;<br><b>To: </b>"Glen Keane" &lt;glenkeane.=
94@gmail.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>We=
dnesday, February 4, 2015 12:11:39 PM<br><b>Subject: </b>Re: [lttng-dev] Pr=
inting to stdout and stderr from the&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;userspace&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;library.<=
br><div><br></div><div style=3D"font-family: times new roman, new york, tim=
es, serif; font-size: 12pt; color: #000000" data-mce-style=3D"font-family: =
times new roman, new york, times, serif; font-size: 12pt; color: #000000;">=
<hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-=
left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"=
 data-mce-style=3D"border-left: 2px solid #1010FF; margin-left: 5px; paddin=
g-left: 5px; color: #000; font-weight: normal; font-style: normal; text-dec=
oration: none; font-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><=
b>From: </b>"Glen Keane" &lt;glenkeane.94@gmail.com&gt;<br><b>To: </b>lttng=
-dev@lists.lttng.org<br><b>Sent: </b>Wednesday, February 4, 2015 10:13:06 A=
M<br><b>Subject: </b>[lttng-dev] Printing to stdout and stderr from the use=
rspace&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;library.<br><div><br>=
</div><div dir=3D"ltr">Hey Everybody,<br><div><br></div>I'm currently worki=
ng on getting Lttng tracepoints into node.js/iojs. iojs is a downstream for=
k of node.js, which I personally hope will be merged back into node.js, whi=
ch will then include all my tracing work from iojs. I'm currently having so=
me trouble with lttng userspace library printing to stdout/stderr from iojs=
 however.<br><div><br></div>I currently have a pull request issued on the i=
ojs core (<a href=3D"https://github.com/iojs/io.js/pull/702" target=3D"_bla=
nk" data-mce-href=3D"https://github.com/iojs/io.js/pull/702">https://github=
.com/iojs/io.js/pull/702</a>) and this could hopefully mean we will get ltt=
ng tracepoints into the project! :)<br><div><br></div>I have hit an issue w=
ith my pull request, however. If you follow the link above you can see @bno=
ordhuis asked me about a test which I had to modify for this pull request. =
This particular test passes some variables to a child process, the child pr=
ints the variables to stdout/stderr, and the parent takes a pipe of the chi=
lds stdout/stderr and compares it to an expected stdout/stderr, and asserts=
 they match. If they don't match, its a catastrophic failure and that singl=
e test fails.<br><div><br></div>The issue here is that when you spawn a chi=
ld process in node.js and pass it a custom ENV variable, the ENV variables =
available to the child process will not have access to any of the ENV varia=
bles of the parent process. This means there is no LTTNG_HOME or HOME env v=
ariables available to the child process. This then in turn means that when =
lttng's userspace library is instantiated it doesn't have access to either =
of those variables and spits out this warning to stderr:<br><div><br></div>=
<span style=3D"font-family: monospace,monospace;" data-mce-style=3D"font-fa=
mily: monospace,monospace;">Warning: HOME environment variable not set. Dis=
abling LTTng-UST per-user tracing.<br></span><br>I accept this warning is w=
arranted, as there is no tracing location available to the child process so=
 therefore it cannot be traced, but it means that the test fails, as it doe=
s not expect this error to printed to stderr. I am looking for a way to sil=
ence the output of the library so this test doesn't need to be modified, an=
d so I don't have to implicitly pass a child process the ENV HOME variable =
or LTTNG-HOME variable. The ability to clear all env variables being passed=
 to a child is a design choice which is acceptable behaviour of io.js.<br><=
div><br></div>I did not expect a library to print to stderr/stdout however,=
 and I feel that this is something that may need to approached and rectifie=
d.&nbsp;</div></blockquote><div><br></div><div>It makes sense to move the o=
utput of this library somewhere else than the console, but where,<br></div>=
<div>and how could we override the behavior without adding an environment v=
ariable, which seems<br></div><div>to be impossible to use in your use-case=
 ?</div></div></blockquote><div>Issue taken care of in lttng-ust master by =
only showing the lttng-ust library<br></div><div>error output when either:<=
br></div><div><br></div><div>LTTNG_UST_DEBUG env. var. is set, or LTTNG_UST=
_DEBUG<br></div><div>is defined at library compile-time.<br></div><div><br>=
</div><div>See the following commits:<br></div><div><br></div><div>commit d=
14c063ab40215ec3c99e7b68483a5e170121a09<br>Author: Mathieu Desnoyers &lt;ma=
thieu.desnoyers@efficios.com&gt;<br>Date:&nbsp;&nbsp; Wed Feb 4 17:41:32 20=
15 -0500<br><br>&nbsp;&nbsp;&nbsp; Update manpage about LTTNG_UST_DEBUG eff=
ect<br>&nbsp;&nbsp; &nbsp;<br>&nbsp;&nbsp;&nbsp; Signed-off-by: Mathieu Des=
noyers &lt;mathieu.desnoyers@efficios.com&gt;<br><br>commit 7bdd21a41092a59=
207958911666cbd458f93a319<br>Author: Mathieu Desnoyers &lt;mathieu.desnoyer=
s@efficios.com&gt;<br>Date:&nbsp;&nbsp; Wed Feb 4 17:39:01 2015 -0500<br><b=
r>&nbsp;&nbsp;&nbsp; Don't output to stderr from lib unless DEBUG is activa=
ted<br>&nbsp;&nbsp; &nbsp;<br>&nbsp;&nbsp;&nbsp; Signed-off-by: Mathieu Des=
noyers &lt;mathieu.desnoyers@efficios.com&gt;<br><br>commit eb2b066ff35dcaf=
a727fae7e8853a9750233063e<br>Author: Mathieu Desnoyers &lt;mathieu.desnoyer=
s@efficios.com&gt;<br>Date:&nbsp;&nbsp; Wed Feb 4 17:33:59 2015 -0500<br><b=
r>&nbsp;&nbsp;&nbsp; Remove usterr.h, use usterr-signal-safe.h everywhere i=
nstead<br>&nbsp;&nbsp; &nbsp;<br>&nbsp;&nbsp;&nbsp; Remove minimally used c=
ode.<br>&nbsp;&nbsp; &nbsp;<br>&nbsp;&nbsp;&nbsp; Signed-off-by: Mathieu De=
snoyers &lt;mathieu.desnoyers@efficios.com&gt;<br><br></div><div>Since this=
 is a behavior change, it stay in master until the<br></div><div>next LTTng=
 release cycle (2.7).<br></div><div><br></div><div>Feedback is welcome,<br>=
</div><div><br></div><div>Thanks!<br></div><div><br></div><div>Mathieu<br><=
/div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pad=
ding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;" data-mce-st=
yle=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px;=
 color: #000; font-weight: normal; font-style: normal; text-decoration: non=
e; font-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><div style=3D=
"font-family: times new roman, new york, times, serif; font-size: 12pt; col=
or: #000000" data-mce-style=3D"font-family: times new roman, new york, time=
s, serif; font-size: 12pt; color: #000000;"><div><br></div><div><br></div><=
div>Thoughts ?<br></div><div><br></div><div>Thanks,<br></div><div><br></div=
><div>Mathieu<br></div><div><br></div><blockquote style=3D"border-left:2px =
solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt;" data-mce-style=3D"border-left: 2px solid #1010FF; mar=
gin-left: 5px; padding-left: 5px; color: #000; font-weight: normal; font-st=
yle: normal; text-decoration: none; font-family: Helvetica,Arial,sans-serif=
; font-size: 12pt;"><div dir=3D"ltr"><div><br></div>Thanks for reading,<br>=
Glen Keane.<br></div><br>_______________________________________________<br=
>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.=
org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><div><br></=
div></div><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br>Effici=
OS Inc.<br>http://www.efficios.com<br></div></div><br>_____________________=
__________________________<br>lttng-dev mailing list<br>lttng-dev@lists.ltt=
ng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></bl=
ockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span nam=
e=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.co=
m<span name=3D"x"></span><br></div></div></body></html>
------=_Part_76976_128762730.1423089999405--


--===============0041800936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0041800936==--
