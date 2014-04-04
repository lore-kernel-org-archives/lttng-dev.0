From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: tracepoint sys_enter and sys_exit
Date: Fri, 04 Apr 2014 08:26:52 -0400
Message-ID: <533EA50C.5010301__43539.8183799863$1396614498$gmane$org@gmail.com>
References: <6de7a00d-2dbc-49c6-aa93-fa43866bbc26@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1WW3D5-0000Wl-P4
 for lttng-dev@lists.lttng.org; Fri, 04 Apr 2014 08:27:04 -0400
Received: by mail-qg0-f47.google.com with SMTP id e89so776140qgf.34
 for <lttng-dev@lists.lttng.org>; Fri, 04 Apr 2014 05:26:58 -0700 (PDT)
In-Reply-To: <6de7a00d-2dbc-49c6-aa93-fa43866bbc26@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

If I remember correctly, for x86_64, the file is
arch/x86/kernel/entry_64.S and search for syscall_trace_enter.

Cheers,

Francis

Le 2014-04-03 06:06, zhenyu.ren a =E9crit :
> Hi,dev
>
>   In lttng-modules-2.3.0/lttng-syscalls.c :
>
>         ret =3D kabi_2635_tracepoint_probe_register("sys_enter",
>                         (void *) syscall_entry_probe, chan);
>
>        ret =3D kabi_2635_tracepoint_probe_register("sys_exit",
>                         (void *) __event_probe__exit_syscall,
>
> But where are these two tracepoints (hits) in kernel source code?
>
> Thanks
> zhenyu.ren
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
