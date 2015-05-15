From: Alexandre Montplaisir <alexmonthy@efficios.com>
Subject: Re: state tracking and missing statedump end
Date: Fri, 15 May 2015 15:54:07 -0400
Message-ID: <55564EDF.2070201__29514.5144490109$1431719743$gmane$org@efficios.com>
References: <1361850761.1447.1431642954186.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@efficios.com>) id 1YtLga-0007mR-16
 for lttng-dev@lists.lttng.org; Fri, 15 May 2015 15:54:30 -0400
In-Reply-To: <1361850761.1447.1431642954186.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

Thanks for the info, good to know!

However, we (in Trace Compass) don't actually make use of the 
"statedump_end" event. Should we?

For now, we only use the "lttng_statedump_process_state" events in our 
state model. The information contained in these events is applied to the 
state of the involved process. This state becomes valid starting at the 
timestamp of each statedump event.

What type of information does the "lttng_statedump_end" event implies?

Cheers,
Alex


On 2015-05-14 06:35 PM, Mathieu Desnoyers wrote:
> Hi Alexandre, Hi Matthew,
>
> You will certainly be interested in this commit in
> lttng-modules:
>
> commit 84c7055e17f9bf7628fe1004db732d932ed2a77b
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Thu May 14 18:29:58 2015 -0400
>
>      Fix: missing statedump end event when block device listing available
>      
>      Incorrect handling of lttng_enumerate_block_devices() return value of 0
>      (which means "ok"), causing do_lttng_statedump() to return early.
>      
>      To causes missing "lttng_statedump_end" in traces where block device
>      enumeration is available (CONFIG_KALLSYMS=y).
>      
>      Reported-by: Antoine Busque <abusque@efficios.com>
>      Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> Thanks,
>
> Mathieu
>
