From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Mon, 10 Feb 2014 19:53:03 -0500
Message-ID: <52F9746F.5070302__4581.68012924052$1392080068$gmane$org@mentor.com>
References: <52F55511.2080309@mentor.com>
	<1380151240.21051.1391875592403.JavaMail.zimbra@efficios.com>
	<52F66118.5010003@mentor.com>
	<905376946.21151.1391898148330.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1WD1b5-0004Bv-Rm
	for lttng-dev@lists.lttng.org; Mon, 10 Feb 2014 19:53:17 -0500
In-Reply-To: <905376946.21151.1391898148330.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Mathieu,

after our follow-up discussion I agree to the proposed patch. A few
details below...

On 02/08/2014 05:22 PM, Mathieu Desnoyers wrote:

> Interesting approach. Then I wonder if we couldn't simply lookup every symbol
> we're interested in whenever any of the overridden function is called and
> we notice a NULL pointer, and provide a simplistic "static" allocator for
> every function overridden.
> 
> Please let me know if something like the attached patch works for you.
> It seems more solid to cover all the cases, so that if the dlsym() implementation
> ever chooses to use other functions from the memory allocator, it will still work.

OK, agreed.


> +static
> +void *static_realloc(void *ptr, size_t size)
> +{
> +	/* Don't free previous memory location */
> +	return static_calloc_aligned(1, size, 1);
> +}

The above of course also needs a memcpy operation, to preserve the
original data.

> +		if (cur_alloc.malloc == NULL) {
>  			fprintf(stderr, "mallocwrap: unable to find malloc\n");
> -			return NULL;
> +			abort();
>  		}

I'm actually not quite sure what behaviour I would prefer as a user. My
library-author feeling tell me to not abort the process, but return an
error condition (i.e., NULL) and let the caller take care of how to
handle it.
On the other hand, not finding malloc certainly is a critical error.
And, this isn't a library in the proper sense, but a preloaded wrapper,
so users can always re-run his apps without it.
Hmm...

Otherwise the patch looks good.

Thanks,
		Stefan


-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
