From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Initialize fd field of
 struct lttng_ust_elf to -1 at allocation
Date: Tue, 22 Jan 2019 10:41:04 -0500
Message-ID: <20190122154104.GA17450__37782.609874715$1548171690$gmane$org@joraj-alpa>
References: <20181114193837.23813-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43kXhC6wb2znDf
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 10:41:15 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C8205A6CB7
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 10:41:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20181114193837.23813-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

Any feedback regarding this patch?

Cheers

On Wed, Nov 14, 2018 at 02:38:37PM -0500, Jonathan Rajotte wrote:
> In rare cases when the executable cannot be open, using a default value
> of zero lead to invalid close call and fd tracker removal.
> 
> fixes #1171
> 
> Reported-by: Stefan Palade <stefan.palade@windriver.com>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  liblttng-ust/lttng-ust-elf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/liblttng-ust/lttng-ust-elf.c b/liblttng-ust/lttng-ust-elf.c
> index c073e7a5..3d6a9379 100644
> --- a/liblttng-ust/lttng-ust-elf.c
> +++ b/liblttng-ust/lttng-ust-elf.c
> @@ -250,6 +250,8 @@ struct lttng_ust_elf *lttng_ust_elf_create(const char *path)
>  		goto error;
>  	}
>  
> +	/* Initialize fd field to -1. 0 is a valid fd number */
> +	elf->fd = -1;
>  
>  	elf->path = strdup(path);
>  	if (!elf->path) {
> -- 
> 2.17.1
> 

-- 
Jonathan Rajotte-Julien
EfficiOS
