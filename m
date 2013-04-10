From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
Subject: Re: LTTng system call tracing on ARM
Date: Wed, 10 Apr 2013 09:38:33 -0400
Message-ID: <CA+umk=pPAvGqkC2pPfr6sA3sPtZroKoPegJ6gET2eBYSPp4Fhw__19691.3218278953$1365601151$gmane$org@mail.gmail.com>
References: <20130410084053.GB25958@hal>
	<CA+umk=pX-4t74XQqsP+vLsDGF1atWzUi75gmSyoVGsDkqQcB7g@mail.gmail.com>
	<20130410130246.GA12801@hal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1452861421=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <b0mb00z.it@gmail.com>) id 1UPvEV-0004OI-CL
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 09:38:39 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so320020pad.31
	for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2013 06:38:33 -0700 (PDT)
In-Reply-To: <20130410130246.GA12801@hal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1452861421==
Content-Type: multipart/alternative; boundary=047d7b6d9354486a1f04da01c9ae

--047d7b6d9354486a1f04da01c9ae
Content-Type: text/plain; charset=ISO-8859-1

Here are the links I stashed a while back about previous patching attempts
to add syscall tracepoints to the ARM kernel :

Most promising:
http://www.spinics.net/lists/arm-kernel/msg166419.html

Earlier draft(s):
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086974.html
https://lkml.org/lkml/2011/12/1/131
http://comments.gmane.org/gmane.linux.ports.arm.kernel/141933

I believe the first link shows the most refined patch there is out there,
but it might take some minor tinkering to apply it to a different kernel
version. I briefly tried to apply it to the 3.0.31 kernel, but it's a bit
out of my 'tinkering' range, and I never finished it.


Good luck!

-PL



On Wed, Apr 10, 2013 at 9:02 AM, Jan Glauber <jan.glauber@gmail.com> wrote:

> On Wed, Apr 10, 2013 at 08:37:18AM -0400, PLSTC wrote:
> > Hey Jan,
> >
> > I cannot speak on behalf of everyone here, but during our attempt to port
> > LTTng to Android, we also noticed that the kernels we were using (3.0.x)
> > were nowhere near the requirements for syscall tracepoints support. I
> > believe such support was added on x86/64 way earlier (early 3.x) than on
> > ARM, which is why it was included in LTTng's modules a while ago. Simply
> > put, the ARM kernel is late.
>
> OK, so for ARM kernel version 3.6 is the minimum unless the syscall
> tracepoint
> support is backported.
>
> > There are a few actuals ways to 'enable' syscall tracepoints support on
> > early ARM kernels, but they all including a bit of kernel
> hacking/patching.
> > I could send you some links if you're interested in that.
>
> Yes, sure!
>
> --Jan
>
> > -PL
> > On Apr 10, 2013 4:40 AM, "Jan Glauber" <jan.glauber@gmail.com> wrote:
> >
> > > Hi,
> > >
> > > I want to use LTTng for system call tracing on ARM. Now lttng-modules
> seems
> > > to support system call tracing on ARM already since
> > > "8f4f80e LTTng Modules ARM syscall instrumentation".
> > >
> > > But I wonder how that worked since lttng-syscalls.c is only build under
> > > CONFIG_HAVE_SYSCALL_TRACEPOINTS and that was added to ARM only with
> kernel
> > > 3.6
> > > (much after than the lttng-modules commit).
> > >
> > > Am I missing something? Is system call tracing working on ARM with the
> > > upstream
> > > LTTng version?
> > >
> > > thanks,
> > > Jan
> > >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
>

--047d7b6d9354486a1f04da01c9ae
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Here are the links I stashed a while back about previous p=
atching attempts to add syscall tracepoints to the ARM kernel :<div><br></d=
iv><div style>Most promising:</div><div style><a href=3D"http://www.spinics=
.net/lists/arm-kernel/msg166419.html">http://www.spinics.net/lists/arm-kern=
el/msg166419.html</a><br>
</div><div style><br></div><div style>Earlier draft(s):</div><div style><a =
href=3D"http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February=
/086974.html">http://lists.infradead.org/pipermail/linux-arm-kernel/2012-Fe=
bruary/086974.html</a><br>
</div><div style><a href=3D"https://lkml.org/lkml/2011/12/1/131">https://lk=
ml.org/lkml/2011/12/1/131</a><br></div><div style><a href=3D"http://comment=
s.gmane.org/gmane.linux.ports.arm.kernel/141933">http://comments.gmane.org/=
gmane.linux.ports.arm.kernel/141933</a><br>
</div><div style><br></div><div style>I believe the first link shows the mo=
st refined patch there is out there, but it might take some minor tinkering=
 to apply it to a different kernel version. I briefly tried to apply it to =
the 3.0.31 kernel, but it&#39;s a bit out of my &#39;tinkering&#39; range, =
and I never finished it.</div>
<div style><br></div><div style><br></div><div style>Good luck!</div><div s=
tyle><br></div><div style>-PL</div><div style><br></div></div><div class=3D=
"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed, Apr 10, 2013 at 9:=
02 AM, Jan Glauber <span dir=3D"ltr">&lt;<a href=3D"mailto:jan.glauber@gmai=
l.com" target=3D"_blank">jan.glauber@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Wed, Apr 10, 2013 at 08=
:37:18AM -0400, PLSTC wrote:<br>
&gt; Hey Jan,<br>
&gt;<br>
&gt; I cannot speak on behalf of everyone here, but during our attempt to p=
ort<br>
&gt; LTTng to Android, we also noticed that the kernels we were using (3.0.=
x)<br>
&gt; were nowhere near the requirements for syscall tracepoints support. I<=
br>
&gt; believe such support was added on x86/64 way earlier (early 3.x) than =
on<br>
&gt; ARM, which is why it was included in LTTng&#39;s modules a while ago. =
Simply<br>
&gt; put, the ARM kernel is late.<br>
<br>
</div>OK, so for ARM kernel version 3.6 is the minimum unless the syscall t=
racepoint<br>
support is backported.<br>
<div class=3D"im"><br>
&gt; There are a few actuals ways to &#39;enable&#39; syscall tracepoints s=
upport on<br>
&gt; early ARM kernels, but they all including a bit of kernel hacking/patc=
hing.<br>
&gt; I could send you some links if you&#39;re interested in that.<br>
<br>
</div>Yes, sure!<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--Jan<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; -PL<br>
&gt; On Apr 10, 2013 4:40 AM, &quot;Jan Glauber&quot; &lt;<a href=3D"mailto=
:jan.glauber@gmail.com">jan.glauber@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; I want to use LTTng for system call tracing on ARM. Now lttng-mod=
ules seems<br>
&gt; &gt; to support system call tracing on ARM already since<br>
&gt; &gt; &quot;8f4f80e LTTng Modules ARM syscall instrumentation&quot;.<br=
>
&gt; &gt;<br>
&gt; &gt; But I wonder how that worked since lttng-syscalls.c is only build=
 under<br>
&gt; &gt; CONFIG_HAVE_SYSCALL_TRACEPOINTS and that was added to ARM only wi=
th kernel<br>
&gt; &gt; 3.6<br>
&gt; &gt; (much after than the lttng-modules commit).<br>
&gt; &gt;<br>
&gt; &gt; Am I missing something? Is system call tracing working on ARM wit=
h the<br>
&gt; &gt; upstream<br>
&gt; &gt; LTTng version?<br>
&gt; &gt;<br>
&gt; &gt; thanks,<br>
&gt; &gt; Jan<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; lttng-dev mailing list<br>
&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttn=
g.org</a><br>
&gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttn=
g-dev</a><br>
&gt; &gt;<br>
</div></div></blockquote></div><br></div>

--047d7b6d9354486a1f04da01c9ae--


--===============1452861421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1452861421==--
