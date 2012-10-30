From: David Goulet <dgoulet@efficios.com>
Subject: Re: 'add-context --userspace' must be preceded by
 'enable-channel' or 'enable-event'
Date: Tue, 30 Oct 2012 16:34:53 -0400
Message-ID: <509039ED.6020203__15042.3062885695$1351629333$gmane$org@efficios.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F843FE@ZURMSG1.QUANTUM.com>
	<20121030014845.GB26711@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TTIWX-0001Ql-1I
	for lttng-dev@lists.lttng.org; Tue, 30 Oct 2012 16:34:57 -0400
In-Reply-To: <20121030014845.GB26711@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Comments below.

Mathieu Desnoyers:
> * David OShea (David.OShea@quantum.com) wrote:
>> Hi all,
>>
>> As I mentioned briefly in my thread "Wrong procname for userspace
>> trace of app with different thread names", I found that I had to do an
>> 'enable-channel' step to get UST context such as the thread name to
>> actually appear in the trace.
>>
>> From further investigation, it appears that if I perform
>> 'enable-event' before 'add-context', that also makes the context
>> appear.  Here are three sequences of commands where I'm enabling the
>> same UST context (vpid, vtid and procname) and same UST events (all)
>> each time, but only the first sequence includes 'enable-channel', and
>> I switched around the order of 'add-context' and 'enable-event' in the
>> second and third.  Note that in the second command sequence, the
>> second set of curly braces - those containing the context - is missing
>> from the 'lttng view' output.
> 
> If I understand correctly, the two use-cases where you issue
> "add-context" prior to enable-event and prior to enable-channel are
> behaving as if they are failing (those contexts don't appear in the
> trace), but you don't get any error message. David (David Goulet, in
> CC), any clue on why lttng-tools behaves that way, and how can we fix
> this ?
> 
> Thanks,
> 
> Mathieu
> 
>>
>> Good: 'enable-channel' before 'add-context':
>>
>> """
>> # lttng create
>> Session auto-20121029-085910 created.
>> Traces will be written in /root/lttng-traces/auto-20121029-085910
>> # lttng enable-channel channel0 --userspace
>> UST channel channel0 enabled for session auto-20121029-085910
>> # lttng add-context --userspace -t vpid -t vtid -t procname
>> UST context procname added to all channels
>> UST context vtid added to all channels
>> UST context vpid added to all channels
>> # lttng enable-event --userspace --all
>> All UST events are enabled in channel channel0
>> # lttng start
>> Tracing started for session auto-20121029-085910
>> # lttng stop
>> Tracing stopped for session auto-20121029-085910
>> # lttng view
>> Trace directory: /root/lttng-traces/auto-20121029-085910
>>
>> [09:00:34.022479500] (+?.?????????) mydaemon:13811 daemon:start: { cpu_id = 1 }, { procname = "mythread.9", vtid = 13993, vpid = 13811 }, { myvar = 999 }
>> [...]
>> # lttng destroy
>> Session auto-20121029-085910 destroyed at /root
>> """
>>
>> Bad: 'add-context' before 'enable-event':
>>
>> """
>> # lttng create
>> Session auto-20121029-090142 created.
>> Traces will be written in /root/lttng-traces/auto-20121029-090142
>> # lttng add-context --userspace -t vpid -t vtid -t procname
>> UST context procname added to all channels
>> UST context vtid added to all channels
>> UST context vpid added to all channels
>> # lttng enable-event --userspace --all

The context is added to "channel0" here which is the default one created
automatically.

The lttng-tools session daemon do add the contexts to the channel on the
tracer side (ustctl_add_context) so Mathieu we might want to check if
the UST tracer do behave correctly by adding the context to all events
of a channel. (Note here that -a -u was used hence the "*" event).

I also do confirm that lttng-tools is doing the right ustctl call on
channel0 here.

Thanks
David

>> All UST events are enabled in channel channel0
>> # lttng start
>> Tracing started for session auto-20121029-090142
>> # lttng stop
>> Tracing stopped for session auto-20121029-090142
>> # lttng view
>> Trace directory: /root/lttng-traces/auto-20121029-090142
>>
>> [09:02:11.520300500] (+?.?????????) mydaemon:13811 daemon:start: { cpu_id = 0 }, { myvar = 999 }
>> [...]
>> # lttng destroy
>> Session auto-20121029-090142 destroyed at /root
>> """
>>
>> Good: 'add-context' AFTER 'enable-event':
>>
>> """
>> # lttng create
>> Session auto-20121029-090738 created.
>> Traces will be written in /root/lttng-traces/auto-20121029-090738
>> # lttng enable-event --userspace --all
>> All UST events are enabled in channel channel0
>> # lttng add-context --userspace -t vpid -t vtid -t procname
>> UST context procname added to all channels
>> UST context vtid added to all channels
>> UST context vpid added to all channels
>> # lttng start
>> Tracing started for session auto-20121029-090738
>> # lttng stop
>> Tracing stopped for session auto-20121029-090738
>> # lttng view
>> Trace directory: /root/lttng-traces/auto-20121029-090738
>>
>> [09:08:04.670574000] (+?.?????????) mydaemon:13811 daemon:start: { cpu_id = 1 }, { procname = "mythread.9", vtid = 13993, vpid = 13811 }, { myvar = 999 }
>> [...]
>> # lttng destroy
>> Session auto-20121029-090738 destroyed at /root
>> """
>>
>> I am using lttng-ust-2.0.5 which I have patched with commit 009745db "Cache the procname per-thread rather than per-process to take into account that prctl() can be used to set thread names.", lttng-tools-2.0.4 and babeltrace-1.0.0.rc5.
>>
>> Thanks in advance,
>> David
>>
>> ----------------------------------------------------------------------
>> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
