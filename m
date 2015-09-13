From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC lttng-tools] Do not list or allow unsupported
 perf events
Date: Sun, 13 Sep 2015 15:54:38 +0000 (UTC)
Message-ID: <454119546.5715.1442159678674.JavaMail.zimbra__22168.5028555386$1442159736$gmane$org@efficios.com>
References: <1441912892-30236-1-git-send-email-tonyj@suse.com>
 <55F21D05.1080002@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Zb9cC-0001zT-E8
 for lttng-dev@lists.lttng.org; Sun, 13 Sep 2015 11:54:53 -0400
In-Reply-To: <55F21D05.1080002@suse.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Tony Jones <tonyj@suse.de>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

CCing Jeremie.

----- On Sep 10, 2015, at 8:15 PM, Tony Jones tonyj@suse.de wrote:

> On 09/10/2015 12:21 PM, Tony Jones wrote:
> 
>> +static int is_event_supported(const struct ctx_opts *ctx)
>> +{
>> +	int fd;
>> +	struct perf_event_attr attr = {
>> +		.type = ctx->u.perf.type,
>> +		.config = ctx->u.perf.config,
>> +		.disabled = 1
>> +	};
>> +
>> +	if (ctx->ctx_type == CONTEXT_PERF_CPU_COUNTER ||
>> +	    ctx->ctx_type == CONTEXT_PERF_THREAD_COUNTER) {
> 
> obviously CONTEXT_PERF_THREAD_COUNTER is UST.  Regardless, there are  some
> obvious usability issues (below).  I need to look at the code some more.

OK, keep us posted. It would be nice if we can list more specifically
which counters are supported on the machine.

Thanks,

Mathieu

> 
> # lttng add-context -u -t perf:thread:alignment-faults
> UST context perf:thread:alignment-faults added to all channels
> 
> (invalid, better error needed, also sometimes -k -t perf:thread:* succeeds which
> seems broken)
> # lttng add-context -k -t perf:thread:alignment-faults
> Error: perf:thread:alignment-faults: Add kernel context failed
> Warning: Some command(s) went wrong

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
