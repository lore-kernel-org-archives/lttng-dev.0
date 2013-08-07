From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc
	and	realloc.
Date: Wed, 7 Aug 2013 11:50:57 -0400
Message-ID: <20130807155057.GB1035__29101.7420044684$1375890715$gmane$org@Krystal>
References: <CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
	<51FA9AD8.4010502@mentor.com>
	<CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg@mail.gmail.com>
	<20130803011841.GE9033@Krystal> <51FFC4DB.7080905@mentor.com>
	<52025E03.7090201@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V760p-0007Hd-7p
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 11:51:04 -0400
Content-Disposition: inline
In-Reply-To: <52025E03.7090201@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Stefan Seefeld (stefan_seefeld@mentor.com) wrote:
> ...and another revision of the previous patch, now with mutex-protected
> static_calloc.
> For consistency I have also adjusted the ust_libc.h header to use 'void
> *' instead of 'unsigned long' in its tracepoint declaration.

merged.

I also pushed the following on top:

commit 4c3536e01190b118e0889ebb991b0eea6f98260e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Aug 7 11:48:50 2013 -0400

    malloc instrumentation: remove dependency on pthread
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

I notice that memalign and posix_memalign are missing. Do you have plans
to add them ?

Thanks,

Mathieu

> 
>     Stefan
> 
> 
> -- 
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/
> 

> From abbfdd44590876427a3fac463e8743afa7ceb149 Mon Sep 17 00:00:00 2001
> From: Stefan Seefeld <stefan_seefeld@mentor.com>
> Date: Sat, 27 Jul 2013 01:10:23 -0400
> Subject: [PATCH] Add trace support for calloc and realloc.
> 
> Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
> ---
>  liblttng-ust-libc-wrapper/lttng-ust-malloc.c | 73 +++++++++++++++++++++++++++-
>  liblttng-ust-libc-wrapper/ust_libc.h         | 22 ++++++++-
>  2 files changed, 91 insertions(+), 4 deletions(-)
> 
> diff --git a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> index 3212ff0..c7f747b 100644
> --- a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> +++ b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> @@ -21,14 +21,35 @@
>  #include <dlfcn.h>
>  #include <sys/types.h>
>  #include <stdio.h>
> +#include <pthread.h>
>  
>  #define TRACEPOINT_DEFINE
>  #define TRACEPOINT_CREATE_PROBES
>  #include "ust_libc.h"
>  
> +#define STATIC_CALLOC_LEN 4096
> +static char static_calloc_buf[STATIC_CALLOC_LEN];
> +static size_t static_calloc_buf_offset;
> +static pthread_mutex_t static_calloc_mutex = PTHREAD_MUTEX_INITIALIZER;
> +
> +static void *static_calloc(size_t nmemb, size_t size)
> +{
> +	size_t prev_offset;
> +
> +	pthread_mutex_lock(&static_calloc_mutex);
> +	if (nmemb * size > sizeof(static_calloc_buf) - static_calloc_buf_offset) {
> +		pthread_mutex_unlock(&static_calloc_mutex);
> +		return NULL;
> +	}
> +	prev_offset = static_calloc_buf_offset;
> +	static_calloc_buf_offset += nmemb * size;
> +	pthread_mutex_unlock(&static_calloc_mutex);
> +	return &static_calloc_buf[prev_offset];
> +}
> +
>  void *malloc(size_t size)
>  {
> -	static void *(*plibc_malloc)(size_t size) = NULL;
> +	static void *(*plibc_malloc)(size_t size);
>  	void *retval;
>  
>  	if (plibc_malloc == NULL) {
> @@ -45,7 +66,16 @@ void *malloc(size_t size)
>  
>  void free(void *ptr)
>  {
> -	static void *(*plibc_free)(void *ptr) = NULL;
> +	static void (*plibc_free)(void *ptr);
> +
> +	/* Check whether the memory was allocated with
> +	 * static_calloc, in which case there is nothing
> +	 * to free.
> +	 */
> +	if ((char *)ptr >= static_calloc_buf &&
> +	    (char *)ptr < static_calloc_buf + STATIC_CALLOC_LEN) {
> +		return;
> +	}
>  
>  	if (plibc_free == NULL) {
>  		plibc_free = dlsym(RTLD_NEXT, "free");
> @@ -57,3 +87,42 @@ void free(void *ptr)
>  	tracepoint(ust_libc, free, ptr);
>  	plibc_free(ptr);
>  }
> +
> +void *calloc(size_t nmemb, size_t size)
> +{
> +	static void *(*volatile plibc_calloc)(size_t nmemb, size_t size);
> +	void *retval;
> +
> +	if (plibc_calloc == NULL) {
> +		/*
> +		 * Temporarily redirect to static_calloc,
> +		 * until the dlsym lookup has completed.
> +		 */
> +		plibc_calloc = static_calloc;
> +		plibc_calloc = dlsym(RTLD_NEXT, "calloc");
> +		if (plibc_calloc == NULL) {
> +			fprintf(stderr, "callocwrap: unable to find calloc\n");
> +			return NULL;
> +		}
> +	}
> +	retval = plibc_calloc(nmemb, size);
> +	tracepoint(ust_libc, calloc, nmemb, size, retval);
> +	return retval;
> +}
> +
> +void *realloc(void *ptr, size_t size)
> +{
> +	static void *(*plibc_realloc)(void *ptr, size_t size);
> +	void *retval;
> +
> +	if (plibc_realloc == NULL) {
> +		plibc_realloc = dlsym(RTLD_NEXT, "realloc");
> +		if (plibc_realloc == NULL) {
> +			fprintf(stderr, "reallocwrap: unable to find realloc\n");
> +			return NULL;
> +		}
> +	}
> +	retval = plibc_realloc(ptr, size);
> +	tracepoint(ust_libc, realloc, ptr, size, retval);
> +	return retval;
> +}
> diff --git a/liblttng-ust-libc-wrapper/ust_libc.h b/liblttng-ust-libc-wrapper/ust_libc.h
> index af705aa..d2096a3 100644
> --- a/liblttng-ust-libc-wrapper/ust_libc.h
> +++ b/liblttng-ust-libc-wrapper/ust_libc.h
> @@ -36,14 +36,32 @@ TRACEPOINT_EVENT(ust_libc, malloc,
>  	TP_ARGS(size_t, size, void *, ptr),
>  	TP_FIELDS(
>  		ctf_integer(size_t, size, size)
> -		ctf_integer_hex(unsigned long, ptr, (unsigned long) ptr)
> +		ctf_integer_hex(void *, ptr, ptr)
>  	)
>  )
>  
>  TRACEPOINT_EVENT(ust_libc, free,
>  	TP_ARGS(void *, ptr),
>  	TP_FIELDS(
> -		ctf_integer_hex(unsigned long, ptr, (unsigned long) ptr)
> +		ctf_integer_hex(void *, ptr, ptr)
> +	)
> +)
> +
> +TRACEPOINT_EVENT(ust_libc, calloc,
> +	TP_ARGS(size_t, nmemb, size_t, size, void *, ptr),
> +	TP_FIELDS(
> +		ctf_integer(size_t, nmemb, nmemb)
> +		ctf_integer(size_t, size, size)
> +		ctf_integer_hex(void *, ptr, ptr)
> +	)
> +)
> +
> +TRACEPOINT_EVENT(ust_libc, realloc,
> +	TP_ARGS(void *, in_ptr, size_t, size, void *, ptr),
> +	TP_FIELDS(
> +		ctf_integer_hex(void *, in_ptr, in_ptr)
> +		ctf_integer(size_t, size, size)
> +		ctf_integer_hex(void *, ptr, ptr)
>  	)
>  )
>  
> -- 
> 1.8.3.1
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
