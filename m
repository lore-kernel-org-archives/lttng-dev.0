From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: reloc offset validation
	error out on	filters with no reloc table
Date: Sat, 29 Sep 2012 13:38:52 -0400
Message-ID: <20120929173852.GB19525__32994.6675491103$1348940368$gmane$org@Krystal>
References: <1348873709-6547-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TI10A-0001Zh-GK
	for lttng-dev@lists.lttng.org; Sat, 29 Sep 2012 13:38:54 -0400
Content-Disposition: inline
In-Reply-To: <1348873709-6547-1-git-send-email-christian.babeux@efficios.com>
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

* Christian Babeux (christian.babeux@efficios.com) wrote:
> The reloc table is currently appended at the end of the bytecode data.
> With this scheme, the reloc table offset will be equal to the length
> of the bytecode data.

merged, thanks!

Mathieu

> 
> <- length ->
> +----------+-------------+
> | BYTECODE | RELOC TABLE |
> +----------+-------------+
>            |
>            +--> Reloc table offset
> 
> A special case arise with filters with no reloc table.
> 
> Example:
> 
> Filter: "myString" == "yourString"
> ./filter-grammar-test -p -B -i -b < bogus
> <root>
>         <op type="==">
>                 <expression>
>                         <string value="myString"/>
>                 </expression>
>                 <expression>
>                         <string value="yourString"/>
>                 </expression>
>         </op>
> </root>
> Generating IR... done
> Validating IR... done
> Generating bytecode... done
> Size of bytecode generated: 24 bytes.
> Bytecode:
> 
> Val. Operator
> ---- --------
> 0x40 (FILTER_OP_LOAD_STRING)
> 0x6D m
> 0x79 y
> 0x53 S
> 0x74 t
> 0x72 r
> 0x69 i
> 0x6E n
> 0x67 g
> 0x00 \0
> 0x40 (FILTER_OP_LOAD_STRING)
> 0x79 y
> 0x6F o
> 0x75 u
> 0x72 r
> 0x53 S
> 0x74 t
> 0x72 r
> 0x69 i
> 0x6E n
> 0x67 g
> 0x00 \0
> 0x0C (FILTER_OP_EQ)
> 0x01 (FILTER_OP_RETURN)
> 
> Reloc table (offset: 24):
> Empty
> 
> <-   24   ->
> +----------+
> | BYTECODE | <- No reloc table
> +----------+
>            |
>            +--> Reloc table offset
> 
> In this case, we see that the reloc table offset (24) is indeed equal to
> the length of the bytecode (24), but the reloc table is _empty_. Thus,
> the reloc_offset received in handle_message() will be equal to the
> data_size and will be wrongly flagged as not within the data even thought
> the filter is entirely valid.
> 
> The fix is to simply allow a reloc_offset to be equal to the data_size.
> 
> Fixes #342
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  liblttng-ust/lttng-ust-comm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> index a464e88..efc6724 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -294,7 +294,7 @@ int handle_message(struct sock_info *sock_info,
>  			goto error;
>  		}
>  
> -		if (lum->u.filter.reloc_offset > lum->u.filter.data_size - 1) {
> +		if (lum->u.filter.reloc_offset > lum->u.filter.data_size) {
>  			ERR("Filter reloc offset %u is not within data\n",
>  				lum->u.filter.reloc_offset);
>  			ret = -EINVAL;
> -- 
> 1.7.12
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
