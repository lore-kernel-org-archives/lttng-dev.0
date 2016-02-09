From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Add CONFIG_LTTNG to
 modules_install target
Date: Tue, 9 Feb 2016 20:21:18 +0000 (UTC)
Message-ID: <1664904875.15501.1455049278567.JavaMail.zimbra__11300.7033280612$1455049337$gmane$org@efficios.com>
References: <1455049016-6087-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aTEmv-0000Cw-Mg
 for lttng-dev@lists.lttng.org; Tue, 09 Feb 2016 15:21:30 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8CC11340560
 for <lttng-dev@lists.lttng.org>; Tue,  9 Feb 2016 20:21:24 +0000 (UTC)
In-Reply-To: <1455049016-6087-1-git-send-email-mjeanson@efficios.com>
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

merged, thanks!

Mathieu

----- On Feb 9, 2016, at 3:16 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> Makefile | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 6a8c5c7..5d6be94 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -103,12 +103,12 @@ default:
> 	$(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_LTTNG=m modules
> 
> modules_install:
> -	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install
> +	$(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_LTTNG=m modules_install
> 
> clean:
> 	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean
> 
> %.i: %.c
> -	$(MAKE) -C $(KERNELDIR) M=$(PWD) $@
> +	$(MAKE) -C $(KERNELDIR) M=$(PWD) CONFIG_LTTNG=m $@
> 
> endif # KERNELRELEASE
> --
> 2.7.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
