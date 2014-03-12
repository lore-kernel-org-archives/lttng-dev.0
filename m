From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Support for new arch 'ppc64le'
Date: Wed, 12 Mar 2014 12:29:11 +0000 (UTC)
Message-ID: <460007316.819.1394627351601.JavaMail.zimbra__14292.0282356956$1394627424$gmane$org@efficios.com>
References: <CANBHLUhP-FUrKP8nfiZe19JdihSyxuF9wEhzb53aCZYYg9hTvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WNiHZ-0007He-3w
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 08:29:19 -0400
In-Reply-To: <CANBHLUhP-FUrKP8nfiZe19JdihSyxuF9wEhzb53aCZYYg9hTvQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dimitri John Ledkov <xnox@ubuntu.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Dimitri John Ledkov" <xnox@ubuntu.com>
> To: lttng-dev@lists.lttng.org
> Cc: ravi@linux.vnet.ibm.com, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Wednesday, March 12, 2014 7:26:12 AM
> Subject: RE: [lttng-dev] Support for new arch 'ppc64le'
> 
> (sorry for breaking threading, I was not previously subscribed)
> 
> On 03/12/2014 12:58 AM, Mathieu Desnoyers wrote:
> > I see that the patch you propose adds both "powerpc64le" and "aarch64"
> > entries. Why are there two of them?
> 
> Currently there are two fairly recent architectures, which at the
> moment can only be compiled with "gcc atomics" code path.
> The two new architectures are (GNU Types):
> * aarch64-linux-gnu (aka ARMv8, ARM64, AARCH64, etc)
> * powerpc64le-linux-gnu
> 
> Upstream config.guess/config.sub/libtool/kernel/compilers have support
> for these targets and many distributions are bootstrapping/building
> archives for these architectures. Although for complete support,
> ideally one would create tarballs on systems with patched libtool,
> it's not required for distributions since we have support to update
> config.guess/config.sub/libtool at package build time.
> 
> Thus I'd like to only request for aarch64/powerpc64el to be recognized
> as archtypes that use gcc atomics in configure.ac. See attached patch.

OK. My request to you is that there has been some testing (make check,
make regtest and ensuring there is no crash, assertions, or other issues
reported) on each of those architectures with userspace RCU.

> 
> Alternatively, you might want to consider making "gcc" atomics the
> fallback ARCHTYPE, instead of "unknown" such that compilation of this
> package is at least attempted on unexpected architectures.

The reason why we don't have this fallback is because we want to make sure
the implementation of gcc atomics are tested for each architecture before
we allow building userspace RCU for them. You may call us paranoid over
this, but we just don't trust the compiler to always do the right thing.

I'll merge your patch into master. However, since this can be considered
as new features (and not bugfixes), I cannot backport it to the stable
branches of userspace RCU. So it will be in there for the future 0.9
branch.

Thanks,

Mathieu

> 
> --
> Regards,
> 
> Dimitri.
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
