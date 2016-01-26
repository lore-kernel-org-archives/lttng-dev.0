From: Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Subject: Re: Bogus openembedded gcc patch
Date: Tue, 26 Jan 2016 01:17:13 +0000 (UTC)
Message-ID: <2142647634.4366.1453771033156.JavaMail.zimbra@efficios.com>
References: <1037243108.4336.1453770172960.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <1037243108.4336.1453770172960.JavaMail.zimbra-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: Bernhard Reutner-Fischer <rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lttng-dev <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, openembedded-core <openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

Re-sending with oe-core ML in CC.

----- On Jan 25, 2016, at 8:02 PM, Mathieu Desnoyers mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org wrote:

> Hi,
> 
> We are noticing the presence of the following patch in various
> openembedded gcc versions:
> 
> 0024-PR-target-32219.patch
> 
> "From e0d15f4f8bf28c351b9215ca37f1caa24df0e1fd Mon Sep 17 00:00:00 2001
> From: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date: Fri, 29 Mar 2013 09:18:54 +0400
> Subject: [PATCH 24/35] PR target/32219
> 
> * varasm.c (default_binds_local_p_1): Weak data is not local.
> 
> Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Upstream-Status: Backport"
> 
> However, contrarily to its "Backport" status, that patch is
> not upstream in gcc, and we're starting to wonder if this
> would be the patch that breaks handling of start/stop automatic
> hidden symbols we use in lttng-ust.
> 
> We are only experiencing problems on the various openembedded
> compilers, but on no other distro (with same compiler versions),
> which leads us to suspect a buggy distro-specific gcc patch.
> 
> We've been testing with openembedded gcc-4.9.2-r0.
> 
> The original gold linker issue that this patch was trying to
> address seems to have been fixed in the gold linke since
> then.
> 
> Refs:
> http://lists.lttng.org/pipermail/lttng-dev/2014-May/023112.html
> https://gcc.gnu.org/ml/gcc-help/2014-05/msg00042.html
> http://cgit.openembedded.org/openembedded-core/commit/?id=3cb2b003db7371b3a47d02c08352a262e1e419b4
> https://sourceware.org/bugzilla/show_bug.cgi?id=15435
> 
> Thoughts ?
> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
-- 
