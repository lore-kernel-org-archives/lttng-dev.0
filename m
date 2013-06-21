From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: Compile failure on OSX 10.8
Date: Fri, 21 Jun 2013 11:54:16 -0400
Message-ID: <CAGDH53k9wAeu6cBsSCtauX0ADgFW9B09vz7Cfq2B=Yhw3-pCNw__45909.6843879253$1371830098$gmane$org@mail.gmail.com>
References: <51C46FFC.7050407@ripe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1Uq3fK-0005BT-Iz
	for lttng-dev@lists.lttng.org; Fri, 21 Jun 2013 11:54:22 -0400
Received: by mail-ve0-f178.google.com with SMTP id pb11so6521925veb.37
	for <lttng-dev@lists.lttng.org>; Fri, 21 Jun 2013 08:54:17 -0700 (PDT)
In-Reply-To: <51C46FFC.7050407@ripe.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Buddhdev <anandb@ripe.net>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Anand,

You might have to pass an additional host flag to configure e.g.:

./configure --host=i686-apple-darwin11

If I remember correctly, the compiler on OSX was compiled to run on a
64-bit platform but _only_ produce 32-bit binaries. Our configure
script wrongly detect an x86-64 host, so you need to force it to use
i686.

Could you post the output of your config.log?

Thanks,

Christian

On Fri, Jun 21, 2013 at 11:23 AM, Anand Buddhdev <anandb@ripe.net> wrote:
> Hi people,
>
> I'm trying to compile userspace-rcu 0.7.7 on OSX 10.8.4, and it's
> failing. The configure phase completes, but make fails like this:
>
> $ make
> make  all-recursive
> Making all in .
>   CC     wfqueue.lo
>   CC     wfstack.lo
>   CC     compat_arch_x86.lo
> /var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:44:suffix
> or operands invalid for `pushf'
> /var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:44:suffix
> or operands invalid for `pop'
> /var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:55:suffix
> or operands invalid for `push'
> /var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:55:suffix
> or operands invalid for `popf'
> /var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:60:suffix
> or operands invalid for `pushf'
> /var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:60:suffix
> or operands invalid for `pop'
> /var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:65:suffix
> or operands invalid for `push'
> /var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:65:suffix
> or operands invalid for `popf'
> make[2]: *** [compat_arch_x86.lo] Error 1
> make[1]: *** [all-recursive] Error 1
> make: *** [all] Error 2
>
> CC is just gcc, which is:
>
> $ gcc --version
> i686-apple-darwin11-llvm-gcc-4.2 (GCC) 4.2.1 (Based on Apple Inc. build
> 5658) (LLVM build 2336.11.00)
>
> Anyone know what the problem is, and how to fix it?
>
> Regards,
>
> Anand
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
