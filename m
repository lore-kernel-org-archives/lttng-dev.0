From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Problems setting up lttng on PREEMPT_RT Raspberry Pi
Date: Mon, 15 Apr 2019 10:14:35 -0400 (EDT)
Message-ID: <149638318.491.1555337675226.JavaMail.zimbra__20732.3055643187$1555337693$gmane$org@efficios.com>
References: <CAKUXLvdNYPitwKb8D5VDC7nXA4-z3OiApGX=qbVxV5LWFkDyJw@mail.gmail.com>
 <725895933.460.1555337504175.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44jVqw4qKXz1JvK
 for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2019 10:14:36 -0400 (EDT)
In-Reply-To: <725895933.460.1555337504175.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Nicholas Sadjoli <nick.sadjoli@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Tom Zanussi <tom.zanussi@linux.intel.com>, linux-rt-users <linux-rt-users@vger.kernel.org>, rostedt <rostedt@goodmis.org>, dev-raspberry-pi <dev-raspberry-pi@lists.mozilla.org>
List-Id: lttng-dev@lists.lttng.org

Re-sent as plain text.

----- On Apr 15, 2019, at 10:11 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 15, 2019, at 7:07 AM, Nicholas Sadjoli <nick.sadjoli@gmail.com>
> wrote:

>> Dear Lttng dev Team,
>> I am currently interested in using lttng to measure the interrupt or hardware
>> real-time latencies experienced within my user-space applications.
>> Unfortunately I have been having issues installing lttng on my Raspberry Pi
>> that is using the PREEMPT_RT patched kernel, version 4.14.91-rt49-v7+. The
>> problems so far can be seen documented in the RPi Linux github forum page here:
>> [ https://github.com/raspberrypi/linux/issues/2930 |
>> https://github.com/raspberrypi/linux/issues/2930 ]

>> Initially I was about to just install the Debian package of the lttng onto the
>> RPi, and just proceeded with the commands ' sudo apt-get install
>> lttng-modules-dkms liblttng-ust-dev lttng-tools' However, I was unable to use
>> lttng package at all and found out that for the RPi, a build from source is
>> necessary for lttng, as described here: [
>> https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available
>> |
>> https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available
>> ]

>> Following their suggestion, I then tried to build the lttng packages from
>> source, and even re-building the RPi kernel locally to ensure the kernel
>> headers are in the RPi and linked up properly to the source packages.

>> Unfortunately when I tried to do this for the lttng-modules package, it instead
>> gave me the following warning in my latest attempt:

>> I n file included from
>> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/lttng-kprobes.c:31:0:
>> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/../blacklist/kprobes.h:19:4:
>> error: #error "Your kernel is known to have buggy optimized kprobes
>> implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM:
>> 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in Linux. Disable
>> CONFIG_OPTPROBES or upgrade your kernel."
>> # error "Your kernel is known to have buggy optimized kprobes implementation.
>> Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM: 8834/1: Fix:
>> kprobes: optimized kprobes illegal instruction\" in Linux. Disable
>> CONFIG_OPTPROBES or upgrade your kernel."

>> I then tried to turn off the CONFIG_OPTPROBES kernel config, but it seemed to be
>> automatically overwritten during kernel building and is considered an important
>> part of the real-time RPi kernels. Has such problems been reported with this
>> version of the PREEMPT_RT kernel in the past (again, the current kernel version
>> that I am using is 4.14.91-rt49-v7+)? If there are I would like to know how
>> this issue was resolved so that I can properly build and use the lttng package
>> for my project.

> Hi Nicholas,

> It looks like our lttng-modules kernel version blacklist is acting exactly as it
> should. Looking at this
> git tree:

> git clone https://github.com/raspberrypi/linux.git -b rpi-4.14.y-rt
> I notice that in the git log, we find this bogus commit:

> commit f9e0bc710347fadad55910846ee36f0681d0dca8
> Author: Kees Cook <keescook@chromium.org>
> Date: Tue Oct 30 22:12:56 2018 +0100

> ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE

> commit e46daee53bb50bde38805f1823a182979724c229 upstream.

> But not the fix for it (upstream):

> commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date: Tue Feb 5 16:37:40 2019 +0100

> ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction

> So lttng-modules refuses to build against your kernel configuration with
> CONFIG_OPTPROBES=y
> to save you the trouble of having kprobes trigger illegal instruction OOPS at
> runtime.

> I'm unusure who maintains that raspberrypi rt kernel tree. However, the upstream
> rt tree
> for 4.14-rt maintained by Tom Zanussi seems to contain the fix:

> [
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt
> |
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt
> ]

> (currently at 4.14.109-rt57).

> So you should contact your raspberrypi linux rt tree clone maintainer and ask
> him
> to upgrade, or, as stated in the #error generated by lttng-modules, simply
> ensure
> CONFIG_OPTPROBES is unset when you build your kernel. You should ask the
> raspberrypi community advice on how to ensure this configuration option is not
> overridden by the raspberrypi build system.

> Thanks,

> Mathieu

>> Thank you so much for your attention and looking forward to your reply soon.

>> Best Regards,

>> Nicholas Sadjoli

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
