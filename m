From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?tracepoint_sys=5Fenter_and_sys=5Fexit?=
Date: Thu, 03 Apr 2014 18:06:37 +0800
Message-ID: <6de7a00d-2dbc-49c6-aa93-fa43866bbc26__17336.3649090335$1396522261$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-301.freemail.mail.aliyun.com ([110.75.46.1])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <zhenyu.ren@aliyun.com>) id 1WVeY1-0007LQ-Q7
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 06:07:11 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Hi,dev

  In lttng-modules-2.3.0/lttng-syscalls.c :

        ret = kabi_2635_tracepoint_probe_register("sys_enter",
                        (void *) syscall_entry_probe, chan);

       ret = kabi_2635_tracepoint_probe_register("sys_exit",
                        (void *) __event_probe__exit_syscall,

But where are these two tracepoints (hits) in kernel source code?

Thanks
zhenyu.ren
