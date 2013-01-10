From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Java and UST ?
Date: Wed, 9 Jan 2013 21:00:01 -0500
Message-ID: <20130110020001.GA19541__34343.7677169733$1357783252$gmane$org@Krystal>
References: <268188172.2948226.1357684502836.JavaMail.root@vmware.com>
	<522299390.2953632.1357684920252.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tt7R7-000795-7z
	for lttng-dev@lists.lttng.org; Wed, 09 Jan 2013 21:00:05 -0500
Content-Disposition: inline
In-Reply-To: <522299390.2953632.1357684920252.JavaMail.root@vmware.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aaron Spear <aspear@vmware.com>, Jim Dumont <jim.dumont@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Jim, could you share the design we came up with to support JUL through
our various discussions ?

Thanks,

Mathieu

* Aaron Spear (aspear@vmware.com) wrote:
> Hi All, 
> 
> 
> In a conversation with Mathieu the other day he mentioned that there
> was some ongoing work to create some standard Java logging
> implementation that logged via UST. I was hoping to find some more
> detail about this and plans that are underway, and then ask how I can
> help. My ideal would be to have an SLF4J implementation (or
> java.util.logging) that I could easily build into any given java app
> that then uses UST to do the logging. There are many interesting
> questions that come up in my head with respect to what you do with
> mappings between Java and CTF (how "components" are treated, contexts,
> enable/disable, treatment of Java objects in CTF metadata, ...) 
> 
> 
> 
> cheers, 
> Aaron Spear 
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
