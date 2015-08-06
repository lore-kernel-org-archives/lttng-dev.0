From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: 32-bit application crash
Date: Thu, 06 Aug 2015 14:29:44 -0400
Message-ID: <55C3A798.4050801__21360.1180621938$1438885909$gmane$org@efficios.com>
References: <CACh_V55XxDDx3rRyGr53XVgqav66SyyJU21YiezyXeUS_p6vKg@mail.gmail.com>
 <CACh_V54wXzXj-=yUK-7uta9f4DDnk1OTS0cyFbA1-mupzYALwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1ZNPvM-000658-TW
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 14:29:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 73494340470
 for <lttng-dev@lists.lttng.org>; Thu,  6 Aug 2015 18:29:47 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id VcSpmzfoXtVB for <lttng-dev@lists.lttng.org>;
 Thu,  6 Aug 2015 18:29:46 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 16778340477
 for <lttng-dev@lists.lttng.org>; Thu,  6 Aug 2015 18:29:46 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id B5MfotYE7BoN for <lttng-dev@lists.lttng.org>;
 Thu,  6 Aug 2015 18:29:45 +0000 (UTC)
Received: from [172.16.0.141] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id AA0CF340470
 for <lttng-dev@lists.lttng.org>; Thu,  6 Aug 2015 18:29:45 +0000 (UTC)
In-Reply-To: <CACh_V54wXzXj-=yUK-7uta9f4DDnk1OTS0cyFbA1-mupzYALwQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Jam/Anand(?)

Can you reproduce this against lttng 2.7 or master (ust/tools) ?

Thanks


On 2015-08-06 01:11 PM, jamie explorer wrote:
> Hi All,
> i looked into this further, generated .c file with expanded macros for 
> debugging
> Some of the function pointer are not populated correctly.
> as i mentioned this issue is only seen using g++ compiler and not seen 
> with gcc
>
> please see the following GDB analysis:
>
>
> (gdb) bt
>
> #0  0x00000000 in ?? ()
> #1  0x080490a0 in __event_probe__sample_tracepoint___message 
> (__tp_data=0x80512d0,
>     text=0x804ca64 "Hello World\n") at sample_tracepoint.c:8567
>
> #2  0x0804ba23 in __tracepoint_cb_sample_tracepoint___message (
>     text=0x804ca64 "Hello World\n")
>     at /build/home/jam/gentp/src/sample.c:4026
> #3  main (argc=1, argv=0xffffdd74)
>     at /build/home/jam/gentp/src/sample.c:4731
>
> ****bc_runtime->filter* --- is not populated correctly, because of 
> which it crashes
> *(gdb) frame 1*
> #1  0x080490a0 in __event_probe__sample_tracepoint___message 
> (__tp_data=0x80512d0,
>     text=0x804ca64 "Hello World\n") at sample_tracepoint.c:8567
> 8567     if (__builtin_expect(!!(*bc_runtime->filter*(bc_runtime, 
> __stackvar.__filter_stack_data) & LTTNG_FILTER_RECORD_FLAG), 0))
>
>
> *(gdb) list*
> 8562     (__stackvar.__filter_stack_data, __tp_data,text);
> 8563     for (bc_runtime = ((__typeof__(*bc_runtime) *) ((char *) 
> ((reinterpret_cast<__typeof__((&__event->bytecode_runtime_head)->next)>(tracepoint_dlopen.rcu_dereference_sym_bp((reinterpret_cast<void 
> *>((&__event->bytecode_runtime_head)->next)))))) - (unsigned long) 
> (&((__typeof__(*bc_runtime) *) 0)->node)));
> 8564     &bc_runtime->node != (&__event->bytecode_runtime_head);
> 8565     bc_runtime = ((__typeof__(*bc_runtime) *) ((char *) 
> ((reinterpret_cast<__typeof__(bc_runtime->node.next)>(tracepoint_dlopen.rcu_dereference_sym_bp((reinterpret_cast<void 
> *>(bc_runtime->node.next)))))) - (unsigned long) 
> (&((__typeof__(*bc_runtime) *) 0)->node))))
> 8566     {
> *8567     if (__builtin_expect(!!(bc_runtime->filter(bc_runtime, 
> __stackvar.__filter_stack_data) & LTTNG_FILTER_RECORD_FLAG), 0))*
> 8568      __filter_record = 1;
> 8569     } if (__builtin_expect(!!(!__filter_record), 1)) return;
> 8570     } __event_len =
> 8571
>
>
> *printing bc_runtime shows filter is 0*
> *(gdb) p *bc_runtime *
> $3 = {bc = 0x0,* filter = 0x0,* link_failed = 0, node = {next = 
> 0x8051304,
>     prev = 0x8051304}}
>
>
> *also i see __event->bytecode_runtime_head->prev = 0x1 which may be wrong*
> *(gdb) p *__event*
> $4 = {id = 2, chan = 0xf6c047c0, enabled = 1,
>   desc = 0x804c700 <__event_desc___sample_tracepoint_message>, 
> _deprecated1 = 0x0,
>   ctx = 0x0, instrumentation = LTTNG_UST_TRACEPOINT, u = {<No data 
> fields>}, node = {
>     next = 0x8051344, prev = 0x0}, _deprecated2 = {next = 0x0, prev = 
> 0x0},
>   _deprecated3 = 0x0, _deprecated4 = 0, *bytecode_runtime_head = {next 
> = 0x8051304,
>     prev = 0x1}*, has_enablers_without_bytecode = 134552592, 
> enablers_ref_head = {
>     next = 0x8051c10, prev = 0x0}, hlist = {next = 0xf6c00ea0, prev = 
> 0x1},
>   registered = 89}
>
>
> I guess this structure is populated in tracepoint_register using urcu.
> Can anyone give me more pointers to debug this. Is this a known issue 
> and is there any patch which i can use
>
>
> /Jam
>
>
>
>
>
> On Mon, Aug 3, 2015 at 4:19 PM, jamie explorer 
> <jamieexplorer@gmail.com <mailto:jamieexplorer@gmail.com>> wrote:
>
>     Hi,
>     i am trying to run 32-bit application and see crash at the the
>     line where "tracepoint" is used.
>     i am using sample application given in
>     lttng-ust-2.6.0/doc/examples/gen-tp/
>     Not able to understand why the problem is seen only with 32-bit
>     apps? Can experts here pls help me fix this.
>
>     Have tried using ELF 32-bit app on Intel 80386 and PowerPC and see
>     the crash. Where as 64-bit applications have no problem.
>
>     following is the code where it crashes
>             for (i = 0; i < 100000; i++) {
>                     tracepoint(sample_tracepoint, message,  "Hello
>     World\n");  <<<< Crash here
>                     usleep(1);
>             }
>
>     GDB output:
>
>     #0  0x00000000 in ?? ()
>     #1  0x10001e54 in __event_probe__sample_tracepoint___message (
>         __tp_data=0x10015420, text=0x100034a4 "Hello World\n")
>         at /build/home/jam/gentp/sample_tracepoint.h:13
>     #2  0x10000b9c in __tracepoint_cb_sample_tracepoint___message (
>         text=0x100034a4 "Hello World\n")
>         at //build/home/jam/gentp/sample_tracepoint.h:13
>     #3  main (argc=<optimized out>, argv=<optimized out>)
>         at /build/home/jam/gentp/sample.c:115
>
>
>     i am running 32-bit version of lttng-sessiond
>     root@host:~# ps aux | grep lttng
>     root      4224  0.0  0.0  92212  1648 ?        Ssl  00:42   0:00
>     /usr/bin/lttng-sessiond --consumerd32-path
>     /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir
>     /usr/lib/ -b --no-kernel
>     root      4243  0.0  0.0  64212   956 ?        Sl   00:42   0:00
>     lttng-consumerd  -u --consumerd-cmd-sock
>     /var/run/lttng/ustconsumerd32/command --consumerd-err-sock
>     /var/run/lttng/ustconsumerd32/error --group tracing
>
>
>
>     /Jam
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios
