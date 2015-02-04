From: Glen Keane <glenkeane.94@gmail.com>
Subject: Re: Printing to stdout and stderr from the userspace
	library.
Date: Wed, 4 Feb 2015 23:05:42 +0000
Message-ID: <CAJaGzgtRraOEEPMxS224-fjisYYc26N8jyN3EYumOntfaH839g__49482.0516593338$1423091235$gmane$org@mail.gmail.com>
References: <CAJaGzgusJKn7EPb-XbZCHBSBGVh-Di9kwcLiYKh-uvTdf-NjCw@mail.gmail.com>
 <1487656020.75537.1423069899682.JavaMail.zimbra@efficios.com>
 <1599170581.76977.1423089999405.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0836628051=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <glenkeane.94@gmail.com>) id 1YJ911-00082t-Px
 for lttng-dev@lists.lttng.org; Wed, 04 Feb 2015 18:05:49 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so35275318wiv.0
 for <lttng-dev@lists.lttng.org>; Wed, 04 Feb 2015 15:05:42 -0800 (PST)
In-Reply-To: <1599170581.76977.1423089999405.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0836628051==
Content-Type: multipart/alternative; boundary=f46d04428b860367ac050e4b3a62

--f46d04428b860367ac050e4b3a62
Content-Type: text/plain; charset=UTF-8

Wow, thanks for quickly dealing with this issue!

Glen.

On Wed, Feb 4, 2015 at 10:46 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ------------------------------
>
> *From: *"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> *To: *"Glen Keane" <glenkeane.94@gmail.com>
> *Cc: *lttng-dev@lists.lttng.org
> *Sent: *Wednesday, February 4, 2015 12:11:39 PM
> *Subject: *Re: [lttng-dev] Printing to stdout and stderr from
> the        userspace        library.
>
>
> ------------------------------
>
> *From: *"Glen Keane" <glenkeane.94@gmail.com>
> *To: *lttng-dev@lists.lttng.org
> *Sent: *Wednesday, February 4, 2015 10:13:06 AM
> *Subject: *[lttng-dev] Printing to stdout and stderr from the
> userspace        library.
>
> Hey Everybody,
>
> I'm currently working on getting Lttng tracepoints into node.js/iojs. iojs
> is a downstream fork of node.js, which I personally hope will be merged
> back into node.js, which will then include all my tracing work from iojs.
> I'm currently having some trouble with lttng userspace library printing to
> stdout/stderr from iojs however.
>
> I currently have a pull request issued on the iojs core (
> https://github.com/iojs/io.js/pull/702) and this could hopefully mean we
> will get lttng tracepoints into the project! :)
>
> I have hit an issue with my pull request, however. If you follow the link
> above you can see @bnoordhuis asked me about a test which I had to modify
> for this pull request. This particular test passes some variables to a
> child process, the child prints the variables to stdout/stderr, and the
> parent takes a pipe of the childs stdout/stderr and compares it to an
> expected stdout/stderr, and asserts they match. If they don't match, its a
> catastrophic failure and that single test fails.
>
> The issue here is that when you spawn a child process in node.js and pass
> it a custom ENV variable, the ENV variables available to the child process
> will not have access to any of the ENV variables of the parent process.
> This means there is no LTTNG_HOME or HOME env variables available to the
> child process. This then in turn means that when lttng's userspace library
> is instantiated it doesn't have access to either of those variables and
> spits out this warning to stderr:
>
> Warning: HOME environment variable not set. Disabling LTTng-UST per-user
> tracing.
>
> I accept this warning is warranted, as there is no tracing location
> available to the child process so therefore it cannot be traced, but it
> means that the test fails, as it does not expect this error to printed to
> stderr. I am looking for a way to silence the output of the library so this
> test doesn't need to be modified, and so I don't have to implicitly pass a
> child process the ENV HOME variable or LTTNG-HOME variable. The ability to
> clear all env variables being passed to a child is a design choice which is
> acceptable behaviour of io.js.
>
> I did not expect a library to print to stderr/stdout however, and I feel
> that this is something that may need to approached and rectified.
>
>
> It makes sense to move the output of this library somewhere else than the
> console, but where,
> and how could we override the behavior without adding an environment
> variable, which seems
> to be impossible to use in your use-case ?
>
> Issue taken care of in lttng-ust master by only showing the lttng-ust
> library
> error output when either:
>
> LTTNG_UST_DEBUG env. var. is set, or LTTNG_UST_DEBUG
> is defined at library compile-time.
>
> See the following commits:
>
> commit d14c063ab40215ec3c99e7b68483a5e170121a09
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Feb 4 17:41:32 2015 -0500
>
>     Update manpage about LTTNG_UST_DEBUG effect
>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> commit 7bdd21a41092a59207958911666cbd458f93a319
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Feb 4 17:39:01 2015 -0500
>
>     Don't output to stderr from lib unless DEBUG is activated
>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> commit eb2b066ff35dcafa727fae7e8853a9750233063e
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Feb 4 17:33:59 2015 -0500
>
>     Remove usterr.h, use usterr-signal-safe.h everywhere instead
>
>     Remove minimally used code.
>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> Since this is a behavior change, it stay in master until the
> next LTTng release cycle (2.7).
>
> Feedback is welcome,
>
> Thanks!
>
> Mathieu
>
>
>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
>
> Thanks for reading,
> Glen Keane.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--f46d04428b860367ac050e4b3a62
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Wow, thanks for quickly dealing with this issue!<br><br>Gl=
en.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, =
Feb 4, 2015 at 10:46 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D=
"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers=
@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>=
<div style=3D"font-family:times new roman,new york,times,serif;font-size:12=
pt;color:#000000"><hr><blockquote style=3D"border-left:2px solid #1010ff;ma=
rgin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:nor=
mal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:1=
2pt"><b>From: </b>&quot;Mathieu Desnoyers&quot; &lt;<a href=3D"mailto:mathi=
eu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com=
</a>&gt;<br><b>To: </b>&quot;Glen Keane&quot; &lt;<a href=3D"mailto:glenkea=
ne.94@gmail.com" target=3D"_blank">glenkeane.94@gmail.com</a>&gt;<br><b>Cc:=
 </b><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br><b>Sent: </b>Wednesday, February 4, 2015 12:11:39=
 PM<br><b>Subject: </b>Re: [lttng-dev] Printing to stdout and stderr from t=
he=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0userspace=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0library.<div><div class=3D"h5"><br><div><b=
r></div><div style=3D"font-family:times new roman,new york,times,serif;font=
-size:12pt;color:#000000"><hr><blockquote style=3D"border-left:2px solid #1=
010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-s=
tyle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fon=
t-size:12pt"><b>From: </b>&quot;Glen Keane&quot; &lt;<a href=3D"mailto:glen=
keane.94@gmail.com" target=3D"_blank">glenkeane.94@gmail.com</a>&gt;<br><b>=
To: </b><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttn=
g-dev@lists.lttng.org</a><br><b>Sent: </b>Wednesday, February 4, 2015 10:13=
:06 AM<br><b>Subject: </b>[lttng-dev] Printing to stdout and stderr from th=
e userspace=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0library.<br><div=
><br></div><div dir=3D"ltr">Hey Everybody,<br><div><br></div>I&#39;m curren=
tly working on getting Lttng tracepoints into node.js/iojs. iojs is a downs=
tream fork of node.js, which I personally hope will be merged back into nod=
e.js, which will then include all my tracing work from iojs. I&#39;m curren=
tly having some trouble with lttng userspace library printing to stdout/std=
err from iojs however.<br><div><br></div>I currently have a pull request is=
sued on the iojs core (<a href=3D"https://github.com/iojs/io.js/pull/702" t=
arget=3D"_blank">https://github.com/iojs/io.js/pull/702</a>) and this could=
 hopefully mean we will get lttng tracepoints into the project! :)<br><div>=
<br></div>I have hit an issue with my pull request, however. If you follow =
the link above you can see @bnoordhuis asked me about a test which I had to=
 modify for this pull request. This particular test passes some variables t=
o a child process, the child prints the variables to stdout/stderr, and the=
 parent takes a pipe of the childs stdout/stderr and compares it to an expe=
cted stdout/stderr, and asserts they match. If they don&#39;t match, its a =
catastrophic failure and that single test fails.<br><div><br></div>The issu=
e here is that when you spawn a child process in node.js and pass it a cust=
om ENV variable, the ENV variables available to the child process will not =
have access to any of the ENV variables of the parent process. This means t=
here is no LTTNG_HOME or HOME env variables available to the child process.=
 This then in turn means that when lttng&#39;s userspace library is instant=
iated it doesn&#39;t have access to either of those variables and spits out=
 this warning to stderr:<br><div><br></div><span style=3D"font-family:monos=
pace,monospace">Warning: HOME environment variable not set. Disabling LTTng=
-UST per-user tracing.<br></span><br>I accept this warning is warranted, as=
 there is no tracing location available to the child process so therefore i=
t cannot be traced, but it means that the test fails, as it does not expect=
 this error to printed to stderr. I am looking for a way to silence the out=
put of the library so this test doesn&#39;t need to be modified, and so I d=
on&#39;t have to implicitly pass a child process the ENV HOME variable or L=
TTNG-HOME variable. The ability to clear all env variables being passed to =
a child is a design choice which is acceptable behaviour of io.js.<br><div>=
<br></div>I did not expect a library to print to stderr/stdout however, and=
 I feel that this is something that may need to approached and rectified.=
=C2=A0</div></blockquote><div><br></div><div>It makes sense to move the out=
put of this library somewhere else than the console, but where,<br></div><d=
iv>and how could we override the behavior without adding an environment var=
iable, which seems<br></div><div>to be impossible to use in your use-case ?=
</div></div></div></div></blockquote><div>Issue taken care of in lttng-ust =
master by only showing the lttng-ust library<br></div><div>error output whe=
n either:<br></div><div><br></div><div>LTTNG_UST_DEBUG env. var. is set, or=
 LTTNG_UST_DEBUG<br></div><div>is defined at library compile-time.<br></div=
><div><br></div><div>See the following commits:<br></div><div><br></div><di=
v>commit d14c063ab40215ec3c99e7b68483a5e170121a09<br>Author: Mathieu Desnoy=
ers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank"=
>mathieu.desnoyers@efficios.com</a>&gt;<br>Date:=C2=A0=C2=A0 Wed Feb 4 17:4=
1:32 2015 -0500<br><br>=C2=A0=C2=A0=C2=A0 Update manpage about LTTNG_UST_DE=
BUG effect<br>=C2=A0=C2=A0 =C2=A0<br>=C2=A0=C2=A0=C2=A0 Signed-off-by: Math=
ieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=
=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br><br>commit 7bdd21a410=
92a59207958911666cbd458f93a319<br>Author: Mathieu Desnoyers &lt;<a href=3D"=
mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@=
efficios.com</a>&gt;<br>Date:=C2=A0=C2=A0 Wed Feb 4 17:39:01 2015 -0500<br>=
<br>=C2=A0=C2=A0=C2=A0 Don&#39;t output to stderr from lib unless DEBUG is =
activated<br>=C2=A0=C2=A0 =C2=A0<br>=C2=A0=C2=A0=C2=A0 Signed-off-by: Mathi=
eu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=
=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br><br>commit eb2b066ff3=
5dcafa727fae7e8853a9750233063e<br>Author: Mathieu Desnoyers &lt;<a href=3D"=
mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@=
efficios.com</a>&gt;<br>Date:=C2=A0=C2=A0 Wed Feb 4 17:33:59 2015 -0500<br>=
<br>=C2=A0=C2=A0=C2=A0 Remove usterr.h, use usterr-signal-safe.h everywhere=
 instead<br>=C2=A0=C2=A0 =C2=A0<br>=C2=A0=C2=A0=C2=A0 Remove minimally used=
 code.<br>=C2=A0=C2=A0 =C2=A0<br>=C2=A0=C2=A0=C2=A0 Signed-off-by: Mathieu =
Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_=
blank">mathieu.desnoyers@efficios.com</a>&gt;<br><br></div><div>Since this =
is a behavior change, it stay in master until the<br></div><div>next LTTng =
release cycle (2.7).<br></div><div><br></div><div>Feedback is welcome,<br><=
/div><div><br></div><div>Thanks!<span class=3D"HOEnZb"><font color=3D"#8888=
88"><br></font></span></div><span class=3D"HOEnZb"><font color=3D"#888888">=
<div><br></div><div>Mathieu<br></div></font></span><span class=3D""><blockq=
uote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt"><div style=3D"font-famil=
y:times new roman,new york,times,serif;font-size:12pt;color:#000000"><div><=
br></div><div><br></div><div>Thoughts ?<br></div><div><br></div><div>Thanks=
,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><blockquote =
style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px;col=
or:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fami=
ly:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><br></d=
iv>Thanks for reading,<br>Glen Keane.<br></div><br>________________________=
_______________________<br>lttng-dev mailing list<br><a href=3D"mailto:lttn=
g-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><=
a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=
=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><b=
r></blockquote><div><br><div><br></div></div><div><br></div><div>-- <br></d=
iv><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficio=
s.com" target=3D"_blank">http://www.efficios.com</a><br></div></div><br>___=
____________________________________________<br>lttng-dev mailing list<br><=
a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lis=
ts.lttng.org</a><br><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/lis=
tinfo/lttng-dev</a><br></blockquote><div><br><br></div><div><br></div><div>=
-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc=
.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effic=
ios.com</a><span name=3D"x"></span><br></div></span></div></div></blockquot=
e></div><br></div>

--f46d04428b860367ac050e4b3a62--


--===============0836628051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0836628051==--
