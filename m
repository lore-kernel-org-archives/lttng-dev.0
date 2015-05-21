From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [PATCH latency_tracker] Use $(src) rather than pwd
 to identify the source tree.
Date: Wed, 20 May 2015 22:50:55 -0400
Message-ID: <555D480F.6070206__22368.1974960074$1432176717$gmane$org@efficios.com>
References: <1432164774-11677-1-git-send-email-bpoirier@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1YvGZZ-0003PO-QK
 for lttng-dev@lists.lttng.org; Wed, 20 May 2015 22:51:04 -0400
In-Reply-To: <1432164774-11677-1-git-send-email-bpoirier@suse.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Benjamin Poirier <bpoirier@suse.de>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged, thanks !

Julien

On 15-05-20 07:32 PM, Benjamin Poirier wrote:
> This fixes the build when using kernels older than "aa55c8e kbuild: handle
> C=... and M=... after entering into build directory (v3.18-rc1)" and a
> separate object output directory (`make O=...`).
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.de>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 360b24b..de141df 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -I$(PWD)/include $(EXTCFLAGS)
> +ccflags-y += -I$(src)/include $(EXTCFLAGS)
>  
>  latency_tracker-objs := tracker.o rculfhash.o rculfhash-mm-chunk.o wfcqueue.o
>  
> 
