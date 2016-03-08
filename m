From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH lttng-tools] Test: prevent the spawning of
	a	daemonized sessiond
Date: Tue, 8 Mar 2016 22:19:15 +0000 (UTC)
Message-ID: <495428957.19719.1457475555452.JavaMail.zimbra__36059.2687655755$1457475652$gmane$org@efficios.com>
References: <1457475118-17426-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1adPyV-0003N9-8D
 for lttng-dev@lists.lttng.org; Tue, 08 Mar 2016 17:19:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 15AFC34058B
 for <lttng-dev@lists.lttng.org>; Tue,  8 Mar 2016 22:19:26 +0000 (UTC)
In-Reply-To: <1457475118-17426-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

A comment explaining why LTTNG_SESSIOND_PATH is set to "/bin/true" would
be quite helpful to anybody re-reading this file.

Michael

----- On Mar 8, 2016, at 5:11 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> tests/utils/utils.sh | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
> index da23f7a..1067438 100644
> --- a/tests/utils/utils.sh
> +++ b/tests/utils/utils.sh
> @@ -32,6 +32,7 @@ KERNEL_PATCHLEVEL_VERSION=27
> # basic tests don't have to worry about hitting timeouts on busy
> # systems. Specialized tests should test those corner-cases.
> export LTTNG_UST_REGISTER_TIMEOUT=-1
> +export LTTNG_SESSIOND_PATH="/bin/true"
> 
> source $TESTDIR/utils/tap/tap.sh
> 
> --
> 2.7.0
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
