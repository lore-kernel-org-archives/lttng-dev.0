From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [for-next][PATCH 08/20] tracing: Warn if a tracepoint is not
 set via debugfs
Date: Wed, 12 Mar 2014 21:35:15 +0100
Message-ID: <20140312203515.GV22728@two.firstfloor.org>
References: <20140307150920.881849073@goodmis.org>
 <20140312114611.43547df7@gandalf.local.home>
 <437054772.1403.1394640336308.JavaMail.zimbra@efficios.com>
 <20140312121813.1e0102aa@gandalf.local.home>
 <285520930.1511.1394642395537.JavaMail.zimbra@efficios.com>
 <20140312135059.2d497b58@gandalf.local.home>
 <1906756968.1732.1394650035535.JavaMail.zimbra@efficios.com>
 <20140312145802.4819511e@gandalf.local.home>
 <1177120325.1928.1394653861180.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1177120325.1928.1394653861180.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Frank Ch. Eigler" <fche@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Johannes Berg <johannes.berg@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lttng-dev <lttng-dev@lists.lttng.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <andi@firstfloor.org>
List-Id: lttng-dev@lists.lttng.org

> So I understand that you wish to banish tracepoints from static inline
> functions within headers to ensure they only appear within a single module.
> This seems to be a step backward, but let's assume we stick to that rule.
> Then how do you envision dealing with Link-Time Optimisations (LTO) ?

I assume it uses the file name defines set by Kbuild? These don't change with
LTO. It's whatever was specified at compile time. Also LTO doesn't
inline over module boundaries (if the module is not built in)

-Andi
