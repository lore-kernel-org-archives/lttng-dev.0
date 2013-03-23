From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Fwd: [Bug 925071] New: babeltrace: Does not	support
	aarch64 in f19 and rawhide
Date: Sat, 23 Mar 2013 13:37:17 -0400
Message-ID: <20130323173717.GC28816__47789.4067219042$1364060289$gmane$org@Krystal>
References: <bug-925071-315593@bugzilla.redhat.com>
	<CAEzWAe+K1bbq9EFX9j5dd1atVGWGGVBKib0V1N_vnMpy3hfkEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UJSNb-00039K-3I
	for lttng-dev@lists.lttng.org; Sat, 23 Mar 2013 13:37:19 -0400
Content-Disposition: inline
In-Reply-To: <CAEzWAe+K1bbq9EFX9j5dd1atVGWGGVBKib0V1N_vnMpy3hfkEQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Brosseau, Yannick" <yannick.brosseau@gmail.com>, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Will fix within babeltrace 1.1.0.

I just updated my trees for the next lttng-ust releases too (just
removed my config/config.* and re-ran ./bootstrap).

David, you might want to do the same for lttng-tools.

Thanks,

Mathieu

* Brosseau, Yannick (yannick.brosseau@gmail.com) wrote:
> I think that's a problem that might occur for other distribution soon
> ---------- Mensaje remitido ----------
> De: <bugzilla@redhat.com>
> Fecha: mar 22, 2013 8:06 p.m.
> Asunto: [Bug 925071] New: babeltrace: Does not support aarch64 in f19 and
> rawhide
> Para: <yannick.brosseau@gmail.com>
> Cc:
> 
> Product: Fedora
> https://bugzilla.redhat.com/show_bug.cgi?id=925071
> 
>             Bug ID: 925071
>            Summary: babeltrace: Does not support aarch64 in f19 and
>                     rawhide
>            Product: Fedora
>            Version: rawhide
>          Component: babeltrace
>           Severity: unspecified
>           Priority: unspecified
>           Assignee: yannick.brosseau@gmail.com
>           Reporter: dennis@ausil.us
>         QA Contact: extras-qa@fedoraproject.org
>                 CC: yannick.brosseau@gmail.com
>             Blocks: 922257 (ARM64)
> 
> Support for the ARM 64 bit CPU architecture (aarch64) was introduced in
> autoconf 2.69.  babeltrace appears to use an earlier version of
> autoconf, preventing its being built.  This can be fixed in of three ways
> (In
> order of preference):
> 
> 1. Work with upstream to migrate the package to autoconf 2.69.
> 
> 2. Rerun autoconf or autoreconf in %prep or %build prior to running
> configure.
> 
> 3. Apply the patch at
> http://ausil.fedorapeople.org/aarch64/babeltrace/babeltrace-aarch64.patch
> which updates config.guess and config.sub to recognize aarch64.
> 
> --
> You are receiving this mail because:
> You are on the CC list for the bug.
> You are the assignee for the bug.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
