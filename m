From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add aarch64 support to configure
Date: Thu, 18 Jun 2015 14:53:19 +0000 (UTC)
Message-ID: <1834678113.888.1434639199928.JavaMail.zimbra__9212.50464530221$1434639303$gmane$org@efficios.com>
References: <1434638515-20300-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z5bC9-0003n0-B2
 for lttng-dev@lists.lttng.org; Thu, 18 Jun 2015 10:53:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 09200340488
 for <lttng-dev@lists.lttng.org>; Thu, 18 Jun 2015 14:53:28 +0000 (UTC)
In-Reply-To: <1434638515-20300-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

merged into master and stable-2.6, thanks!

Mathieu

----- On Jun 18, 2015, at 10:41 AM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> configure.ac | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/configure.ac b/configure.ac
> index f84f426..971cf54 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -238,6 +238,7 @@ changequote([,])dnl
> 	s390) NO_UNALIGNED_ACCESS=1 ;;
> 	s390x) NO_UNALIGNED_ACCESS=1 ;;
>         arm*) NO_UNALIGNED_ACCESS=1 ;;
> +	aarch64) NO_UNALIGNED_ACCESS=1 ;;
> 	mips*) NO_UNALIGNED_ACCESS=1 ;;
> 	tile*) NO_UNALIGNED_ACCESS=1 ;;
> 	*) AC_MSG_ERROR([unable to detect alignment requirements (unsupported
> 	architecture ($host_cpu)?)]) ;;
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
