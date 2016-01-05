From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: missing _GNU_SOURCE define
Date: Tue, 5 Jan 2016 16:53:43 +0000 (UTC)
Message-ID: <1492840036.338083.1452012823824.JavaMail.zimbra__17970.2407368042$1452012886$gmane$org@efficios.com>
References: <1451946717-12219-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aGUrk-0005ZN-Mv
 for lttng-dev@lists.lttng.org; Tue, 05 Jan 2016 11:53:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0404B3402A3
 for <lttng-dev@lists.lttng.org>; Tue,  5 Jan 2016 16:53:45 +0000 (UTC)
In-Reply-To: <1451946717-12219-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

merged. thanks!

Mathieu

----- On Jan 4, 2016, at 5:31 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> O_CLOEXEC require _GNU_SOURCE.
> 
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> liblttng-ust/lttng-ust-elf.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/liblttng-ust/lttng-ust-elf.c b/liblttng-ust/lttng-ust-elf.c
> index dcae966..e906269 100644
> --- a/liblttng-ust/lttng-ust-elf.c
> +++ b/liblttng-ust/lttng-ust-elf.c
> @@ -16,6 +16,7 @@
>  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
>  */
> 
> +#define _GNU_SOURCE
> #include <helper.h>
> #include <string.h>
> #include <lttng/align.h>
> --
> 2.5.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
