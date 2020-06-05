From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Userspace RCU data alignment
Date: Fri, 5 Jun 2020 12:09:08 -0400 (EDT)
Message-ID: <168357390.56518.1591373348015.JavaMail.zimbra@efficios.com>
References: <5352eebd-dbb7-70f9-a354-91522170efdf@yandex.ru>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49dndl0Jchz1MgV
 for <lttng-dev@lists.lttng.org>; Fri,  5 Jun 2020 12:09:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 743AE2CF203
 for <lttng-dev@lists.lttng.org>; Fri,  5 Jun 2020 12:09:08 -0400 (EDT)
In-Reply-To: <5352eebd-dbb7-70f9-a354-91522170efdf@yandex.ru>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jun 3, 2020, at 8:36 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> I've compiled userspace-rcu with:
> 
> CC=gcc CFLAGS='-O0 -g3 -fsanitize=undefined' LIBS='-lubsan' ./configure [xxx]
> 
> and see a lot of 'misaligned address' runtime errors like:
> 
>  ./doc/examples/urcu-flavors/bp ==>
> 
> ../include/urcu/static/urcu-bp.h:185:6: runtime error: member access within
> misaligned address 0x7fcac376a020 for type 'struct urcu_bp_reader', which
> requires 128 byte alignment
> 0x7fcac376a020: note: pointer points here
>  ca 7f 00 00  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00
>  00 00  00 00 00 00
>               ^
>     #0 0x7fcac372a880 in _urcu_bp_read_unlock ../include/urcu/static/urcu-bp.h:185
>     #1 0x7fcac372b0d9 in urcu_bp_read_unlock
>     /home/antipov/userspace-rcu/src/urcu-bp.c:363
>     #2 0x4017d5 in main
>     /home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp.c:92
>     #3 0x7fcac2bc2041 in __libc_start_main ../csu/libc-start.c:308
>     #4 0x40111d in _start
>     (/home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp+0x40111d)
> 
> ../include/urcu/static/urcu-bp.h:189:2: runtime error: member access within
> misaligned address 0x7fcac376a020 for type 'struct urcu_bp_reader', which
> requires 128 byte alignment
> 0x7fcac376a020: note: pointer points here
>  ca 7f 00 00  01 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00
>  00 00  00 00 00 00
>               ^
>     #0 0x7fcac372a8c1 in _urcu_bp_read_unlock ../include/urcu/static/urcu-bp.h:189
>     #1 0x7fcac372b0d9 in urcu_bp_read_unlock
>     /home/antipov/userspace-rcu/src/urcu-bp.c:363
>     #2 0x4017d5 in main
>     /home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp.c:92
>     #3 0x7fcac2bc2041 in __libc_start_main ../csu/libc-start.c:308
>     #4 0x40111d in _start
>     (/home/antipov/userspace-rcu/doc/examples/urcu-flavors/bp+0x40111d)
> 
> Is it critical for correctness, or speed, or whatever else?

As I remember this is mainly for speed, so it's not a show-stopper.

> To whom it may be interesting, some of (probably not all) alignment issues may
> be fixed
> with attached patch.

I agree on fixing this, but I recommend a different approach:

Change:

struct registry_chunk {
        size_t data_len;                /* data length */
        size_t used;                    /* amount of data used */
        struct cds_list_head node;      /* chunk_list node */
        char data[];
};

for:

struct registry_chunk {
        size_t nr_readers;              /* number of readers */
        size_t used;                    /* amount of data used */
        struct cds_list_head node;      /* chunk_list node */
        struct urcu_bp_reader readers[];
};

And adapt all the readers allocation scheme within urcu-bp to work on
"readers" elements rather than bytes.

By doing so, struct registry_chunk will adapt to have the proper alignment.

Thanks,

Mathieu

> 
> Dmitry
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
