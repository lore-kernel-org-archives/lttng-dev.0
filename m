From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Instrumenting code that's common between user
	and	kernel space
Date: Sat, 12 Sep 2015 16:49:19 +0000 (UTC)
Message-ID: <117623230.5446.1442076559069.JavaMail.zimbra__39746.6235830963$1442076629$gmane$org@efficios.com>
References: <20150831191309.GA13818@bhshelto-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Zanzb-0003aU-Ti
 for lttng-dev@lists.lttng.org; Sat, 12 Sep 2015 12:49:38 -0400
In-Reply-To: <20150831191309.GA13818@bhshelto-vm>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Shelton, Ben" <benjamin.h.shelton@intel.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, timothy mcdaniel <timothy.mcdaniel@intel.com>
List-Id: lttng-dev@lists.lttng.org

----- On Aug 31, 2015, at 3:13 PM, Shelton, Ben benjamin.h.shelton@intel.com wrote:

> Hi all,
> 
> I'm working on using LTTng to instrument a driver that has both a kernel
> space portion and a user space portion.  There is quite a bit of code
> that's common between the two.  Is there a recommended way to handle
> generating both the user space template files and the kernel space
> tracepoints / probes for the same code, or is this something we would
> need to build ourselves?

Hi Ben,

I would recommend creating separate files for the tracepoint
probe providers (the TRACEPOINT_EVENT() declarations) since those
differ slightly between lttng-modules and UST. Then, you could
do a wrapper macro for the tracepoint call: UST's API is
tracepoint(provider, name, args), whereas the kernel is
trace_eventname(args). Some preprocessor macro magic should
allow you to instrument code shared between userspace and kernel.

Hoping this helps,

Thanks for reaching out to us!

Mathieu


> 
> Thanks,
> Ben
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
