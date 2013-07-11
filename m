From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: How much shared memory is used by LTTng (UST) ?
Date: Thu, 11 Jul 2013 10:35:43 -0400 (EDT)
Message-ID: <234052720.280781373553343864.JavaMail.root__35714.1634602614$1373553382$gmane$org@srv12.zimbra.polymtl.ca>
References: <1054380936.280601373553250822.JavaMail.root@srv12.zimbra.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <michel.dagenais@polymtl.ca>) id 1UxHyG-0007Et-MI
	for lttng-dev@lists.lttng.org; Thu, 11 Jul 2013 10:35:48 -0400
In-Reply-To: <1054380936.280601373553250822.JavaMail.root@srv12.zimbra.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


> > It still doesn't explain why I was able to add procname to the
> > context but adding also vpid and vtid failed when the number of cores was 24
> > rather than 12.
> 
> No idea. These are unrelated.

Perhaps you were not tracing that much and not filling all buffers with the smaller events with less context? The kernel buffers are probably pre-allocated for real but other buffers in user-space may not.
