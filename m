From: Mark Wielaard <mjw@redhat.com>
Subject: Re: Help adding trace events to xHCI
Date: Fri, 12 Jul 2013 21:35:31 +0200
Message-ID: <20130712193531.GA6954__35919.4243480035$1373657790$gmane$org@toonder.wildebeest.org>
References: <51DB0257.1010709@gmail.com>
 <20130711162002.GA5240@xanatos>
 <1373562533.8201.33.camel@jlt4.sipsolutions.net>
 <20130711190035.GD5240@xanatos>
 <87y59c4d60.fsf@kamboji.qca.qualcomm.com>
 <20130712164104.GA15531@xanatos>
 <20130712170827.GA18819@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130712170827.GA18819@Krystal>
Sender: linux-trace-users-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Kalle Valo <kvalo@qca.qualcomm.com>, Johannes Berg <johannes@sipsolutions.net>, Xenia Ragiadakou <burzalodowa@gmail.com>, OPW Kernel Interns List <opw-kernel-interns@googlegroups.com>, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-trace-users@vger.kernel.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

On Fri, Jul 12, 2013 at 01:08:28PM -0400, Mathieu Desnoyers wrote:
> * Sarah Sharp (sarah.a.sharp@linux.intel.com) wrote:
> > Thanks for the suggestion.  I'm not familiar with all the userspace
> > tools for trace events, so I didn't know about the command parser.  Is
> > there documentation or a list of resources for all the userspace trace
> > event plugins?  If so, can you give us a pointer to it?
> 
> You might want to try out LTTng-UST. It provides TRACEPOINT_EVENT() and
> tracepoint() for user-space instrumentation. See:
> 
> - https://lttng.org/files/doc/man-pages/man3/lttng-ust.3.html

Is that build on the <sys/sdt.h> ust probe points as embedded in glibc
for example that gdb and systemtap use to access user space trace
points? Can tools use lttng-ust and <sys/sdt.h> tracepoints
interchangeably by parsing the ELF notes described in
http://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation

Thanks,

Mark
