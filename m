From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] fix: Add missing files to
 distribution
Date: Mon, 21 Oct 2019 14:38:13 -0400 (EDT)
Message-ID: <1345363801.1936.1571683093691.JavaMail.zimbra__44958.9260433399$1571683116$gmane$org@efficios.com>
References: <20191021170414.9048-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46xlkv1JYvz1QTY
 for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2019 14:38:14 -0400 (EDT)
In-Reply-To: <20191021170414.9048-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into UST 2.10, 2.11, master, thanks!

Mathieu

----- On Oct 21, 2019, at 1:04 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> Makefile.am | 15 ++++++++++++---
> 1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 810761ca..73b51909 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -34,9 +34,18 @@ SUBDIRS += tests doc
> pkgconfigdir = $(libdir)/pkgconfig
> pkgconfig_DATA = lttng-ust.pc
> 
> -dist_doc_DATA = README.md ChangeLog
> -
> -dist_noinst_DATA = CodingStyle
> +dist_doc_DATA = \
> +	ChangeLog \
> +	COPYING \
> +	LICENSE \
> +	README.md
> +
> +dist_noinst_DATA = \
> +	CodingStyle \
> +	CONTRIBUTING.md \
> +	gpl-2.0.txt \
> +	lgpl-2.1.txt \
> +	mit-license.txt
> 
> check-loop:
> 	cd tests && $(MAKE) $(AM_MAKEFLAGS) check-loop
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
