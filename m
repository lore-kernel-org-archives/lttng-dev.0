From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Support for new arch 'ppc64le'
Date: Mon, 28 Sep 2015 15:16:23 +0000 (UTC)
Message-ID: <1063331496.6043.1443453383156.JavaMail.zimbra__4647.46429720453$1443453495$gmane$org@efficios.com>
References: <CANBHLUhP-FUrKP8nfiZe19JdihSyxuF9wEhzb53aCZYYg9hTvQ@mail.gmail.com>
 <460007316.819.1394627351601.JavaMail.zimbra@efficios.com>
 <1582139201.5759.1443396039932.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZgaAZ-0002eu-Af
 for lttng-dev@lists.lttng.org; Mon, 28 Sep 2015 11:16:54 -0400
In-Reply-To: <1582139201.5759.1443396039932.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dimitri John Ledkov <xnox@ubuntu.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

----- On Sep 27, 2015, at 7:20 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Mar 12, 2014, at 8:29 AM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> ----- Original Message -----
>>> From: "Dimitri John Ledkov" <xnox@ubuntu.com>
>>> To: lttng-dev@lists.lttng.org
>>> Cc: ravi@linux.vnet.ibm.com, "mathieu desnoyers"
>>> <mathieu.desnoyers@efficios.com>
>>> Sent: Wednesday, March 12, 2014 7:26:12 AM
>>> Subject: RE: [lttng-dev] Support for new arch 'ppc64le'
>>> 
>>> (sorry for breaking threading, I was not previously subscribed)
>>> 
>>> On 03/12/2014 12:58 AM, Mathieu Desnoyers wrote:
>>> > I see that the patch you propose adds both "powerpc64le" and "aarch64"
>>> > entries. Why are there two of them?
>>> 
>>> Currently there are two fairly recent architectures, which at the
>>> moment can only be compiled with "gcc atomics" code path.
>>> The two new architectures are (GNU Types):
>>> * aarch64-linux-gnu (aka ARMv8, ARM64, AARCH64, etc)
>>> * powerpc64le-linux-gnu
>>> 
>>> Upstream config.guess/config.sub/libtool/kernel/compilers have support
>>> for these targets and many distributions are bootstrapping/building
>>> archives for these architectures. Although for complete support,
>>> ideally one would create tarballs on systems with patched libtool,
>>> it's not required for distributions since we have support to update
>>> config.guess/config.sub/libtool at package build time.
>>> 
>>> Thus I'd like to only request for aarch64/powerpc64el to be recognized
>>> as archtypes that use gcc atomics in configure.ac. See attached patch.
>> 
>> OK. My request to you is that there has been some testing (make check,
>> make regtest and ensuring there is no crash, assertions, or other issues
>> reported) on each of those architectures with userspace RCU.
>> 
>>> 
>>> Alternatively, you might want to consider making "gcc" atomics the
>>> fallback ARCHTYPE, instead of "unknown" such that compilation of this
>>> package is at least attempted on unexpected architectures.
>> 
>> The reason why we don't have this fallback is because we want to make sure
>> the implementation of gcc atomics are tested for each architecture before
>> we allow building userspace RCU for them. You may call us paranoid over
>> this, but we just don't trust the compiler to always do the right thing.
>> 
>> I'll merge your patch into master. However, since this can be considered
>> as new features (and not bugfixes), I cannot backport it to the stable
>> branches of userspace RCU. So it will be in there for the future 0.9
>> branch.
> 
> Hi,
> 
> I'm currently trying out userspace RCU on a POWER8, and I was wondering
> why we use the "gcc" arch fallback for powerpc64le ?

I'll move powerpc64le to "ppc" to wire up the membarrier system
call in the master branch of urcu. Let me know if this can be an
issue.

Thanks!

Mathieu

> 
> Commit 3913336f0e states
> 
> "  Currently there are two fairly recent architectures, which at the
>   moment can only be compiled with "gcc atomics" code path.
>   The two new architectures are (GNU Types):
>   * aarch64-linux-gnu (aka ARMv8, ARM64, AARCH64, etc)
>   * powerpc64le-linux-gnu"
> 
> I tried changing "gcc" for "ppc" in configure.ac for powerpc64le,
> and so far it seems to build and run fine. But considering the
> commit message above, there seems to be some unidentified reason
> for using the "gcc" fallback rather than the powerpc-specific
> implementation of memory barriers and atomic ops in urcu.
> 
> Do you have further information on this ?
> 
> Thanks,
> 
> Mathieu
> 
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>>> 
>>> --
>>> Regards,
>>> 
>>> Dimitri.
>>> 
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>> 
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
