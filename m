From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Is there a way to make LTTng use the
	same	subbuffers for multiple processes?
Date: Mon, 29 Apr 2013 12:27:52 -0400
Message-ID: <20130429162752.GB17859__22681.1092500158$1367252895$gmane$org@Krystal>
References: <OFDF63FF91.58AE5030-ONC2257B5B.004BA0B5-C2257B5B.004C083C@il.ibm.com>
	<1871619348.1882721367199149384.JavaMail.root@srv11.zimbra.polymtl.ca>
	<OF8C8BE38C.B94DDD3A-ONC2257B5C.004E2988-C2257B5C.004E3D1B@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UWqvh-0004MO-Ql
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 12:27:53 -0400
Content-Disposition: inline
In-Reply-To: <OF8C8BE38C.B94DDD3A-ONC2257B5C.004E2988-C2257B5C.004E3D1B@il.ibm.com>
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
> Another 2.2 question -
> 
> What if I have a single process, that forks, and each child process then 
> changes its own UID. Will the tracing continue on the parent UID buffers?

Yes, we indeed currently keep the user ID that was effective at process
creation or last exec() encountered, because we don't have hooks in
libc's setuid() at the moment.

Thanks,

Mathieu

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
> From:   Michel Dagenais <michel.dagenais@polymtl.ca>
> To:     Amit Margalit/Israel/IBM@IBMIL
> Cc:     lttng-dev@lists.lttng.org
> Date:   04/29/2013 04:32 AM
> Subject:        Re: [lttng-dev] Is there a way to make LTTng use the same 
> subbuffers for multiple processes?
> 
> 
> 
> 
> > Our system is a 12-core x86 (6-core + HT). If I take 4 subbuffers of 
> 1MB, this means 4MB per
> > process. As the number of processes rises, this becomes prohibitive. 
> > For example, we may need to support > 500 sub-processes ==> 500 * 4MB = 
> 2GB - 
> > which is a bit too much.  Is there a way to tell LTTng to share the 
> sub-buffers with forked processes? 
> 
> This is the number one feature listed in the changelog for lttng-tools and 
> UST for version 2.2. The first release candidate is out so you can try the 
> feature, and the final 2.2 version should not be too far away.
> 
> http://lttng.org/lttng-tools-220-rc1
> - Add UST per UID buffers support
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
