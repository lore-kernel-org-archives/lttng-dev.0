From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix out of tree build for doc examples
Date: Thu, 31 Oct 2013 12:12:03 +0000 (UTC)
Message-ID: <489509793.54168.1383221523736.JavaMail.zimbra__7562.63226871869$1383221568$gmane$org@efficios.com>
References: <1383220306-25661-1-git-send-email-cristiana.voicu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vbr6f-0007Ty-9g
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 08:12:10 -0400
In-Reply-To: <1383220306-25661-1-git-send-email-cristiana.voicu@intel.com>
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
> Sent: Thursday, October 31, 2013 7:51:46 AM
> Subject: [lttng-dev] [PATCH] Fix out of tree build for doc examples
> 
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> 
> Index: userspace-rcu-0.8.0/doc/examples/Makefile.am
> ===================================================================
> --- userspace-rcu-0.8.0.orig/doc/examples/Makefile.am	2013-08-30
> 21:25:20.000000000 +0300
> +++ userspace-rcu-0.8.0/doc/examples/Makefile.am	2013-10-21
> 17:52:34.774597179 +0300
> @@ -128,7 +128,7 @@
>  			cp -fR $(srcdir)/$$subdir $(builddir); \
>  		done; \
>  	fi
> -	$(MAKE) -f dist-files/Makefile AM_CPPFLAGS="$(CPPFLAGS) -I../../../urcu/
> -I../../../" AM_CFLAGS='$(CFLAGS)' AM_LDFLAGS='$(LDFLAGS) -L../../../.libs/
> -Wl,-rpath="$(PWD)/../../.libs/"' $(AM_MAKEFLAGS) all
> +	$(MAKE) -f dist-files/Makefile AM_CPPFLAGS="$(CPPFLAGS) -I$(top_srcdir)
> -I../../../urcu/ -I../../../" AM_CFLAGS='$(CFLAGS)' AM_LDFLAGS='$(LDFLAGS)
> -L../../../.libs/ -Wl,-rpath="$(PWD)/../../.libs/"' $(AM_MAKEFLAGS) all

I understand the issue, but the proposed fix is not quite right.

When we build examples, we are passing the AM_CPPFLAGS directly to Makefiles executed in subdirectories. Therefore, $(top_srcdir) is OK when it points to an absolute path, but points to a location that does not exist when it is a relative path (in the case we are not doing a out of tree build). Or someone could have put some headers there that would unexpectedly have precedence over the real urcu headers.

Can you provide an updated patch that takes care of this ?

Thanks,

Mathieu

>  
>  clean-local:
>  	$(MAKE) -f dist-files/Makefile $(AM_MAKEFLAGS) clean
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
