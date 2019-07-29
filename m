From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust v2] Use MAP_POPULATE to reduce
 pagefault when available
Date: Mon, 29 Jul 2019 15:01:31 -0400 (EDT)
Message-ID: <276483296.2554.1564426891224.JavaMail.zimbra__44070.7196293928$1564426905$gmane$org@efficios.com>
References: <20190729184959.23802-1-jonathan.rajotte-julien@efficios.com>
 <22738144.2494.1564426529986.JavaMail.zimbra@efficios.com>
 <441408385.2496.1564426664647.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45y8DX0R3Gz1FwY
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 15:01:32 -0400 (EDT)
In-Reply-To: <441408385.2496.1564426664647.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: Yiteng Guo <guoyiteng@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



----- On Jul 29, 2019, at 2:57 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jul 29, 2019, at 2:55 PM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On Jul 29, 2019, at 2:49 PM, Jonathan Rajotte
>> jonathan.rajotte-julien@efficios.com wrote:
>> 
>>> Any ring buffer configuration bigger than PAGE_SIZE would result
>>> in an increased latency for the first tracepoint hit (1200ns) landing on a
>>> new PAGE_SIZE sized chunk of the mapped memory. This happens at least
>>> for the first ring buffer traversal.
>>> 
>>> To alleviate this we can use MAP_POPULATE that will "prefault" the page
>>> tables.
>>> 
>>> A similar flag seems to exist on freebsd (MAP_PREFAULT_READ) but I do
>>> not have access to a system to test it and ensure it does indeed results
>>> in the same effect. It mostly indicates that it prefaults for the
>>> read case so I doubt it is the case.
>>> 
>>> Default to using MAP_POPULATE on Linux only for now. Support of
>>> prefaulting on other platforms will be added as needed.
>>> 
>>> Links: https://lists.lttng.org/pipermail/lttng-dev/2019-July/029116.html
>>>       https://lists.lttng.org/pipermail/lttng-dev/2019-July/029122.html
>> 
>> Next time please do:
>> 
>> Link: https://lists.lttng.org/pipermail/lttng-dev/2019-July/029116.html
>> Link: https://lists.lttng.org/pipermail/lttng-dev/2019-July/029122.html
>> 
>> I'll edit it on my side,
> 
> 
> I'm also adding this missing bit for make dist:
> 
> --- a/libringbuffer/Makefile.am
> +++ b/libringbuffer/Makefile.am
> @@ -8,7 +8,7 @@ libringbuffer_la_SOURCES = \
>        shm.c shm.h shm_types.h shm_internal.h \
>        ring_buffer_backend.c \
>        ring_buffer_frontend.c \
> -       api.h \
> +       api.h mmap.h \
>        backend.h backend_internal.h backend_types.h \
>        frontend_api.h frontend.h frontend_internal.h frontend_types.h \
>        nohz.h vatomic.h rb-init.h
> 

Merged into master and stable-2.11 (still in rc phase).

Thanks,

Mathieu

> Thanks,
> 
> Mathieu
> 
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>>> 
>>> Tested-by: Yiteng Guo <guoyiteng@gmail.com>
>>> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
>>> ---
>>> libringbuffer/mmap.h | 30 ++++++++++++++++++++++++++++++
>>> libringbuffer/shm.c  |  5 +++--
>>> 2 files changed, 33 insertions(+), 2 deletions(-)
>>> create mode 100644 libringbuffer/mmap.h
>>> 
>>> diff --git a/libringbuffer/mmap.h b/libringbuffer/mmap.h
>>> new file mode 100644
>>> index 00000000..f195c152
>>> --- /dev/null
>>> +++ b/libringbuffer/mmap.h
>>> @@ -0,0 +1,30 @@
>>> +#ifndef _LTTNG_MMAP_H
>>> +#define _LTTNG_MMAP_H
>>> +
>>> +/*
>>> + * Copyright (c) 2019 - Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
>>> + *
>>> + * This library is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU Lesser General Public
>>> + * License as published by the Free Software Foundation; only
>>> + * version 2.1 of the License.
>>> + *
>>> + * This library is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
>>> + * Lesser General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU Lesser General Public
>>> + * License along with this library; if not, write to the Free Software
>>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>>> + */
>>> +
>>> +#include <sys/mman.h>
>>> +
>>> +#if defined(__linux__) && defined(MAP_POPULATE)
>>> +# define LTTNG_MAP_POPULATE MAP_POPULATE
>>> +#else
>>> +# define LTTNG_MAP_POPULATE 0
>>> +#endif /* __linux__ && MAP_POPULATE */
>>> +
>>> +#endif /* _LTTNG_MMAP_H */
>>> diff --git a/libringbuffer/shm.c b/libringbuffer/shm.c
>>> index 10b3bcef..909991ed 100644
>>> --- a/libringbuffer/shm.c
>>> +++ b/libringbuffer/shm.c
>>> @@ -40,6 +40,7 @@
>>> #endif
>>> #include <helper.h>
>>> #include <ust-fd.h>
>>> +#include "mmap.h"
>>> 
>>> /*
>>>  * Ensure we have the required amount of space available by writing 0
>>> @@ -154,7 +155,7 @@ struct shm_object *_shm_object_table_alloc_shm(struct
>>> shm_object_table *table,
>>> 
>>> 	/* memory_map: mmap */
>>> 	memory_map = mmap(NULL, memory_map_size, PROT_READ | PROT_WRITE,
>>> -			  MAP_SHARED, shmfd, 0);
>>> +			  MAP_SHARED | LTTNG_MAP_POPULATE, shmfd, 0);
>>> 	if (memory_map == MAP_FAILED) {
>>> 		PERROR("mmap");
>>> 		goto error_mmap;
>>> @@ -341,7 +342,7 @@ struct shm_object *shm_object_table_append_shm(struct
>>> shm_object_table *table,
>>> 
>>> 	/* memory_map: mmap */
>>> 	memory_map = mmap(NULL, memory_map_size, PROT_READ | PROT_WRITE,
>>> -			  MAP_SHARED, shm_fd, 0);
>>> +			  MAP_SHARED | LTTNG_MAP_POPULATE, shm_fd, 0);
>>> 	if (memory_map == MAP_FAILED) {
>>> 		PERROR("mmap");
>>> 		goto error_mmap;
>>> --
>>> 2.17.1
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
