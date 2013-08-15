From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Snapshot should be taken
 asap in core handler script
Date: Thu, 15 Aug 2013 13:33:11 -0400
Message-ID: <520D10D7.7080302__19515.1977976368$1376588055$gmane$org@efficios.com>
References: <1376586216-14065-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VA1QF-00074o-PY
	for lttng-dev@lists.lttng.org; Thu, 15 Aug 2013 13:33:25 -0400
In-Reply-To: <1376586216-14065-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Christian Babeux:
> Taking a snapshot should be the first thing the core handler does.
> An enormous core file write to disk could potentially discard a lot
> of tracing data if done before the snapshot.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  extras/core-handler/handler.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/extras/core-handler/handler.sh b/extras/core-handler/handler.sh
> index 7817282..c2d2402 100755
> --- a/extras/core-handler/handler.sh
> +++ b/extras/core-handler/handler.sh
> @@ -29,6 +29,12 @@ SESSION_NAME="coredump-handler"
>  # Sessiond binary name.
>  SESSIOND_BIN_NAME="lttng-sessiond"
>  
> +# TODO: Checking for a sessiond lockfile would be more appropriate.
> +if $PGREP_BIN -u root "${SESSIOND_BIN_NAME}" > /dev/null 2>&1
> +then
> +    $LTTNG_BIN snapshot record -s ${SESSION_NAME} > /dev/null 2>&1
> +fi
> +
>  # Core file settings.
>  CORE_PATH="/tmp/lttng/core"
>  CORE_PREFIX="core"
> @@ -54,9 +60,3 @@ $CAT_BIN - > "${CORE_PATH}/${CORE_PREFIX}.$p"
>  
>  # Optional, chain core dump handler with original systemd script.
>  #$CAT_BIN - | /usr/lib/systemd/systemd-coredump $p $u $g $s $t $e
> -
> -# TODO: Checking for a sessiond lockfile would be more appropriate.
> -if $PGREP_BIN -u root "${SESSIOND_BIN_NAME}" > /dev/null 2>&1
> -then
> -    $LTTNG_BIN snapshot record -s ${SESSION_NAME} > /dev/null 2>&1
> -fi
