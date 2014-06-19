From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: Re: [PATCH lttng-tools] Add vpid,
 vppid and vtid explanation in add-context help menu
Date: Thu, 19 Jun 2014 14:38:52 -0400
Message-ID: <CADcCL0giSreZ=bmPC+Q9jcNrsqkPSnoR92RTQ2X-iVP7Kf=zmA__41283.0447465696$1403203217$gmane$org@mail.gmail.com>
References: <1403144380-26702-1-git-send-email-francis.deslauriers@efficios.com>
 <20140619182119.GA27213@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <fdeslaur@gmail.com>) id 1WxhF0-0001Q5-Hn
 for lttng-dev@lists.lttng.org; Thu, 19 Jun 2014 14:39:24 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so2624057qcy.1
 for <lttng-dev@lists.lttng.org>; Thu, 19 Jun 2014 11:39:13 -0700 (PDT)
In-Reply-To: <20140619182119.GA27213@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Thu, Jun 19, 2014 at 2:21 PM, David Goulet <dgoulet@efficios.com> wrote:
> On 18 Jun (22:19:40), francis.deslauriers@efficios.com wrote:
>> From: Francis Deslauriers <francis.deslauriers@efficios.com>
>>
>> Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
>> ---
>>  src/bin/lttng/commands/add_context.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
>> index 405b782..52d0db4 100644
>> --- a/src/bin/lttng/commands/add_context.c
>> +++ b/src/bin/lttng/commands/add_context.c
>> @@ -514,6 +514,9 @@ static void usage(FILE *ofp)
>>       fprintf(ofp, "                           TYPE can be one of the strings below:\n");
>>       print_ctx_type(ofp);
>>       fprintf(ofp, "\n");
>> +     fprintf(ofp, "Note that the vpid, vppid and vtid context types represent the virtual process id,\n"
>> +                     "virtual parent process id and virtual thread id as seen from the current execution context\n"
>> +                     "as oppose to the pid, ppid and tid that are kernel internal data structures.\n\n");
>
> That would be kind of neat if you could also add this to the man page.
> Usually, I try to keep both the --help and man page in sync :).

I didn't add it to the man page because there is no mention of the
available context types in the man page.
The user is asked to run the lttng add-context -h command to get more
information on the available types.
Should I add a note to the man page anyway?

Thanks,
Francis

>
> Cheers!
> David
>
>>       fprintf(ofp, "Example:\n");
>>       fprintf(ofp, "This command will add the context information 'prio' and two per-cpu\n"
>>                       "perf counters (hardware branch misses and cache misses), to all channels\n"
>> --
>> 1.8.3.2
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
