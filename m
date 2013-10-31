From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Use cross compiler for doc exemples too
Date: Thu, 31 Oct 2013 11:38:52 +0000 (UTC)
Message-ID: <1676420105.54028.1383219532179.JavaMail.zimbra__9204.52067298374$1383219574$gmane$org@efficios.com>
References: <1383207044-30477-1-git-send-email-cristiana.voicu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VbqaV-0003K3-5k
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 07:38:56 -0400
In-Reply-To: <1383207044-30477-1-git-send-email-cristiana.voicu@intel.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Cristiana Voicu <cristiana.voicu@intel.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Cristiana Voicu" <cristiana.voicu@intel.com>
> To: lttng-dev@lists.lttng.org
> Cc: "Cristiana Voicu" <cristiana.voicu@intel.com>
> Sent: Thursday, October 31, 2013 4:10:44 AM
> Subject: [lttng-dev] [PATCH] Use cross compiler for doc exemples too

Renaming the title from "exemples" to "examples". Other than that, all good, thanks!

Merging into urcu master and stable-0.8.

Mathieu

> 
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> 
> Index: userspace-rcu-0.8.0/doc/examples/Makefile.examples.template
> ===================================================================
> --- userspace-rcu-0.8.0.orig/doc/examples/Makefile.examples.template
> 	2013-08-30 21:25:20.000000000 +0300
> +++ userspace-rcu-0.8.0/doc/examples/Makefile.examples.template	2013-10-23
> 13:34:30.405550556 +0300
> @@ -11,7 +11,9 @@
>  #
>  # This makefile is purposefully kept simple to support GNU and BSD make.
>  
> +ifndef CC
>  CC = gcc
> +endif
>  CFLAGS = -g -O2 -Wall
>  
>  all: $(BINARY)
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
