From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Uprobe and extractor for coredump
Date: Thu, 9 Aug 2012 10:02:40 -0400
Message-ID: <20120809140240.GB8937__38100.6270334639$1344520985$gmane$org@Krystal>
References: <6539770C71C3814BB0BFC2DBEBD10508CC6967@CORPUSMX30B.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SzTJx-0002Wl-LP
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 10:02:41 -0400
Content-Disposition: inline
In-Reply-To: <6539770C71C3814BB0BFC2DBEBD10508CC6967@CORPUSMX30B.corp.emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Chang, Zheng" <Zheng.Chang@emc.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Chang, Zheng (Zheng.Chang@emc.com) wrote:
> Hi,
> 
>  
> 
> Recently Linus merged uprobe into kernel mainline and perf has supported
> user-space dynamic tracing now.
> 
> Is there any plan or motion on this with LTTng?

this would certainly be a nice feature! If you want to work on adding
support within lttng-modules and lttng-tools to enable tracing of
userspace through uprobes, it would certainly be welcome!

> 
> I did some research on buffer management of LTTng. And I'm trying to
> figure out a way to extract trace info from coredump.
> 
> Here is an immature idea about the extractor:
> 
> -          Resolve the addresses of necessary symbols from coredump with
> binary format library/tool
> 
> -          Restructure the data structures
> 
> -          Following the data structures, dump the buffer data page by
> page
> 
>  
> 
> Any good ideas or suggestions or concerns?

One main thing I want us to be careful about: if we do that, we need
some kind of versioning information in the tracer that can be checked by
the core dumper, so we can do changes internally without breaking the
code dump.

Thoughts ?

Thanks,

Mathieu

> 
>  
> 
> BR
> 
> Zheng
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
