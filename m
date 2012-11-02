From: David OShea <David.OShea@quantum.com>
Subject: Re: 'add-context --userspace' must be preceded by
 'enable-channel' or 'enable-event'
Date: Fri, 2 Nov 2012 03:54:22 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F8515D__24367.9164480001$1351828515$gmane$org@ZURMSG1.QUANTUM.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F843FE@ZURMSG1.QUANTUM.com>
	<20121030014845.GB26711@Krystal> <509039ED.6020203@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=7653a799a1=david.oshea@quantum.com>)
	id 1TU8Kz-0001Dg-4S
	for lttng-dev@lists.lttng.org; Thu, 01 Nov 2012 23:54:29 -0400
In-Reply-To: <509039ED.6020203@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi David, Mathieu,

> -----Original Message-----
> From: David Goulet [mailto:dgoulet@efficios.com]
> Sent: Wednesday, 31 October 2012 7:05 AM
> To: Mathieu Desnoyers
> Cc: David OShea; lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] 'add-context --userspace' must be preceded by
> 'enable-channel' or 'enable-event'
[...]
> Mathieu Desnoyers:
> > If I understand correctly, the two use-cases where you issue
> > "add-context" prior to enable-event and prior to enable-channel are
> > behaving as if they are failing (those contexts don't appear in the
> > trace), but you don't get any error message. David (David Goulet, in
> > CC), any clue on why lttng-tools behaves that way, and how can we fix
> > this ?

This is not quite correct: I don't have a use case where I 'add-context' prior to 'enable-channel'.  The only case that fails is when I do an 'add-context' immediately after 'create'.  Things work properly if I do an 'enable-channel' or 'enable-event' before the 'add-context'.

> >> Bad: 'add-context' before 'enable-event':
> >>
> >> """
> >> # lttng create
> >> Session auto-20121029-090142 created.
> >> Traces will be written in /root/lttng-traces/auto-20121029-090142
> >> # lttng add-context --userspace -t vpid -t vtid -t procname
> >> UST context procname added to all channels
> >> UST context vtid added to all channels
> >> UST context vpid added to all channels
> >> # lttng enable-event --userspace --all
> 
> The context is added to "channel0" here which is the default one
> created
> automatically.
> 
> The lttng-tools session daemon do add the contexts to the channel on
> the
> tracer side (ustctl_add_context) so Mathieu we might want to check if
> the UST tracer do behave correctly by adding the context to all events
> of a channel. (Note here that -a -u was used hence the "*" event).
> 
> I also do confirm that lttng-tools is doing the right ustctl call on
> channel0 here.

I took a quick look at the source for lttng-tools 2.0.4 and 2.1.0-rc4, and it looks to me like in the case above, the default channel "channel0" is not actually created by 'add-context'.

In lttng_enable_event(), if no channel name was specified, it uses DEFAULT_CHANNEL_NAME, then in cmd_enable_event_all() (I'm considering the case of enabling all events, which is what I do), in case LTTNG_DOMAIN_UST, if the specified channel doesn't exist, it will create it.  This seems to be why doing the 'enable-event' first works.

On the other hand, in lttng_add_context(), if no channel name is specified, no channel name is passed to the server, then in cmd_add_context(), context_ust_add() is called, and in that function, if no channel name is specified, it adds the context to every channel.  However, my understanding is that at this point there are no channels created.

Apologies if I have missed anything here!

Regards,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
