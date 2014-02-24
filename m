From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: Re: =?utf-8?q?epoll=5Fwait_reboot_kernel=3F?=
Date: Mon, 24 Feb 2014 17:36:36 +0800
Message-ID: <494972cb-79c7-4197-981c-d682306d585e__14353.0558598743$1393234655$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-318.freemail.mail.aliyun.com ([110.75.46.18])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zhenyu.ren@aliyun.com>) id 1WHrxt-0003I3-V7
	for lttng-dev@lists.lttng.org; Mon, 24 Feb 2014 04:36:50 -0500
References: c3d1fc94-92e2-43b3-af78-6315aaa7419d@aliyun.com,
	a860adc0-d68a-4a1e-bbd1-775c1cf652e9@aliyun.com
In-Reply-To: a860adc0-d68a-4a1e-bbd1-775c1cf652e9@aliyun.com
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>, "zhenyu.ren" <zhenyu.ren@aliyun.com>
List-Id: lttng-dev@lists.lttng.org

Oh,It seems not epoll related . I am using DBG/ERR() as debug way ,but this print-style method doesn't work as expected,so I mistake for epoll_wait. 
It seems gcc problem because if  I changed lib_ring_buffer_do_copy as the following,all  work well

#define lib_ring_buffer_do_copy(config, dest, src, len)         \
do {                                                            \
        size_t __len1 = (len);                                  \                              /*here , not __len=(len)*/
mdelay(0x135);\
        if (__builtin_constant_p(len))                          \
                memcpy(dest, src, __len1);                      \
        else                                                    \
                inline_memcpy(dest, src, __len1);               \
} while (0)

I disasembled lib_ring_buffer_write() and "vimdiff bad good" shows :
49c:       48 89 da                mov    %rbx,%rdx                                                            |       49c:       4c 89 f2                mov    %r14,%rdx

here rdx is the 3rd parameter to inline_memcpy().

Thanks
zhenyu.ren


>Hi,lttng-dev
>
 >  I am working on rhel6(2.6.32.220) and ust is working very well.But when I use lttng-modules (after "lttng start"),the kernel reboots immediately >without any message output to console. 
>
>  It took me some days finding out what results in reboot. I shortcut __event_probe__##_name() before _tstruct but kernel still reboot(So what left is  >metadata_printf).If I comment out "mask |= POLLIN" in lttng_metadata_ring_buffer_poll() ,kernel do not reboot. What I find out is before reboot the >callchain of  lttng-consumerd thread is consumer_thread_metadata_poll()->lttng_poll_wait(wait for metadata stream)->compat_epoll_wait().
>
> I want to use poll instead as epoll in lttng-tools ,I changed lttng-tools configure file to not use epoll(undef HAVE_EPOLL),but "lttng enable-event -a -k >"failed :(Do I miss anything?)
>#lttng enable-event -a -k
>DEBUG1 [17837/18080]: Wait for client response (in thread_manage_clients() at main.c:3709)
>DEBUG1 [17837/18080]: Receiving data from client ... (in thread_manage_clients() at main.c:3754)
>DEBUG1 [17837/18080]: Nothing recv() from client... continuing (in thread_manage_clients() at main.c:3758)
>DEBUG1 [17837/18080]: Clean command context structure (in clean_command_ctx() at main.c:535)
>DEBUG1 [17837/18080]: Accepting client command ... (in thread_manage_clients() at main.c:3667)
>DEBUG1 [17837/18080]: Wait for client response (in thread_manage_clients() at main.c:3709)
>DEBUG1 [17837/18080]: Receiving data from client ... (in thread_manage_clients() at main.c:3754)
>DEBUG1 [17837/18080]: Processing client command 7 (in process_client_msg() at main.c:2579)
>DEBUG1 [17837/18080]: Getting session k-test by name (in process_client_msg() at main.c:2656)
>DEBUG1 [17837/18080]: Creating kernel session (in create_kernel_session() at main.c:2495)
>DEBUG3 [17837/18080]: Created hashtable size 4 at 0x669410 of type 1 (in lttng_ht_new() at hashtable.c:112)
>DEBUG1 [17837/18080]: Kernel session created (fd: 21) (in kernel_create_session() at kernel.c:109)
>DEBUG3 [17837/18080]: Copying tracing session consumer output in kernel session (in copy_session_consumer() at main.c:2393)
>DEBUG3 [17837/18080]: Created hashtable size 4 at 0x66a750 of type 1 (in lttng_ht_new() at hashtable.c:112)
>DEBUG3 [17837/18080]: Copy session consumer subdir /kernel (in copy_session_consumer() at main.c:2428)
>DEBUG3 [17837/18080]: mkdir() recursive /root/lttng-traces/k-test-20140222-131335 with mode 504 for uid 0 and gid 0 (in run_as_mkdir_recursive() at >runas.c:310)
>DEBUG1 [17837/18080]: Using run_as_clone (in run_as() at runas.c:293)
>lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup: Assertion `pollfd == ht_cleanup_pipe[0]' failed.
>
>  It seems lttng-tools  in ubuntu 12.04 is using poll,isnt it?
>
 > Does anyone have any suggestions to me ?

>PS:.lttng(ust/module/tool) version is 2.3.0 and urcu version is 0.8
