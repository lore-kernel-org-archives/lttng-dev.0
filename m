From: Duncan Sands <duncan.sands@deepbluecap.com>
Subject: Re: [lttng-dev] Alternative to signals/sys_membarrier() in liburcu
Date: Mon, 23 Mar 2015 10:35:10 +0100
Message-ID: <550FDE4E.30201@free.fr>
References: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg@mail.gmail.com> <867044376.285926.1426172227750.JavaMail.zimbra@efficios.com> <CANW5cDkiZoysNM3rqb4v6Tj996ocsaSh=OZoBLfp4h7ZGb4bxg@mail.gmail.com> <666590480.287502.1426193588471.JavaMail.zimbra@efficios.com> <CA+55aFzq75Da-VLMeLWVUbvz_KoLLnftTyVynL1s2rgBK75-Og@mail.gmail.com> <1601505044.287659.1426199435904.JavaMail.zimbra@efficios.com> <20150313080743.GA21156@gmail.com> <20150313141853.GE5412@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150313141853.GE5412@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>
Cc: Michael Sullivan <sully@msully.net>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, lttng-dev@lists.lttng.org, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: lttng-dev@lists.lttng.org

> So, given the fact that the userspace RCU library does now see
> some real-world use, is it now time for Mathieu to resubmit his
> sys_membarrier() patch?

I'm using userspace RCU with success in financial software, so the LTTng project 
isn't the only user.  It works well, but it's not as fast as I'd like.  My 
profiling shows that the performance hit is coming from the memory barriers.  So 
I would very much like to see sys_membarrier go in.

Best wishes, Duncan.
