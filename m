From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tmf Ctf Parser Scalability issues (2/3)
Date: Tue, 26 Nov 2013 23:05:27 +0000 (UTC)
Message-ID: <1622770922.76310.1385507127379.JavaMail.zimbra__33740.9612177455$1385507195$gmane$org@efficios.com>
References: <5294D000.60505@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VlRhB-0005Lg-AD
	for lttng-dev@lists.lttng.org; Tue, 26 Nov 2013 18:05:35 -0500
In-Reply-To: <5294D000.60505@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev@lists.lttng.org, Linux Tools developer discussions <linuxtools-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Matthew Khouzam" <matthew.khouzam@ericsson.com>
> To: lttng-dev@lists.lttng.org, "Linux Tools developer discussions" <linuxtools-dev@eclipse.org>
> Sent: Tuesday, November 26, 2013 11:44:48 AM
> Subject: [lttng-dev] Tmf Ctf Parser Scalability issues (2/3)
> 
> Hello all,
> I was looking at the CTF parser in the TMF project of Linux Tools. I
> have come up with three points where scalability will be an issue. I am
> sending 3 emails, each one describing one of the issues so we can
> aggregate them more cohesively. First a primer, CTF is a file format
> that has traces written in packets, the packets are parts of files in
> streams, the streams are files in a directory.
> 
> Issue 2: Packet size
> CTF can have an packet with an unlimited size in within a stream. We use
> a memory map to access the data. We are limited to 2GB as the size of an
> individual packet, as far as I know. If a packet is larger this will
> make the trace unreadable. I can imagine hardware tracers that have ~3gb
> buffers and dump them to a file in a single packet would be affected by
> this.
> 
> Proposed solution:
> I envision fixing them by having a sliding window of the maximum memory
> map size. I see a problem if a single event is say 3GB in size, but I
> can't see a short term solution for that, would you have any suggestions
> on this front?

I just opened a bug entry http://bugs.lttng.org/issues/700 against babeltrace
to track this limitation in babeltrace too.

I don't think we need to address this quickly, but at least we should fail
with a descriptive error message when this situation is encountered.

If it every becomes useful to users, I would be tempted to go with a
sliding window for the memory map, as you suggest. However, you need to do
it in a way that ensures you can read every field. This can be done by
encapsulating every "read" operation on the trace, and making sure the
mmap'd window contains the field range to be read. There will probably
still be limitations for things like a string of more than 2gb, but again,
in this case, we could probably just provide a meaningful error message to
the user.

Thanks,

Mathieu

> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
