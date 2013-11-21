From: Bhaskar Janakiraman <bjanakiraman@chromium.org>
Subject: Re: current_thread_info() not respecting program order
	with gcc 4.8.x
Date: Thu, 21 Nov 2013 15:03:50 -0800
Message-ID: <CA+1cYqStNbLd0NZ1y7toWA+gS_6KsgFgFX0yqNit+SVm5oTcvQ__19047.5918040194$1386054867$gmane$org@mail.gmail.com>
References: <52803E5D.3050109@mentor.com> <52851395.3010306@mentor.com>
	<67652521.68027.1384482849638.JavaMail.zimbra@efficios.com>
	<1691607547.70809.1384874952002.JavaMail.zimbra@efficios.com>
	<CA+55aFw923sA0E1RQNxFF0OWFtAfcaG-dBUc-0YYZGDSAsaQyg@mail.gmail.com>
	<528E2E8E.8080004@ahsoftware.de>
	<CA+55aFyNZun07BLoD2KQFT7cN1xsiQ2gE6hYwRvOGa3tCap4CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1830655652=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bjanakiraman@google.com>) id 1VjdHx-0008Ep-1B
	for lttng-dev@lists.lttng.org; Thu, 21 Nov 2013 18:04:03 -0500
Received: by mail-qe0-f44.google.com with SMTP id b10so379652qen.31
	for <lttng-dev@lists.lttng.org>; Thu, 21 Nov 2013 15:03:51 -0800 (PST)
In-Reply-To: <CA+55aFyNZun07BLoD2KQFT7cN1xsiQ2gE6hYwRvOGa3tCap4CQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Han Shen <shenhan@chromium.org>, Luis Lozano <llozano@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nathan Lynch <Nathan_Lynch@mentor.com>, lttng-dev@lists.lttng.org, Alexander Holler <holler@ahsoftware.de>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>
List-Id: lttng-dev@lists.lttng.org

--===============1830655652==
Content-Type: multipart/alternative; boundary=001a11c215cc30078104ebb7e979

--001a11c215cc30078104ebb7e979
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Nov 21, 2013 at 2:32 PM, Linus Torvalds <
torvalds@linux-foundation.org> wrote:

> On Thu, Nov 21, 2013 at 8:02 AM, Alexander Holler <holler@ahsoftware.de>
> wrote:
> >
> > Luis Lozano just noted (see https://lkml.org/lkml/2013/11/20/625) that
> > current_thread_info() has the prototype
> >
> > static inline struct thread_info *current_thread_info(void)
> > __attribute_const__;
> >
> > on arm (and arm64 and unicore32, something the paste from Mathieu missed
> so
> > most people here might have missed that detail too). It's a very good
> > finding from Luis.
>

Can someone provide a test case? We are unable to reproduce the problem in
ChromeOS land.


>
> No, because it is immaterial.
>
> We *want* gcc to optimize away multiple accesses to "sp". Because it
> doesn't *matter* whether "sp" changes or not, the *result* is always
> the same. That's what the "const" means.
>
> The "& ~(THREAD_SIZE - 1)" part will remove all the bits that can
> change. Really. So the result *is* constant (within one thread).
> Marking it constant and telling gcc that it can combine these things
> is correct.
>

Its unfortunate that the attribute '__const__ ' is very misleading - the
semantic used by gcc is that this is an aliasing attribute that implies
that the function does not depend in any way on global state. Meaning, if
called with the same parameters, it expected to return the same value. It
should have been called 'pure', but gcc has a different 'pure' attribute
that imples something different :-(

That said, gcc should be smart enough to figure out that this function is
 not doing anything complicated. Again, a test case would be much
appreciated.

Bhaskar



> Guys, read my email again.
>
> The bug is not that gcc can re-order or combine the accesses to "sp".
> WE WANT THAT TO HAPPEN.
>
> The bug is *outside* that "current_thread_info()" macro/inline
> function. It's the *dereference* of the pointer that gcc re-orders.
> AND THAT IS WRONG.
>
> Gcc seems to mess up the alias analysis, and decide that the
> deferences cannot alias. Which is wrong. They clearly *can* alias,
> exactly because the value of "sp & ~(THREAD_SIZE - 1)" ends up having
> the same value all the time.
>
>






                 Linus
>

--001a11c215cc30078104ebb7e979
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
hu, Nov 21, 2013 at 2:32 PM, Linus Torvalds <span dir=3D"ltr">&lt;<a href=
=3D"mailto:torvalds@linux-foundation.org" target=3D"_blank">torvalds@linux-=
foundation.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">On Thu, Nov 21, 2013 at 8:02 AM, Alexand=
er Holler &lt;<a href=3D"mailto:holler@ahsoftware.de">holler@ahsoftware.de<=
/a>&gt; wrote:<br>

&gt;<br>
</div><div class=3D"im">&gt; Luis Lozano just noted (see <a href=3D"https:/=
/lkml.org/lkml/2013/11/20/625" target=3D"_blank">https://lkml.org/lkml/2013=
/11/20/625</a>) that<br>
&gt; current_thread_info() has the prototype<br>
&gt;<br>
&gt; static inline struct thread_info *current_thread_info(void)<br>
&gt; __attribute_const__;<br>
&gt;<br>
&gt; on arm (and arm64 and unicore32, something the paste from Mathieu miss=
ed so<br>
&gt; most people here might have missed that detail too). It&#39;s a very g=
ood<br>
&gt; finding from Luis.<br></div></blockquote><div><br></div><div>Can someo=
ne provide a test case? We are unable to reproduce the problem in ChromeOS =
land.=A0</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,20=
4);border-left-style:solid;padding-left:1ex">
<div class=3D"im">
<br>
</div>No, because it is immaterial.<br>
<br>
We *want* gcc to optimize away multiple accesses to &quot;sp&quot;. Because=
 it<br>
doesn&#39;t *matter* whether &quot;sp&quot; changes or not, the *result* is=
 always<br>
the same. That&#39;s what the &quot;const&quot; means.<br>
<br>
The &quot;&amp; ~(THREAD_SIZE - 1)&quot; part will remove all the bits that=
 can<br>
change. Really. So the result *is* constant (within one thread).<br>
Marking it constant and telling gcc that it can combine these things<br>
is correct.<br></blockquote><div><br></div><div>Its unfortunate that the at=
tribute &#39;__const__ &#39; is very misleading - the semantic used by gcc =
is that this is an aliasing attribute that implies that the function does n=
ot depend in any way on global state. Meaning, if called with the same para=
meters, it expected to return the same value. It should have been called &#=
39;pure&#39;, but gcc has a different &#39;pure&#39; attribute that imples =
something different :-(</div>
<div><br></div><div>That said, gcc should be smart enough to figure out tha=
t this function is =A0not doing anything complicated. Again, a test case wo=
uld be much appreciated.</div><div><br></div><div>Bhaskar</div><div><br></d=
iv>
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex">
<br>
Guys, read my email again.<br>
<br>
The bug is not that gcc can re-order or combine the accesses to &quot;sp&qu=
ot;.<br>
WE WANT THAT TO HAPPEN.<br>
<br>
The bug is *outside* that &quot;current_thread_info()&quot; macro/inline<br=
>
function. It&#39;s the *dereference* of the pointer that gcc re-orders.<br>
AND THAT IS WRONG.<br>
<br>
Gcc seems to mess up the alias analysis, and decide that the<br>
deferences cannot alias. Which is wrong. They clearly *can* alias,<br>
exactly because the value of &quot;sp &amp; ~(THREAD_SIZE - 1)&quot; ends u=
p having<br>
the same value all the time.<br>
<span class=3D""><font color=3D"#888888"><br></font></span></blockquote><di=
v><br></div><div><br></div><div><br></div><div><br></div><div><br></div><di=
v><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex">
<span class=3D""><font color=3D"#888888">
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus<br>
</font></span></blockquote></div><br></div></div>

--001a11c215cc30078104ebb7e979--


--===============1830655652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1830655652==--
