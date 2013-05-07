From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Extracting LTTng ring buffers from a vmcore?
Date: Tue, 7 May 2013 16:12:50 -0400
Message-ID: <20130507201250.GD8879__3800.84717548943$1367957645$gmane$org@Krystal>
References: <20130318195810.Horde.Fv0FZZir309RR6oS2LPiI2A@imap.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZoFn-0005Po-CH
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 16:12:51 -0400
Content-Disposition: inline
In-Reply-To: <20130318195810.Horde.Fv0FZZir309RR6oS2LPiI2A@imap.linux.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: nathanm2@linux.vnet.ibm.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* nathanm2@linux.vnet.ibm.com (nathanm2@linux.vnet.ibm.com) wrote:
> While reading through the lib_ring_buffer_commit function I came across 
> the following comment:
>
> /*
>  * Update used size at each commit. It's needed only for extracting
>  * ring_buffer buffers from vmcore, after crash.
>  */
>
> I need something exactly like this, but didn't see anything while  
> looking through the lttng tools.  Did I miss something?

It's there in the ring buffer, but not implemented yet in lttng-modules
nor lttng-tools.

Thanks,

Mathieu

>
> Thanks
> Nate
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
