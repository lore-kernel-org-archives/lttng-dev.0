From: =?GB2312?B?v9zP/urN?= <kxhdyx@gmail.com>
Subject: Why can't i install lttng-modules-kmp-trace rpm?
Date: Tue, 11 Sep 2012 14:44:01 +0800
Message-ID: <CAH3R=odbkByVnJy7KtHsgTAkBc_2omu3nVWjspVMjm2uDJ_y_w__29804.2474700653$1347345945$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1365099840=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <kxhdyx@gmail.com>) id 1TBKCd-0005Av-SW
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 02:44:08 -0400
Received: by vcbfl11 with SMTP id fl11so239101vcb.35
	for <lttng-dev@lists.lttng.org>; Mon, 10 Sep 2012 23:44:02 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1365099840==
Content-Type: multipart/alternative; boundary=047d7b677afa4a983804c967664c

--047d7b677afa4a983804c967664c
Content-Type: text/plain; charset=ISO-8859-1

I downloaded these rpms from:
http://download.opensuse.org/repositories/devel:/tools:/lttng/SLE_11_SP2/
Include: lttng-tools-2.0.3-1.1.x86_64.rpm
 liburcu-devel-0.7.3-1.1.x86_64.rpm       lttng-tools-2.0.3.tar.bz2
       liburcu0-0.7.3-1.1.x86_64.rpm
 lttng-tools-devel-2.0.3-1.1.x86_64.rpm
 lttng-ust-2.0.4-1.1.x86_64.rpm        babeltrace-1.0.0.rc4-1.1.x86_64.rpm
       babeltrace-devel-1.0.0.rc4-1.1.x86_64.rpm
 lttng-modules-2.0.4-1.1.src.rpm
lttng-ust-devel-2.0.4-1.1.x86_64.rpm
lttng-modules-kmp-default-2.0.4_3.0.13_0.27-1.1.x86_64.rpm
 urcu-docs-0.7.3-1.1.x86_64.rpm
 lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64.rpm   .

I can install all these rpms except this one:*
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64.rpm*. Can anyone help
me solve this?
 rpm -ivh lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64.rpm
warning: lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64.rpm: Header
V3 DSA signature: NOKEY, key ID 32567f38
error: Failed dependencies:
        kernel(trace:kernel_sched) = 99e1a28a02fcf93e is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:mm_slab) = 41ec84771cffa132 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_timer) = 423e9e985483e429 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:fs_pipe) = 93362caf20e7d178 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_panic) = 7737fe7a37eaa833 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:fs_open) = 93d537158f7206d3 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:arch_x86_kernel_x8664_ksyms_64) = 20a930ecfce90836 is
needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:vmlinux) = bc43b4188c6e39ac is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:mm_page_alloc) = 15949994327e24b4 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_printk) = 583f33f84f1e6f70 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_events_core) = 11ff0ab182b98514 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_kprobes) = 1af9e4fed0911559 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:mm_swap) = 0c127c7b0413b462 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_time) = b91606e281206d82 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_cpu) = aa72f1964aa3a83a is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_module) = 09015e13ab1a76db is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_workqueue) = 935a39c08f5e6a71 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:arch_x86_kernel_setup_percpu) = 1e35c1127e2872e6 is
needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:fs_anon_inodes) = 0293c39657d3900a is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:arch_x86_kernel_cpu_common) = 95de3588b03a487e is
needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:lib_bitmap) = 1bd5f25878fbbd41 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_time_timekeeping) = 80d2df62da4c5dfe is needed
by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_notifier) = 6397242c08a00e2f is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:mm_percpu) = 9b2dd7458bddd517 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:lib_uuid) = 4d6572de13cd1d91 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:fs_proc_proc) = 4892b3aeab273f95 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:net_core_dev) = a22e6b28924118a4 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_smp) = a9e07a77cb18ac0e is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:net_core_net_namespace) = 1649fc5fe111db92 is needed
by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_pid) = 9bdfa3eddb0f5b90 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_spinlock) = 54d2f29207dc84d4 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:fs_seq_file) = 51ac01ba7204b9a7 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_fork) = fb49e52bebfee7d1 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:arch_x86_kernel_paravirt) = bbbc793c79ac8606 is needed
by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_time_jiffies) = 0a1119a9d9ca3d67 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:fs_dcache) = 9de82f5ed77a3b8b is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:fs_dcache) = b3349160560caee2 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_mutex) = 6e60d96216b54f32 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:fs_file) = 0d187f43ec401899 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:arch_x86_mm_numa) = fec4d81d3e200eed is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_wait) = a8a7455479775eed is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:fs_file_table) = 3e2425c6e8c37533 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:net_ipv4_devinet) = 587ab6c4880180f6 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_tracepoint) = e653a58bd9b4c6bc is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_rcutree) = bb9ce712db2a1247 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:mm_util) = f362a46517fac8df is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_rwsem) = 7d1e7477de0d09d3 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_irq_irqdesc) = 0dd3e98de8c0f26b is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_trace_trace_irqsoff) = a03e17eae6467036 is
needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:kernel_kallsyms) = f7b9f9d69b15ce4b is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64
        kernel(trace:lib_kasprintf) = 49add60e50526694 is needed by
lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64

--047d7b677afa4a983804c967664c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I downloaded these rpms from:
<a href=3D"http://download.opensuse.org/repositories/devel:/tools:/lttng/SL=
E_11_SP2/">http://download.opensuse.org/repositories/devel:/tools:/lttng/SL=
E_11_SP2/</a><div>Include:=A0lttng-tools-2.0.3-1.1.x86_64.rpm =A0 =A0liburc=
u-devel-0.7.3-1.1.x86_64.rpm =A0 =A0 =A0 lttng-tools-2.0.3.tar.bz2 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0=A0 liburcu0-0.7.3-1.1.x86_64.rpm =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0lttng-tools-devel-2.0.3-1.1.x86_64.rpm =A0=A0 =A0 =A0 =A0 =
=A0lttng-ust-2.0.4-1.1.x86_64.rpm =A0 =A0 =A0 =A0babeltrace-1.0.0.rc4-1.1.x=
86_64.rpm =A0 =A0 =A0 =A0babeltrace-devel-1.0.0.rc4-1.1.x86_64.rpm =A0lttng=
-modules-2.0.4-1.1.src.rpm =A0 =A0 =A0 =A0 =A0 =A0 =A0 lttng-ust-devel-2.0.=
4-1.1.x86_64.rpm =A0 =A0 lttng-modules-kmp-default-2.0.4_3.0.13_0.27-1.1.x8=
6_64.rpm =A0 =A0 =A0 =A0 =A0 =A0urcu-docs-0.7.3-1.1.x86_64.rpm=A0 =A0 =A0 =
=A0 =A0 =A0 =A0lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64.rpm =A0=
 .</div>
<div><br></div><div>I can install all these rpms except this one:<b>lttng-m=
odules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64.rpm</b>. Can anyone help me s=
olve this?</div><div><div>=A0rpm -ivh lttng-modules-kmp-trace-2.0.4_3.0.13_=
0.27-1.1.x86_64.rpm</div>
<div>warning: lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64.rpm: Hea=
der V3 DSA signature: NOKEY, key ID 32567f38</div><div>error: Failed depend=
encies:</div><div>=A0 =A0 =A0 =A0 kernel(trace:kernel_sched) =3D 99e1a28a02=
fcf93e is needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</d=
iv>
<div>=A0 =A0 =A0 =A0 kernel(trace:mm_slab) =3D 41ec84771cffa132 is needed b=
y lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =A0 =
=A0 =A0 kernel(trace:kernel_timer) =3D 423e9e985483e429 is needed by lttng-=
modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:fs_pipe) =3D 93362caf20e7d178 is needed b=
y lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =A0 =
=A0 =A0 kernel(trace:kernel_panic) =3D 7737fe7a37eaa833 is needed by lttng-=
modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:fs_open) =3D 93d537158f7206d3 is needed b=
y lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =A0 =
=A0 =A0 kernel(trace:arch_x86_kernel_x8664_ksyms_64) =3D 20a930ecfce90836 i=
s needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:vmlinux) =3D bc43b4188c6e39ac is needed b=
y lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =A0 =
=A0 =A0 kernel(trace:mm_page_alloc) =3D 15949994327e24b4 is needed by lttng=
-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_printk) =3D 583f33f84f1e6f70 is ne=
eded by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =
=A0 =A0 =A0 kernel(trace:kernel_events_core) =3D 11ff0ab182b98514 is needed=
 by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_kprobes) =3D 1af9e4fed0911559 is n=
eeded by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0=
 =A0 =A0 =A0 kernel(trace:mm_swap) =3D 0c127c7b0413b462 is needed by lttng-=
modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_time) =3D b91606e281206d82 is need=
ed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =
=A0 =A0 =A0 kernel(trace:kernel_cpu) =3D aa72f1964aa3a83a is needed by lttn=
g-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_module) =3D 09015e13ab1a76db is ne=
eded by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =
=A0 =A0 =A0 kernel(trace:kernel_workqueue) =3D 935a39c08f5e6a71 is needed b=
y lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:arch_x86_kernel_setup_percpu) =3D 1e35c11=
27e2872e6 is needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64=
</div><div>=A0 =A0 =A0 =A0 kernel(trace:fs_anon_inodes) =3D 0293c39657d3900=
a is needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:arch_x86_kernel_cpu_common) =3D 95de3588b=
03a487e is needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</=
div><div>=A0 =A0 =A0 =A0 kernel(trace:lib_bitmap) =3D 1bd5f25878fbbd41 is n=
eeded by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_time_timekeeping) =3D 80d2df62da4c=
5dfe is needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div=
><div>=A0 =A0 =A0 =A0 kernel(trace:kernel_notifier) =3D 6397242c08a00e2f is=
 needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:mm_percpu) =3D 9b2dd7458bddd517 is needed=
 by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =A0 =
=A0 =A0 kernel(trace:lib_uuid) =3D 4d6572de13cd1d91 is needed by lttng-modu=
les-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:fs_proc_proc) =3D 4892b3aeab273f95 is nee=
ded by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =
=A0 =A0 =A0 kernel(trace:net_core_dev) =3D a22e6b28924118a4 is needed by lt=
tng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_smp) =3D a9e07a77cb18ac0e is neede=
d by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =A0=
 =A0 =A0 kernel(trace:net_core_net_namespace) =3D 1649fc5fe111db92 is neede=
d by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_pid) =3D 9bdfa3eddb0f5b90 is neede=
d by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =A0=
 =A0 =A0 kernel(trace:kernel_spinlock) =3D 54d2f29207dc84d4 is needed by lt=
tng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:fs_seq_file) =3D 51ac01ba7204b9a7 is need=
ed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =
=A0 =A0 =A0 kernel(trace:kernel_fork) =3D fb49e52bebfee7d1 is needed by ltt=
ng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:arch_x86_kernel_paravirt) =3D bbbc793c79a=
c8606 is needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</di=
v><div>=A0 =A0 =A0 =A0 kernel(trace:kernel_time_jiffies) =3D 0a1119a9d9ca3d=
67 is needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:fs_dcache) =3D 9de82f5ed77a3b8b is needed=
 by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =A0 =
=A0 =A0 kernel(trace:fs_dcache) =3D b3349160560caee2 is needed by lttng-mod=
ules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_mutex) =3D 6e60d96216b54f32 is nee=
ded by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =
=A0 =A0 =A0 kernel(trace:fs_file) =3D 0d187f43ec401899 is needed by lttng-m=
odules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:arch_x86_mm_numa) =3D fec4d81d3e200eed is=
 needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=
=A0 =A0 =A0 =A0 kernel(trace:kernel_wait) =3D a8a7455479775eed is needed by=
 lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:fs_file_table) =3D 3e2425c6e8c37533 is ne=
eded by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =
=A0 =A0 =A0 kernel(trace:net_ipv4_devinet) =3D 587ab6c4880180f6 is needed b=
y lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_tracepoint) =3D e653a58bd9b4c6bc i=
s needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=
=A0 =A0 =A0 =A0 kernel(trace:kernel_rcutree) =3D bb9ce712db2a1247 is needed=
 by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:mm_util) =3D f362a46517fac8df is needed b=
y lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=A0 =A0 =
=A0 =A0 kernel(trace:kernel_rwsem) =3D 7d1e7477de0d09d3 is needed by lttng-=
modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_irq_irqdesc) =3D 0dd3e98de8c0f26b =
is needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div=
>=A0 =A0 =A0 =A0 kernel(trace:kernel_trace_trace_irqsoff) =3D a03e17eae6467=
036 is needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
<div>=A0 =A0 =A0 =A0 kernel(trace:kernel_kallsyms) =3D f7b9f9d69b15ce4b is =
needed by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div><div>=
=A0 =A0 =A0 =A0 kernel(trace:lib_kasprintf) =3D 49add60e50526694 is needed =
by lttng-modules-kmp-trace-2.0.4_3.0.13_0.27-1.1.x86_64</div>
</div><div><br></div>

--047d7b677afa4a983804c967664c--


--===============1365099840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1365099840==--
