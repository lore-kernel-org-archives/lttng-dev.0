From: David Goulet <dgoulet@efficios.com>
Subject: Re: Problem setting a filter during enable-event,
 when done shortly after add-context
Date: Tue, 25 Jun 2013 10:08:28 -0400
Message-ID: <51C9A45C.8000706__46330.1780204803$1372169348$gmane$org@efficios.com>
References: <OFFF997D36.2F2A5DA8-ONC2257B95.0032AE6A-C2257B95.0039FA74@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UrTv9-0001GI-Va
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 10:08:36 -0400
In-Reply-To: <OFFF997D36.2F2A5DA8-ONC2257B95.0032AE6A-C2257B95.0039FA74@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Amit,

Can you please open an issue at bugs.lttng.org so we can have a trace of the
issue somewhere along with the fix ?

Thanks!
David

Amit Margalit:
> Hi,
> 
> I seem to have a problem setting a filter during enable-event, which happens in
> a script immediately after add-context succeeds. The error is "Error: Invalid
> filter bytecode".
> 
> The sequence I am going through is in the following script excerpt:
> 
> lttng-sessiond with --no-kernel -v --verbose-consumer        >> logfile 2>&1
> lttng create samba -o /local/traces/lttng/20130625114835     >> logfile 2>&1
> lttng enable-channel channel0 -u \
>                         --tracefile-size ${LTTNG_MAX_TRACE_FILE_SIZE} \
>                         --tracefile-count ${LTTNG_MAX_FILES_PER_CORE} \
>                         --buffers-uid \
>                         --switch-timer 1000000 \
>                         --num-subbuf 16 \
>                         --subbuf-size 262144                 >> logfile 2>&1
> lttng add-context -u -t procname -s samba -c channel0        >> logfile 2>&1
> lttng enable-event -u -a --filter '$ctx.procname == "smbd" || $ctx.procname ==
> "winbindd"'
> 
> The output is shown here (with the enable-event command-line reproduced:
> 
> Session samba created.
> Traces will be written in /local/traces/lttng/20130625114835
> UST channel channel0 enabled for session samba
> UST context procname added to channel channel0
> /usr/bin/lttng enable-event -u -a --filter '$ctx.procname=="smbd" ||
> $ctx.procname=="winbindd"'
> error syntax error
> Parse error
> Error: Invalid filter bytecode
> 
> If I try to wait after the failure for some time, I can run lttng disable-event
> -u -a, and re-run the enable-event with the filter successfully. But I tried to
> put the disable-event command in the script and that didn't help - i.e. the
> "disable-event" command worked, but the enable-event with filter still failed in
> the same way.
> 
> Suggestions?
> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> This body part will be downloaded on demand.
