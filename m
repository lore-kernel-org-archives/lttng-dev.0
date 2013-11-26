From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tmf Ctf Parser Scalability issues (1/3)
Date: Tue, 26 Nov 2013 19:25:50 +0000 (UTC)
Message-ID: <460888779.76255.1385493950838.JavaMail.zimbra__16223.4997879297$1385494014$gmane$org@efficios.com>
References: <5294CFFE.2070001@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VlOGd-0007HD-4v
	for lttng-dev@lists.lttng.org; Tue, 26 Nov 2013 14:25:56 -0500
In-Reply-To: <5294CFFE.2070001@ericsson.com>
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
> Sent: Tuesday, November 26, 2013 11:44:46 AM
> Subject: [lttng-dev] Tmf Ctf Parser Scalability issues (1/3)
> 
> Hello all,
> I was looking at the CTF parser in the TMF project of Linux Tools. I
> have come up with three points where scalability will be an issue. I am
> sending 3 emails, each one describing one of the issues so we can
> aggregate them more cohesively. First a primer, CTF is a file format
> that has traces written in packets, the packets are parts of files in
> streams, the streams are files in a directory.
> 
> Issue 1: Number of open files
> CTF can have an unlimited amount of stream files. The parser opens all
> of them simultaneously. This means if you have say over 1024 or whatever
> your file limit is, files opened simultaneously, you will hit a wall. An
> example of this would be the new Xeon Phi boards that have something
> like 255 cores, if you have more than 4 channels per core, you're going
> to hit this issue.
> 
> Proposed solution:
> I envision fixing them by setting up a pool of files and when the limit
> is hit, swapping files in and out, incurring a performance hit but still
> allowing the program to run. Any objections?

No objection. I would think a LRU list of most recently used files would
be a good data structure for this. I already described this in a bug
against babeltrace: http://bugs.lttng.org/issues/649

Thanks!

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
