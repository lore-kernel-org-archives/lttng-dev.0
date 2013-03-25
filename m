From: "Maxin B. John" <maxin.john@enea.com>
Subject: Re: [PATCH] lttng-module: block.h : Fix build for 3.9
	kernel
Date: Mon, 25 Mar 2013 15:22:32 +0100
Message-ID: <20130325142232.GA17611__2841.72017495639$1364221410$gmane$org@sestofb10.enea.se>
References: <20130325133334.GA32008@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <Maxin.John@enea.com>) id 1UK8IJ-0007O8-79
	for lttng-dev@lists.lttng.org; Mon, 25 Mar 2013 10:22:39 -0400
Content-Disposition: inline
In-Reply-To: <20130325133334.GA32008@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

 On Mon, Mar 25, 2013 at 09:33:34AM -0400, Mathieu Desnoyers wrote:
 > * maxin.john@enea.com (maxin.john@enea.com) wrote:
 > > From: "Maxin B. John" <maxin.john@enea.com>
 > > commit :3a366e614d0837d9fc23f78cdb1a1186ebc3387f
 > >  block: add missing block_bio_complete() tracepoint
 > > added block_bio_complete to 3.9 kernel
 > > commit : 8c1cf6bb02fda79b0a4b9bd121f6be6d4ce7a15a
 > >  block: add @req to bio_{front|back}_merge tracepoints
 > > added block_bio_backmerge and block_bio_frontmerge to 3.9 kernel
 > > Update block.h based on these commits in mainline kernel
 > Disabling the event prior to 3.9.0 does not seem to be the proper
 > solution. We should rather #ifdef the old/new TRACE_EVENT definitions to
 > accept the proper number of arguments for each kernel.

 Thank you very much for the review comments.I will update it
accordingly. 

 > Thanks,
 > Mathieu

Best Regards,
Maxin
