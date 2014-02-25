From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: Re: =?utf-8?q?epoll=5Fwait_reboot_kernel=3F?=
Date: Tue, 25 Feb 2014 14:01:30 +0800
Message-ID: <6cab5c14-9ef8-4a13-a134-a4b628ddc35d__28901.2685687796$1393308159$gmane$org@aliyun.com>
References: <c3d1fc94-92e2-43b3-af78-6315aaa7419d@aliyun.com,
	a860adc0-d68a-4a1e-bbd1-775c1cf652e9@aliyun.com>
	<494972cb-79c7-4197-981c-d682306d585e@aliyun.com>,
	743353902.29447.1393254533122.JavaMail.zimbra@efficios.com
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-320.freemail.mail.aliyun.com ([110.75.46.20])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zhenyu.ren@aliyun.com>) id 1WIB5K-0004YD-V7
	for lttng-dev@lists.lttng.org; Tue, 25 Feb 2014 01:01:47 -0500
In-Reply-To: 743353902.29447.1393254533122.JavaMail.zimbra@efficios.com
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

>Which gcc version do you use ?
$gcc --version
gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-46)

I disassembed lib_ring_buffer_write() and focused on how it calles lib_ring_buffer_do_copy(indeed inline_memcpy)

void lib_ring_buffer_write(const struct lib_ring_buffer_config *config,
                           struct lib_ring_buffer_ctx *ctx,
                           const void *src, size_t len)
{
        struct lib_ring_buffer_backend *bufb = &ctx->buf->backend;
        struct channel_backend *chanb = &ctx->chan->backend;
        size_t sbidx, index;
        size_t offset = ctx->buf_offset;
        ssize_t pagecpy;
        struct lib_ring_buffer_backend_pages *rpages;
        unsigned long sb_bindex, id;
        if (unlikely(!len))
                return;
        offset &= chanb->buf_size - 1;
        sbidx = offset >> chanb->subbuf_size_order;
        index = (offset & (chanb->subbuf_size - 1)) >> PAGE_SHIFT;
        pagecpy = min_t(size_t, len, (-offset) & ~PAGE_MASK);
        id = bufb->buf_wsb[sbidx].id;
        sb_bindex = subbuffer_id_get_index(config, id);
        rpages = bufb->array[sb_bindex];
        CHAN_WARN_ON(ctx->chan,
                     config->mode == RING_BUFFER_OVERWRITE
                     && subbuffer_id_is_noref(config, id));
        if (likely(pagecpy == len))
                lib_ring_buffer_do_copy(config,
                                        rpages->p[index].virt
                                            + (offset & ~PAGE_MASK),
                                        src, len);
        else
                _lib_ring_buffer_write(bufb, offset, src, len, 0);
        ctx->buf_offset += len;
}
00000000000003a0 <lib_ring_buffer_write>:
     3a0:       55                      push   %rbp
     3a1:       48 89 e5                mov    %rsp,%rbp
     3a4:       48 83 ec 40             sub    $0x40,%rsp
     3a8:       48 89 5d d8             mov    %rbx,0xffffffffffffffd8(%rbp)
     3ac:       4c 89 65 e0             mov    %r12,0xffffffffffffffe0(%rbp)
     3b0:       4c 89 6d e8             mov    %r13,0xffffffffffffffe8(%rbp)
     3b4:       4c 89 75 f0             mov    %r14,0xfffffffffffffff0(%rbp)
     3b8:       4c 89 7d f8             mov    %r15,0xfffffffffffffff8(%rbp)
     3bc:       e8 00 00 00 00          callq  3c1 <lib_ring_buffer_write+0x21>
     3c1:       49 89 f5                mov    %rsi,%r13                                rsi/r13->               ctx
     3c4:       48 85 c9                test   %rcx,%rcx                                rcx->                   len
     3c7:       48 89 55 c8             mov    %rdx,0xffffffffffffffc8(%rbp)            rdx/c8->                src
     3cb:       49 89 cc                mov    %rcx,%r12                                rcx/r12->               len
     3ce:       48 8b 76 20             mov    0x20(%rsi),%rsi                          rsi->                   ctx->buf
     3d2:       4d 8b 45 00             mov    0x0(%r13),%r8                            r8->                    ctx->chan
     3d6:       49 8b 55 30             mov    0x30(%r13),%rdx                          rdx->                   offset = ctx->buf_offset
     3da:       0f 84 a5 00 00 00       je     485 <lib_ring_buffer_write+0xe5>         if(!len)  return
     3e0:       49 8b 58 10             mov    0x10(%r8),%rbx                           rbx->                   ctx->chan->backend
     3e4:       49 8d 40 10             lea    0x10(%r8),%rax                           rax->                   *chanb = &ctx->chan->backend
     3e8:       4c 8d 76 28             lea    0x28(%rsi),%r14                          r14->                   *bufb = &ctx->buf->backend
     3ec:       48 83 eb 01             sub    $0x1,%rbx                                rbx->                   chanb->buf_size - 1
     3f0:       48 21 d3                and    %rdx,%rbx                                rbx->                   offset &= chanb->buf_size -1
     3f3:       48 8b 50 08             mov    0x8(%rax),%rdx                           rdx->                   chanb->subbuf_size
     3f7:       48 89 55 d0             mov    %rdx,0xffffffffffffffd0(%rbp)            d0->                    chanb->subbuf_size
     3fb:       8b 48 10                mov    0x10(%rax),%ecx                          ecx->                   chanb->subbuf_size_order
     3fe:       48 89 da                mov    %rbx,%rdx                                rdx->                   offset
     401:       48 8b 46 28             mov    0x28(%rsi),%rax                          rax->                   bufb = &ctx->buf->backen
     405:       48 d3 ea                shr    %cl,%rdx                                 rdx->                   sbidx = offset >> chanb->subbuf_size_orde
     408:       48 8b 0c d0             mov    (%rax,%rdx,8),%rcx                       rcx->                   id = bufb->buf_wsb[sbidx].id
     40c:       8b 47 08                mov    0x8(%rdi),%eax                           eax->                   config->mode
     40f:       85 c0                   test   %eax,%eax                                CHAN_WARN_ON(... (config->mode == RING_BUFFER_OVERWRITE)...)
     411:       0f 85 89 00 00 00       jne    4a0 <lib_ring_buffer_write+0x100>
     417:       49 8b 46 10             mov    0x10(%r14),%rax                          rax->                   bufb->array
     41b:       48 89 ca                mov    %rcx,%rdx                                rdx->                   id
     41e:       83 e2 ff                and    $0xffffffffffffffff,%edx
     421:       4c 8b 3c d0             mov    (%rax,%rdx,8),%r15                       r15->                   rpages = bufb->array[sb_binde
     425:       48 b8 00 00 00 00 01    mov    $0x100000000,%rax                        rax->                   SB_ID_NOREF_MASK
     42c:       00 00 00
     42f:       48 85 c8                test   %rcx,%rax                                id & SB_ID_NOREF_MASK
     432:       0f 95 c0                setne  %al
     435:       0f b6 c0                movzbl %al,%eax
     438:       48 85 c0                test   %rax,%rax                                if(config->mode==RING_BUFFER_OVERWRITE && subbuffer_id_is_noref(config,id))
     43b:       75 6f                   jne    4ac <lib_ring_buffer_write+0x10c>
     43d:       48 89 d8                mov    %rbx,%rax                                rax->                   offset
     440:       48 f7 d8                neg    %rax                                     rax->                   -offset
     443:       25 ff 0f 00 00          and    $0xfff,%eax                              eax->                   (-offset) & ~PAGE_MASK
     448:       49 39 c4                cmp    %rax,%r12                                cmp(len,(-offset) & ~PAGE_MASK)
     44b:       49 0f 46 c4             cmovbe %r12,%rax                                rax->                   pagecpy = min_t(size_t, len, (-offset) & ~PAGE_MASK)
     44f:       4c 39 e0                cmp    %r12,%rax                                if(pagecpy == len)
     452:       75 72                   jne    4c6 <lib_ring_buffer_write+0x126>        jmp to call _lib_ring_buffer_write()
     454:       48 8b 45 d0             mov    0xffffffffffffffd0(%rbp),%rax            rax->                   chanb->subbuf_size
     458:       48 8b 75 c8             mov    0xffffffffffffffc8(%rbp),%rsi            rsi->                   src
     45c:       48 83 e8 01             sub    $0x1,%rax                                rax->                   chanb->subbuf_size - 1
     460:       48 21 d8                and    %rbx,%rax                                rax->                   offset & (chanb->subbuf_size - 1)
     463:       81 e3 ff 0f 00 00       and    $0xfff,%ebx                              ebx->                   offset & ~PAGE_MASK
     469:       48 c1 e8 0c             shr    $0xc,%rax                                rax->                   index=(offset&(chanb->subbuf_size-1))>>PAGE_SHIFT
     46d:       48 c1 e0 04             shl    $0x4,%rax                                rax->                   index
     471:       4a 03 5c 38 20          add    0x20(%rax,%r15,1),%rbx                   rbx->                   rpages->p[index].virt+ (offset & ~PAGE_MASK)
     476:       48 89 da                mov    %rbx,%rdx                                rdx->                   SHOULD BE inline_memcpy() the 3rd parameter:len
     479:       48 89 df                mov    %rbx,%rdi                                rdi->                   1st parameter
     47c:       e8 00 00 00 00          callq  481 <lib_ring_buffer_write+0xe1>         call inline_memcpy(dst,src,len)
     481:       4d 01 65 30             add    %r12,0x30(%r13)                          ctx->buf_offset += len(r12)
     485:       48 8b 5d d8             mov    0xffffffffffffffd8(%rbp),%rbx
     489:       4c 8b 65 e0             mov    0xffffffffffffffe0(%rbp),%r12
     48d:       4c 8b 6d e8             mov    0xffffffffffffffe8(%rbp),%r13
     491:       4c 8b 75 f0             mov    0xfffffffffffffff0(%rbp),%r14
     495:       4c 8b 7d f8             mov    0xfffffffffffffff8(%rbp),%r15
     499:       c9                      leaveq
     49a:       c3                      retq
     49b:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
     4a0:       49 8b 46 10             mov    0x10(%r14),%rax                          rax->                   bufb->array
     4a4:       4c 8b 3c c8             mov    (%rax,%rcx,8),%r15                       r15->                   rpages = bufb->array[sb_bindex]
     4a8:       31 c0                   xor    %eax,%eax                                eax->                   0
     4aa:       eb 8c                   jmp    438 <lib_ring_buffer_write+0x98>         .......
     4ac:       f0 41 ff 00             lock incl (%r8)                                 atomic_inc(&__chan->record_disabled
     4b0:       be 6e 00 00 00          mov    $0x6e,%esi
     4b5:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
     4bc:       e8 00 00 00 00          callq  4c1 <lib_ring_buffer_write+0x121>        WARN_ON(1);
     4c1:       e9 77 ff ff ff          jmpq   43d <lib_ring_buffer_write+0x9d>         ....... jmp to if (pagecpy == len)
     4c6:       48 8b 55 c8             mov    0xffffffffffffffc8(%rbp),%rdx            rdx->                   src
     4ca:       45 31 c0                xor    %r8d,%r8d                                r8d->                   0
     4cd:       4c 89 e1                mov    %r12,%rcx                                r12/rcx->               len
     4d0:       48 89 de                mov    %rbx,%rsi                                rbx/rsi->               offset
     4d3:       4c 89 f7                mov    %r14,%rdi                                r14/rdi->               bufb
     4d6:       e8 00 00 00 00          callq  4db <lib_ring_buffer_write+0x13b>        _lib_ring_buffer_write(bufb, offset, src, len, 0);
     4db:       eb a4                   jmp    481 <lib_ring_buffer_write+0xe1>         ...... jmp to ctx->buf_offset += len and return


     All difference with good case is also where I am insterested in:

bad case:
     45c:       48 83 e8 01             sub    $0x1,%rax                                rax->                   chanb->subbuf_size - 1
     460:       48 21 d8                and    %rbx,%rax                                rax->                   offset & (chanb->subbuf_size - 1)
     463:       81 e3 ff 0f 00 00       and    $0xfff,%ebx                              ebx->                   offset & ~PAGE_MASK
     469:       48 c1 e8 0c             shr    $0xc,%rax                                rax->                   index=(offset&(chanb->subbuf_size-1))>>PAGE_SHIFT
     46d:       48 c1 e0 04             shl    $0x4,%rax                                rax->                   index
     471:       4a 03 5c 38 20          add    0x20(%rax,%r15,1),%rbx                   rbx->                   rpages->p[index].virt+ (offset & ~PAGE_MASK)
     476:       48 89 da                mov    %rbx,%rdx                                rdx->                   SHOULD BE inline_memcpy() the 3rd parameter:len
     479:       48 89 df                mov    %rbx,%rdi                                rdi->                   1st parameter
     47c:       e8 00 00 00 00          callq  481 <lib_ring_buffer_write+0xe1>         call inline_memcpy(dst,src,len)


good case:
     45c:       4c 89 e2                mov    %r12,%rdx                                r12/rdx->       len
     45f:       48 83 e8 01             sub    $0x1,%rax                                rax->           chanb->subbuf_size - 1
     463:       48 21 d8                and    %rbx,%rax                                rax->           offset & (chanb->subbuf_size - 1)
     466:       81 e3 ff 0f 00 00       and    $0xfff,%ebx                              ebx->           offset & ~PAGE_MASK
     46c:       48 c1 e8 0c             shr    $0xc,%rax                                rax->           index=(offset&(chanb->subbuf_size-1))>>PAGE_SHIFT
     470:       48 c1 e0 04             shl    $0x4,%rax                                rax->           index
     474:       4a 03 5c 38 20          add    0x20(%rax,%r15,1),%rbx                   rbx->           rpages->p[index].virt+ (offset & ~PAGE_MASK)
     479:       48 89 df                mov    %rbx,%rdi                                rdi->           dst , the 1st parameter of inline_memcpy(dst,src,len)
     47c:       e8 00 00 00 00          callq  481 <lib_ring_buffer_write+0xe1>         call inline_memcpy(dst,src,len)

In good case, at line 45c, rdx ,which is the 3rd parameter of inline_memcpy(dst,src,len), comes from  %r12 that is len.However,in bad case,at line 476, rdx comes from rbx that is the 1st parameter of inline_memcpy(dst,src,len). So you can image what will happen if len is too large.

I don't know why GCC produce the wrong code.Does anyone has any clue?

Thanks
zhenyu.ren


----- Original Message -----
> From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
> To: "lttng-dev" <lttng-dev@lists.lttng.org>, "zhenyu.ren" <zhenyu.ren@aliyun.com>
> Sent: Monday, February 24, 2014 4:36:36 AM
> Subject: Re: [lttng-dev] epoll_wait reboot kernel?
> 
> Oh,It seems not epoll related . I am using DBG/ERR() as debug way ,but this
> print-style method doesn't work as expected,so I mistake for epoll_wait.
> It seems gcc problem because if  I changed lib_ring_buffer_do_copy as the
> following,all  work well
> 
> #define lib_ring_buffer_do_copy(config, dest, src, len)         \
> do {                                                            \
>         size_t __len1 = (len);                                  \
>         /*here , not __len=(len)*/
> mdelay(0x135);\
>         if (__builtin_constant_p(len))                          \
>                 memcpy(dest, src, __len1);                      \
>         else                                                    \
>                 inline_memcpy(dest, src, __len1);               \
> } while (0)
> 
> I disasembled lib_ring_buffer_write() and "vimdiff bad good" shows :
> 49c:       48 89 da                mov    %rbx,%rdx
> |       49c:
> 4c 89 f2                mov    %r14,%rdx
> 
> here rdx is the 3rd parameter to inline_memcpy().
> 
> Thanks
> zhenyu.ren
> 
> 
> >Hi,lttng-dev
> >
>  >  I am working on rhel6(2.6.32.220) and ust is working very well.But when I
>  >  use lttng-modules (after "lttng start"),the kernel reboots immediately
>  >  >without any message output to console.
> >
> >  It took me some days finding out what results in reboot. I shortcut
> >  __event_probe__##_name() before _tstruct but kernel still reboot(So what
> >  left is  >metadata_printf).If I comment out "mask |= POLLIN" in
> >  lttng_metadata_ring_buffer_poll() ,kernel do not reboot. What I find out
> >  is before reboot the >callchain of  lttng-consumerd thread is
> >  consumer_thread_metadata_poll()->lttng_poll_wait(wait for metadata
> >  stream)->compat_epoll_wait().
> >
> > I want to use poll instead as epoll in lttng-tools ,I changed lttng-tools
> > configure file to not use epoll(undef HAVE_EPOLL),but "lttng enable-event
> > -a -k >"failed :(Do I miss anything?)
> >#lttng enable-event -a -k
> >DEBUG1 [17837/18080]: Wait for client response (in thread_manage_clients()
> >at main.c:3709)
> >DEBUG1 [17837/18080]: Receiving data from client ... (in
> >thread_manage_clients() at main.c:3754)
> >DEBUG1 [17837/18080]: Nothing recv() from client... continuing (in
> >thread_manage_clients() at main.c:3758)
> >DEBUG1 [17837/18080]: Clean command context structure (in
> >clean_command_ctx() at main.c:535)
> >DEBUG1 [17837/18080]: Accepting client command ... (in
> >thread_manage_clients() at main.c:3667)
> >DEBUG1 [17837/18080]: Wait for client response (in thread_manage_clients()
> >at main.c:3709)
> >DEBUG1 [17837/18080]: Receiving data from client ... (in
> >thread_manage_clients() at main.c:3754)
> >DEBUG1 [17837/18080]: Processing client command 7 (in process_client_msg()
> >at main.c:2579)
> >DEBUG1 [17837/18080]: Getting session k-test by name (in
> >process_client_msg() at main.c:2656)
> >DEBUG1 [17837/18080]: Creating kernel session (in create_kernel_session() at
> >main.c:2495)
> >DEBUG3 [17837/18080]: Created hashtable size 4 at 0x669410 of type 1 (in
> >lttng_ht_new() at hashtable.c:112)
> >DEBUG1 [17837/18080]: Kernel session created (fd: 21) (in
> >kernel_create_session() at kernel.c:109)
> >DEBUG3 [17837/18080]: Copying tracing session consumer output in kernel
> >session (in copy_session_consumer() at main.c:2393)
> >DEBUG3 [17837/18080]: Created hashtable size 4 at 0x66a750 of type 1 (in
> >lttng_ht_new() at hashtable.c:112)
> >DEBUG3 [17837/18080]: Copy session consumer subdir /kernel (in
> >copy_session_consumer() at main.c:2428)
> >DEBUG3 [17837/18080]: mkdir() recursive
> >/root/lttng-traces/k-test-20140222-131335 with mode 504 for uid 0 and gid 0
> >(in run_as_mkdir_recursive() at >runas.c:310)
> >DEBUG1 [17837/18080]: Using run_as_clone (in run_as() at runas.c:293)
> >lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup: Assertion `pollfd ==
> >ht_cleanup_pipe[0]' failed.
> >
> >  It seems lttng-tools  in ubuntu 12.04 is using poll,isnt it?
> >
>  > Does anyone have any suggestions to me ?
> 
> >PS:.lttng(ust/module/tool) version is 2.3.0 and urcu version is 0.8
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
