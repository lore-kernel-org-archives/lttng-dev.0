From: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bogus openembedded gcc patch
Date: Tue, 26 Jan 2016 18:14:37 -0500
Message-ID: <CAMKF1sofnyADcNkAc+YrXjPED=ALxf60oPEsuQiJTAY87oB31Q@mail.gmail.com>
References: <1037243108.4336.1453770172960.JavaMail.zimbra@efficios.com>
	<51287CFC-6F3C-43B1-9190-84F3B20C192E@gmail.com>
	<433937130.5072.1453838389504.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0261297085=="
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <433937130.5072.1453838389504.JavaMail.zimbra-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Cc: lttng-dev <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Patches and discussions about the oe-core layer <openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

--===============0261297085==
Content-Type: multipart/alternative; boundary=001a11c16e6a77c811052a44d95d

--001a11c16e6a77c811052a44d95d
Content-Type: text/plain; charset=UTF-8

On Jan 26, 2016 2:59 PM, "Mathieu Desnoyers" <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
wrote:
>
> ----- On Jan 26, 2016, at 11:28 AM, Khem Raj raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>
> >> On Jan 25, 2016, at 8:02 PM, Mathieu Desnoyers <
mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
> >> wrote:
> >>
> >> Hi,
> >>
> >> We are noticing the presence of the following patch in various
> >> openembedded gcc versions:
> >>
> >> 0024-PR-target-32219.patch
> >>
> >> "From e0d15f4f8bf28c351b9215ca37f1caa24df0e1fd Mon Sep 17 00:00:00 2001
> >> From: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Date: Fri, 29 Mar 2013 09:18:54 +0400
> >> Subject: [PATCH 24/35] PR target/32219
> >>
> >> * varasm.c (default_binds_local_p_1): Weak data is not local.
> >>
> >> Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Signed-off-by: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>
> >> Upstream-Status: Backport"
> >>
> >> However, contrarily to its "Backport" status, that patch is
> >> not upstream in gcc, and we're starting to wonder if this
> >> would be the patch that breaks handling of start/stop automatic
> >> hidden symbols we use in lttng-ust.
> >>
> >> We are only experiencing problems on the various openembedded
> >> compilers, but on no other distro (with same compiler versions),
> >> which leads us to suspect a buggy distro-specific gcc patch.
> >>
> >> We've been testing with openembedded gcc-4.9.2-r0.
> >>
> >> The original gold linker issue that this patch was trying to
> >> address seems to have been fixed in the gold linke since
> >> then.
> >>
> >> Refs:
> >> http://lists.lttng.org/pipermail/lttng-dev/2014-May/023112.html
> >> https://gcc.gnu.org/ml/gcc-help/2014-05/msg00042.html
> >>
http://cgit.openembedded.org/openembedded-core/commit/?id=3cb2b003db7371b3a47d02c08352a262e1e419b4
> >> https://sourceware.org/bugzilla/show_bug.cgi?id=15435
> >>
> >> Thoughts ?
> >
> > OE has defaulted to gcc5 since last release, and gold issue is fixed in
binutils
> > 2.25
> > which is what we use in 2.0 as well so it might be OK to unbolt this
fix.
> > Although I am not sure
> > about the original problem reported in PR32219 is fixed for gcc 4.9 if
we remove
> > this fix.
> > Have you narrowed down your issue to this patch ? if not, then it would
be good
> > to do so
>
> Yes, we have narrowed down our problem to this specific patch by
> removing the patch from the OE gcc patches, rebuilding gcc, and
> then building our test program with that gcc. The problem goes
> away when we do so, which points directly to that patch as a
> culprit.
>
> Test program is attached.

Ok I think we can remove this from master and jethro release
>
> Faulty[gcc 4.9-r0 with patch 0024]:
>
> main: myvar addr=0x600c90 __start___test=0x600c90
> fct: myvar addr=0x7f8733d1eae8 __start___test=0x600c90
> fct2: myvar addr=0x7f8733d1eaec __start___test=0x600c90
> fct3: myvar addr=0x600c94 __start___test=0x600c90
>
> Valid[gcc 4.9-r0 without patch 0024]:
>
> main: myvar addr=0x600c60 __start___test=0x600c60
> fct: myvar addr=0x7fb62c758a90 __start___test=0x7fb62c758a90
> fct2: myvar addr=0x7fb62c758a94 __start___test=0x7fb62c758a90
> fct3: myvar addr=0x600c64 __start___test=0x600c60
>
> Thanks,
>
> Mathieu
>
> >
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> > > http://www.efficios.com
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--001a11c16e6a77c811052a44d95d
Content-Type: text/html; charset=UTF-8

<p dir="ltr"><br>
On Jan 26, 2016 2:59 PM, &quot;Mathieu Desnoyers&quot; &lt;<a href="mailto:mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org">mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; ----- On Jan 26, 2016, at 11:28 AM, Khem Raj <a href="mailto:raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> wrote:<br>
&gt;<br>
&gt; &gt;&gt; On Jan 25, 2016, at 8:02 PM, Mathieu Desnoyers &lt;<a href="mailto:mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org">mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org</a>&gt;<br>
&gt; &gt;&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hi,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; We are noticing the presence of the following patch in various<br>
&gt; &gt;&gt; openembedded gcc versions:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 0024-PR-target-32219.patch<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &quot;From e0d15f4f8bf28c351b9215ca37f1caa24df0e1fd Mon Sep 17 00:00:00 2001<br>
&gt; &gt;&gt; From: Khem Raj &lt;<a href="mailto:raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; &gt;&gt; Date: Fri, 29 Mar 2013 09:18:54 +0400<br>
&gt; &gt;&gt; Subject: [PATCH 24/35] PR target/32219<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; * varasm.c (default_binds_local_p_1): Weak data is not local.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Bernhard Reutner-Fischer &lt;<a href="mailto:rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; &gt;&gt; Signed-off-by: Khem Raj &lt;<a href="mailto:raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Upstream-Status: Backport&quot;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; However, contrarily to its &quot;Backport&quot; status, that patch is<br>
&gt; &gt;&gt; not upstream in gcc, and we&#39;re starting to wonder if this<br>
&gt; &gt;&gt; would be the patch that breaks handling of start/stop automatic<br>
&gt; &gt;&gt; hidden symbols we use in lttng-ust.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; We are only experiencing problems on the various openembedded<br>
&gt; &gt;&gt; compilers, but on no other distro (with same compiler versions),<br>
&gt; &gt;&gt; which leads us to suspect a buggy distro-specific gcc patch.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; We&#39;ve been testing with openembedded gcc-4.9.2-r0.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The original gold linker issue that this patch was trying to<br>
&gt; &gt;&gt; address seems to have been fixed in the gold linke since<br>
&gt; &gt;&gt; then.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Refs:<br>
&gt; &gt;&gt; <a href="http://lists.lttng.org/pipermail/lttng-dev/2014-May/023112.html">http://lists.lttng.org/pipermail/lttng-dev/2014-May/023112.html</a><br>
&gt; &gt;&gt; <a href="https://gcc.gnu.org/ml/gcc-help/2014-05/msg00042.html">https://gcc.gnu.org/ml/gcc-help/2014-05/msg00042.html</a><br>
&gt; &gt;&gt; <a href="http://cgit.openembedded.org/openembedded-core/commit/?id=3cb2b003db7371b3a47d02c08352a262e1e419b4">http://cgit.openembedded.org/openembedded-core/commit/?id=3cb2b003db7371b3a47d02c08352a262e1e419b4</a><br>
&gt; &gt;&gt; <a href="https://sourceware.org/bugzilla/show_bug.cgi?id=15435">https://sourceware.org/bugzilla/show_bug.cgi?id=15435</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thoughts ?<br>
&gt; &gt;<br>
&gt; &gt; OE has defaulted to gcc5 since last release, and gold issue is fixed in binutils<br>
&gt; &gt; 2.25<br>
&gt; &gt; which is what we use in 2.0 as well so it might be OK to unbolt this fix.<br>
&gt; &gt; Although I am not sure<br>
&gt; &gt; about the original problem reported in PR32219 is fixed for gcc 4.9 if we remove<br>
&gt; &gt; this fix.<br>
&gt; &gt; Have you narrowed down your issue to this patch ? if not, then it would be good<br>
&gt; &gt; to do so<br>
&gt;<br>
&gt; Yes, we have narrowed down our problem to this specific patch by<br>
&gt; removing the patch from the OE gcc patches, rebuilding gcc, and<br>
&gt; then building our test program with that gcc. The problem goes<br>
&gt; away when we do so, which points directly to that patch as a<br>
&gt; culprit.<br>
&gt;<br>
&gt; Test program is attached.</p>
<p dir="ltr">Ok I think we can remove this from master and jethro release<br>
&gt;<br>
&gt; Faulty[gcc 4.9-r0 with patch 0024]:<br>
&gt;<br>
&gt; main: myvar addr=0x600c90 __start___test=0x600c90<br>
&gt; fct: myvar addr=0x7f8733d1eae8 __start___test=0x600c90<br>
&gt; fct2: myvar addr=0x7f8733d1eaec __start___test=0x600c90<br>
&gt; fct3: myvar addr=0x600c94 __start___test=0x600c90<br>
&gt;<br>
&gt; Valid[gcc 4.9-r0 without patch 0024]:<br>
&gt;<br>
&gt; main: myvar addr=0x600c60 __start___test=0x600c60<br>
&gt; fct: myvar addr=0x7fb62c758a90 __start___test=0x7fb62c758a90<br>
&gt; fct2: myvar addr=0x7fb62c758a94 __start___test=0x7fb62c758a90<br>
&gt; fct3: myvar addr=0x600c64 __start___test=0x600c60<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Mathieu<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Mathieu<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; Mathieu Desnoyers<br>
&gt; &gt;&gt; EfficiOS Inc.<br>
&gt; &gt; &gt; <a href="http://www.efficios.com">http://www.efficios.com</a><br>
&gt;<br>
&gt; --<br>
&gt; Mathieu Desnoyers<br>
&gt; EfficiOS Inc.<br>
&gt; <a href="http://www.efficios.com">http://www.efficios.com</a><br>
</p>

--001a11c16e6a77c811052a44d95d--

--===============0261297085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
_______________________________________________
Openembedded-core mailing list
Openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
http://lists.openembedded.org/mailman/listinfo/openembedded-core

--===============0261297085==--
