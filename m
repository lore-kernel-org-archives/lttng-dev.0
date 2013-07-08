From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Add
	bt_unregister_format	function support
Date: Mon, 8 Jul 2013 19:42:14 -0400
Message-ID: <20130708234214.GA7088__24550.1114674427$1373327087$gmane$org@Krystal>
References: <1373352622-11876-1-git-send-email-xiaonahappy13@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwL4U-0001jP-13
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 19:42:18 -0400
Content-Disposition: inline
In-Reply-To: <1373352622-11876-1-git-send-email-xiaonahappy13@163.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Xiaona Han <xiaonahappy13@163.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Xiaona Han (xiaonahappy13@163.com) wrote:

merged into bindings/python.

Please add your Signed-off-by line next time.

Thanks,

Mathieu

> ---
>  bindings/python/babeltrace.i.in |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace.i.in
> index 06b8d40..dd2dacc 100644
> --- a/bindings/python/babeltrace.i.in
> +++ b/bindings/python/babeltrace.i.in
> @@ -188,10 +188,12 @@ class Context:
>  %rename("lookup_format") bt_lookup_format(bt_intern_str qname);
>  %rename("_bt_print_format_list") bt_fprintf_format_list(FILE *fp);
>  %rename("register_format") bt_register_format(struct format *format);
> +%rename("unregister_format") bt_unregister_format(struct bt_format *format);
>  
>  extern struct format *bt_lookup_format(bt_intern_str qname);
>  extern void bt_fprintf_format_list(FILE *fp);
>  extern int bt_register_format(struct bt_format *format);
> +extern void bt_unregister_format(struct bt_format *format);
>  
>  %pythoncode %{
>  
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
