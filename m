From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE PATCH] Fix: wrong type in
	bt_ctf_get_uint64/int64
Date: Tue, 7 Aug 2012 15:42:49 -0400
Message-ID: <20120807194249.GA1485__12444.0577849329$1344368599$gmane$org@Krystal>
References: <1344368148-468-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sypg2-0008Tg-EU
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 15:42:50 -0400
Content-Disposition: inline
In-Reply-To: <1344368148-468-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: eikosaedron@gmail.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Julien Desfossez (jdesfossez@efficios.com) wrote:
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>

merged, thanks to you both!

Mathieu

> ---
>  formats/ctf/events.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/formats/ctf/events.c b/formats/ctf/events.c
> index 9693413..a8b08f6 100644
> --- a/formats/ctf/events.c
> +++ b/formats/ctf/events.c
> @@ -407,7 +407,7 @@ int bt_ctf_get_array_len(const struct definition *field)
>  
>  uint64_t bt_ctf_get_uint64(const struct definition *field)
>  {
> -	unsigned int ret = 0;
> +	uint64_t ret = 0;
>  
>  	if (field && bt_ctf_field_type(field) == CTF_TYPE_INTEGER)
>  		ret = get_unsigned_int(field);
> @@ -419,7 +419,7 @@ uint64_t bt_ctf_get_uint64(const struct definition *field)
>  
>  int64_t bt_ctf_get_int64(const struct definition *field)
>  {
> -	int ret = 0;
> +	int64_t ret = 0;
>  
>  	if (field && bt_ctf_field_type(field) == CTF_TYPE_INTEGER)
>  		ret = get_signed_int(field);
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
