From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Question about TRACEPOINT_FORMAT
Date: Thu, 4 Jul 2013 09:06:30 -0400
Message-ID: <20130704130630.GA26657__30391.1332427107$1372943223$gmane$org@Krystal>
References: <OF4D6A58C0.10B26BF7-ONC2257B80.00269F6C-C2257B80.002A27FA@il.ibm.com>
	<OFD0EE71AC.5944B0C7-ONC2257B9E.0046DDB5-C2257B9E.0046E746@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UujF2-0001La-1K
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 09:06:32 -0400
Content-Disposition: inline
In-Reply-To: <OFD0EE71AC.5944B0C7-ONC2257B9E.0046DDB5-C2257B9E.0046E746@il.ibm.com>
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

* Amit Margalit (AMITM@il.ibm.com) wrote:
> Hi,
> 
> I never got any response to this. Anyone care to comment?
> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> 
> From:   Amit Margalit/Israel/IBM@IBMIL
> To:     lttng-dev@lists.lttng.org
> Date:   06/04/2013 10:41 AM
> Subject:        [lttng-dev] Question about TRACEPOINT_FORMAT
> 
> 
> 
> Hello, 
> 
> I've read the discussion in the past about this suggested feature, and I'd 
> like to ask what has become of this. Is this still being considered? Has 
> anyone come up with an idea for a solution that does not include extending 
> CTF? 
> 
> I understand that CTF doesn't support looking into the ELF binary, but 
> perhaps there is a way around this. 
> 
> First, I'd like to explain what I wish to have, so that maybe a different 
> solution could be suggested - 
> In all, migration from an existing log-to-file system for existing 
> projects may push the entire formatted string as the trace entry. 
> We'd like to avoid storing the entire format string multiple times, as 
> this is wasteful, of course, and we'd like the viewer to be in charge of 
> performing the formatting. 
> 
> I was wondering whether we could use CTF enums. The CTF specification for 
> enums doesn't say that the textual representation of the value has to be a 
> valid identifier. In fact, the example includes a quoted string. 
> 
> An instrumentation tool could generate code that writes an enum 
> description into the metadata, where each value corresponds to a different 
> format string. 

I have something quite simpler in mind for this, but it involves
extending the CTF spec. Adding, to the event {} description within the
metadata, something like:

event {
        ...
        format = "This is the first field: %u and the second: %llu";
        ...
}

Thoughts ?

Thanks,

Mathieu

> 
> Thanks, 
> 
> Amit Margalit 
> IBM XIV - Storage Reinvented 
> XIV-NAS Development Team 
> Tel. 03-689-7774 
> Fax. 03-689-7230_______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
