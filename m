From: Bernhard Reutner-Fischer <rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bogus openembedded gcc patch
Date: Tue, 26 Jan 2016 19:51:35 +0100
Message-ID: <CAC1BbcRi+Vf0Y=Jxt3bZwMvs2V6fSQQkTfasrDHMWRdyjoUNzA@mail.gmail.com>
References: <1037243108.4336.1453770172960.JavaMail.zimbra@efficios.com>
	<51287CFC-6F3C-43B1-9190-84F3B20C192E@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0113543954=="
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <51287CFC-6F3C-43B1-9190-84F3B20C192E-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lttng-dev <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>, oe-core <openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

--===============0113543954==
Content-Type: multipart/alternative; boundary=001a113fcf0ec2714e052a412c6d

--001a113fcf0ec2714e052a412c6d
Content-Type: text/plain; charset=UTF-8

On 26 Jan 2016 17:28, "Khem Raj" <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>
> > On Jan 25, 2016, at 8:02 PM, Mathieu Desnoyers <
mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org> wrote:
> >
> > Hi,
> >
> > We are noticing the presence of the following patch in various
> > openembedded gcc versions:
> >
> > 0024-PR-target-32219.patch
> >
> > "From e0d15f4f8bf28c351b9215ca37f1caa24df0e1fd Mon Sep 17 00:00:00 2001
> > From: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Date: Fri, 29 Mar 2013 09:18:54 +0400
> > Subject: [PATCH 24/35] PR target/32219
> >
> > * varasm.c (default_binds_local_p_1): Weak data is not local.
> >
> > Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > Upstream-Status: Backport"
> >
> > However, contrarily to its "Backport" status, that patch is
> > not upstream in gcc, and we're starting to wonder if this
> > would be the patch that breaks handling of start/stop automatic
> > hidden symbols we use in lttng-ust.
> >
> > We are only experiencing problems on the various openembedded
> > compilers, but on no other distro (with same compiler versions),
> > which leads us to suspect a buggy distro-specific gcc patch.
> >
> > We've been testing with openembedded gcc-4.9.2-r0.
> >
> > The original gold linker issue that this patch was trying to
> > address seems to have been fixed in the gold linke since
> > then.
> >
> > Refs:
> > http://lists.lttng.org/pipermail/lttng-dev/2014-May/023112.html
> > https://gcc.gnu.org/ml/gcc-help/2014-05/msg00042.html
> >
http://cgit.openembedded.org/openembedded-core/commit/?id=3cb2b003db7371b3a47d02c08352a262e1e419b4
> > https://sourceware.org/bugzilla/show_bug.cgi?id=15435
> >
> > Thoughts ?
>
> OE has defaulted to gcc5 since last release, and gold issue is fixed in
binutils 2.25
> which is what we use in 2.0 as well so it might be OK to unbolt this fix.
Although I am not sure
> about the original problem reported in PR32219 is fixed for gcc 4.9 if we
remove this fix.
> Have you narrowed down your issue to this patch ? if not, then it would
be good to do so

See http://gcc.gnu.org/PR32219 this is fixed for at least 6.0 so should
certainly be dropped for any fixed GCC. Not sure if anybody is willing to
backport this one, you might ask.

Thanks,
>
> >
> > Thanks,
> >
> > Mathieu
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
>

--001a113fcf0ec2714e052a412c6d
Content-Type: text/html; charset=UTF-8

<p dir="ltr"><br>
On 26 Jan 2016 17:28, &quot;Khem Raj&quot; &lt;<a href="mailto:raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; &gt; On Jan 25, 2016, at 8:02 PM, Mathieu Desnoyers &lt;<a href="mailto:mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org">mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; We are noticing the presence of the following patch in various<br>
&gt; &gt; openembedded gcc versions:<br>
&gt; &gt;<br>
&gt; &gt; 0024-PR-target-32219.patch<br>
&gt; &gt;<br>
&gt; &gt; &quot;From e0d15f4f8bf28c351b9215ca37f1caa24df0e1fd Mon Sep 17 00:00:00 2001<br>
&gt; &gt; From: Khem Raj &lt;<a href="mailto:raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; &gt; Date: Fri, 29 Mar 2013 09:18:54 +0400<br>
&gt; &gt; Subject: [PATCH 24/35] PR target/32219<br>
&gt; &gt;<br>
&gt; &gt; * varasm.c (default_binds_local_p_1): Weak data is not local.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Bernhard Reutner-Fischer &lt;<a href="mailto:rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; &gt; Signed-off-by: Khem Raj &lt;<a href="mailto:raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Upstream-Status: Backport&quot;<br>
&gt; &gt;<br>
&gt; &gt; However, contrarily to its &quot;Backport&quot; status, that patch is<br>
&gt; &gt; not upstream in gcc, and we&#39;re starting to wonder if this<br>
&gt; &gt; would be the patch that breaks handling of start/stop automatic<br>
&gt; &gt; hidden symbols we use in lttng-ust.<br>
&gt; &gt;<br>
&gt; &gt; We are only experiencing problems on the various openembedded<br>
&gt; &gt; compilers, but on no other distro (with same compiler versions),<br>
&gt; &gt; which leads us to suspect a buggy distro-specific gcc patch.<br>
&gt; &gt;<br>
&gt; &gt; We&#39;ve been testing with openembedded gcc-4.9.2-r0.<br>
&gt; &gt;<br>
&gt; &gt; The original gold linker issue that this patch was trying to<br>
&gt; &gt; address seems to have been fixed in the gold linke since<br>
&gt; &gt; then.<br>
&gt; &gt;<br>
&gt; &gt; Refs:<br>
&gt; &gt; <a href="http://lists.lttng.org/pipermail/lttng-dev/2014-May/023112.html">http://lists.lttng.org/pipermail/lttng-dev/2014-May/023112.html</a><br>
&gt; &gt; <a href="https://gcc.gnu.org/ml/gcc-help/2014-05/msg00042.html">https://gcc.gnu.org/ml/gcc-help/2014-05/msg00042.html</a><br>
&gt; &gt; <a href="http://cgit.openembedded.org/openembedded-core/commit/?id=3cb2b003db7371b3a47d02c08352a262e1e419b4">http://cgit.openembedded.org/openembedded-core/commit/?id=3cb2b003db7371b3a47d02c08352a262e1e419b4</a><br>
&gt; &gt; <a href="https://sourceware.org/bugzilla/show_bug.cgi?id=15435">https://sourceware.org/bugzilla/show_bug.cgi?id=15435</a><br>
&gt; &gt;<br>
&gt; &gt; Thoughts ?<br>
&gt;<br>
&gt; OE has defaulted to gcc5 since last release, and gold issue is fixed in binutils 2.25<br>
&gt; which is what we use in 2.0 as well so it might be OK to unbolt this fix. Although I am not sure<br>
&gt; about the original problem reported in PR32219 is fixed for gcc 4.9 if we remove this fix.<br>
&gt; Have you narrowed down your issue to this patch ? if not, then it would be good to do so</p>
<p dir="ltr">See <a href="http://gcc.gnu.org/PR32219">http://gcc.gnu.org/PR32219</a> this is fixed for at least 6.0 so should certainly be dropped for any fixed GCC. Not sure if anybody is willing to backport this one, you might ask.</p>
<p dir="ltr">Thanks,<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Mathieu<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Mathieu Desnoyers<br>
&gt; &gt; EfficiOS Inc.<br>
&gt; &gt; <a href="http://www.efficios.com">http://www.efficios.com</a><br>
&gt;<br>
</p>

--001a113fcf0ec2714e052a412c6d--

--===============0113543954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
_______________________________________________
Openembedded-core mailing list
Openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
http://lists.openembedded.org/mailman/listinfo/openembedded-core

--===============0113543954==--
