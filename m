From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tmf Ctf Parser Scalability issues (3/3)
Date: Tue, 26 Nov 2013 23:07:20 +0000 (UTC)
Message-ID: <206978342.76316.1385507240205.JavaMail.zimbra__39886.5683041096$1385507301$gmane$org@efficios.com>
References: <5294D003.5040104@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VlRix-0006Dt-WA
	for lttng-dev@lists.lttng.org; Tue, 26 Nov 2013 18:07:25 -0500
In-Reply-To: <5294D003.5040104@ericsson.com>
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
> Sent: Tuesday, November 26, 2013 11:44:51 AM
> Subject: [lttng-dev] Tmf Ctf Parser Scalability issues (3/3)
> 
> Hello all,
> I was looking at the CTF parser in the TMF project of Linux Tools. I
> have come up with three points where scalability will be an issue. I am
> sending 3 emails, each one describing one of the issues so we can
> aggregate them more cohesively. First a primer, CTF is a file format
> that has traces written in packets, the packets are parts of files in
> streams, the streams are files in a directory.
> 
> Issue 3: Event size
> As hinted in the previous email, it can definitely be a possibility that
> traces can have events that are too large to fit into memory. These
> events could also make reading a packet difficult, since the packet
> could have a said event in the middle, and therefore, we could end up
> with a packet that cannot be read properly with the sliding window
> memory map, unless corrective actions are taken.
> 
> Proposed solution:
> Would anyone do this? I see it as a longer term problem and as a known
> limitation, unless someone says "Hey, I want 8gb events!".

I'm tempted to say that we should put that limitation on individual
non-compound field, rather than events. Therefore, you could not have
such a large string, nor such a large integer, but you could very well
have a very large array of integers within an event which would be 8gb
in size.

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
