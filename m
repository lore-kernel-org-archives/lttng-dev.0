From: Ravi Inder Singh <raviinder@gmail.com>
Subject: Re: In Redhat 7.1 kmod-lttng-modules is not installed
Date: Wed, 6 Jul 2016 12:22:41 -0400
Message-ID: <CA+=s6BbTSLRR1E9ab+wwtN9jBDiZG5ybhoU4_HgEF+uUkeWu3A__42624.5594201193$1467822204$gmane$org@mail.gmail.com>
References: <CA+=s6Bag3Pz6FkbLAmu2BEC_wbpC1ON=qrjvF=G6iVdd1N8NyQ@mail.gmail.com>
 <858964754.39767.1466176115372.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0461152961411716189=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id E9F97A3265
 for <lttng-dev@lists.lttng.org>; Wed,  6 Jul 2016 16:23:01 +0000 (UTC)
Received: by mail-yw0-f193.google.com with SMTP id f75so11799267ywb.3
 for <lttng-dev@lists.lttng.org>; Wed, 06 Jul 2016 09:23:02 -0700 (PDT)
In-Reply-To: <858964754.39767.1466176115372.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0461152961411716189==
Content-Type: multipart/alternative; boundary=94eb2c0649b2ac25280536f9fbdc

--94eb2c0649b2ac25280536f9fbdc
Content-Type: text/plain; charset=UTF-8

Hi Michael,
     Kernel version used is :- Linux 3.10.0-229.el7.x86_64 x86_64
      Redahat version 7.1


      I compiled source package against my kernel it gives me following
Warning "Kernel ABI". Doees this effect my lttng-modules for getting
intsalld??


nm:
/root/rpmbuild/BUILDROOT/lttng-modules-2.8.0-1.el7.x86_64/lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/tests/clock-plugin/lttng-clock-plugin-test.ko:
No symbols
extracting debug info from
/root/rpmbuild/BUILDROOT/lttng-modules-2.8.0-1.el7.x86_64/lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/tests/probes/lttng-test.ko
nm:
/root/rpmbuild/BUILDROOT/lttng-modules-2.8.0-1.el7.x86_64/lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/tests/probes/lttng-test.ko:
No symbols
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lib/lttng-lib-ring-buffer.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-clock.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-ring-buffer-client-discard.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-ring-buffer-client-mmap-discard.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-ring-buffer-client-mmap-overwrite.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-ring-buffer-client-overwrite.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-ring-buffer-metadata-client.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-ring-buffer-metadata-mmap-client.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-statedump.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-tracer.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-ftrace.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-kprobes.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-kretprobes.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-block.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-compaction.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-irq.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-jbd2.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-kmem.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-kvm.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-module.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-napi.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-net.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-power.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-printk.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-random.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-rcu.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-rpm.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-sched.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-scsi.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-signal.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-skb.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-sock.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-statedump.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-sunrpc.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-timer.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-udp.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-vmscan.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-workqueue.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-writeback.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-x86-exceptions.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-x86-irq-vectors.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/tests/clock-plugin/lttng-clock-plugin-test.ko.debug"
is not a shared library
dwz:
"./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/tests/probes/lttng-test.ko.debug"
is not a shared library
dwz: Too few files for multifile optimization
/usr/lib/rpm/sepdebugcrcfix: Updated 0 CRC32s, 43 CRC32s did match.
2620 blocks
+ /usr/lib/rpm/check-buildroot
+ /usr/lib/rpm/redhat/brp-compress
+ /usr/lib/rpm/redhat/brp-strip-static-archive /usr/bin/strip
+ /usr/lib/rpm/brp-python-bytecompile /usr/bin/python 1
+ /usr/lib/rpm/redhat/brp-python-hardlink
+ /usr/lib/rpm/redhat/brp-java-repack-jars
Processing files: kmod-lttng-modules-2.8.0-1.el7.x86_64
Finding  Provides: /usr/lib/rpm/redhat/find-provides
Finding  Requires(interp):
Finding  Requires(rpmlib):
Finding  Requires(verify):
Finding  Requires(pre):
Finding  Requires(post):
Finding  Requires(preun):
Finding  Requires(postun):
Finding  Requires(pretrans):
Finding  Requires(posttrans):
Finding  Requires: /usr/lib/rpm/redhat/find-requires

********************************************************************************
*********************** KERNEL ABI COMPATIBILITY WARNING
***********************
********************************************************************************
The kernel ABI reference files (provided by kabi-whitelists) were not found.
No compatibility check was performed. Please install the kABI reference
files
and rebuild if you would like to verify compatibility with kernel ABI.

Provides: kernel-modules >= 3.10.0-229.el7.x86_64 lttng-modules-kmod =
2.8.0-1.el7 kmod-lttng-modules = 2.8.0-1.el7 kmod-lttng-modules(x86-64) =
2.8.0-1.el7 ksym(channel_create) = 0xa7997152 ksym(channel_destroy) =
0x4cb4c7f1 ksym(channel_get_next_record) = 0xf604aa9c
ksym(channel_get_ring_buffer) = 0xff8d9824 ksym(channel_iterator_open) =
0x045cc6f5 ksym(channel_iterator_release) = 0x42c43c29
ksym(channel_payload_file_operations) = 0x0adb1633 ksym(channel_reset) =
0x51094d69 ksym(lib_ring_buffer_clear_quiescent_channel) = 0x77c58966
ksym(lib_ring_buffer_compat_ioctl) = 0x808f7bc3
ksym(_lib_ring_buffer_copy_from_user_inatomic) = 0x0e15057d
ksym(__lib_ring_buffer_copy_to_user) = 0xbe7c2c7e
ksym(lib_ring_buffer_file_operations) = 0x7fd7bb44
ksym(lib_ring_buffer_get_next_record) = 0x988ea562
ksym(lib_ring_buffer_get_subbuf) = 0x9b0a88c1 ksym(lib_ring_buffer_ioctl) =
0x8e28d608 ksym(lib_ring_buffer_iterator_open) = 0x4ca1462a
ksym(lib_ring_buffer_iterator_release) = 0xce8713f1
ksym(_lib_ring_buffer_memset) = 0x587f6477 ksym(lib_ring_buffer_mmap) =
0xd50b19d8 ksym(lib_ring_buffer_move_consumer) = 0xbad2c526
ksym(lib_ring_buffer_nesting) = 0x2776a3e5
ksym(lib_ring_buffer_offset_address) = 0xd42e81f1
ksym(lib_ring_buffer_open) = 0x6440a359 ksym(lib_ring_buffer_open_read) =
0x84e26fbb ksym(lib_ring_buffer_payload_file_operations) = 0x3fd0207d
ksym(lib_ring_buffer_poll) = 0xd5ffe503 ksym(lib_ring_buffer_put_subbuf) =
0x27f7c765 ksym(lib_ring_buffer_read) = 0x20e07ac8
ksym(lib_ring_buffer_read_cstr) = 0x98e54af8
ksym(lib_ring_buffer_read_get_pfn) = 0x6df83d91
ksym(lib_ring_buffer_read_offset_address) = 0xdfb7ac9e
ksym(lib_ring_buffer_release) = 0xe361ceca
ksym(lib_ring_buffer_release_read) = 0x849cd194
ksym(lib_ring_buffer_reserve_slow) = 0x10ccb673 ksym(lib_ring_buffer_reset)
= 0x07e6658d ksym(lib_ring_buffer_set_quiescent_channel) = 0x5bda1b1e
ksym(lib_ring_buffer_snapshot) = 0x4336af02
ksym(lib_ring_buffer_splice_read) = 0x6522d6ed
ksym(_lib_ring_buffer_strcpy) = 0x9c6da1d0
ksym(_lib_ring_buffer_strcpy_from_user_inatomic) = 0xc1562a34
ksym(lib_ring_buffer_switch_remote) = 0xefff2b40
ksym(lib_ring_buffer_switch_remote_empty) = 0x5cfe97b3
ksym(lib_ring_buffer_switch_slow) = 0x5200ba7e ksym(_lib_ring_buffer_write)
= 0xb63bbe79 ksym(lttng_add_cpu_id_to_ctx) = 0xba7ce894
ksym(lttng_add_hostname_to_ctx) = 0x6394574a
ksym(lttng_add_interruptible_to_ctx) = 0xd7771943
ksym(lttng_add_need_reschedule_to_ctx) = 0x08b3302f
ksym(lttng_add_nice_to_ctx) = 0xbaa33870 ksym(lttng_add_pid_to_ctx) =
0xb1cb4a79 ksym(lttng_add_ppid_to_ctx) = 0x5e54eb95
ksym(lttng_add_prio_to_ctx) = 0xc3886bbd ksym(lttng_add_procname_to_ctx) =
0x85946da6 ksym(lttng_add_tid_to_ctx) = 0x061c7c5e
ksym(lttng_add_vpid_to_ctx) = 0xc0fd9a02 ksym(lttng_add_vppid_to_ctx) =
0x1c9043d0 ksym(lttng_add_vtid_to_ctx) = 0x772aac25
ksym(lttng_append_context) = 0x360043ff ksym(lttng_clock_ref) = 0x52f30bf0
ksym(lttng_clock_register_plugin) = 0x75d0077f ksym(lttng_clock_unref) =
0xbc072131 ksym(lttng_clock_unregister_plugin) = 0x33543f11
ksym(lttng_event_get) = 0x6c9752a3 ksym(lttng_event_put) = 0x5a1d3572
ksym(lttng_find_context) = 0xeb0fed18 ksym(lttng_ftrace_destroy_private) =
0xa79975a6 ksym(lttng_ftrace_register) = 0x785a786f
ksym(lttng_ftrace_unregister) = 0x4def02b9 ksym(lttng_get_context_index) =
0xaf595534 ksym(lttng_kprobes_destroy_private) = 0x049ed49c
ksym(lttng_kprobes_register) = 0x3c7531ec ksym(lttng_kprobes_unregister) =
0x214f3079 ksym(lttng_kretprobes_destroy_private) = 0x840a437c
ksym(lttng_kretprobes_event_enable_state) = 0x4a5ba2b7
ksym(lttng_kretprobes_register) = 0x415ff55c
ksym(lttng_kretprobes_unregister) = 0x141b3cfe
ksym(lttng_metadata_channel_destroy) = 0x72a21830
ksym(lttng_pid_tracker_lookup) = 0xd2c8889e ksym(lttng_probe_register) =
0x59ef07be ksym(lttng_probe_unregister) = 0xf0bd62a5
ksym(lttng_remove_context_field) = 0xd6954ba4 ksym(lttng_statedump_start) =
0x092d4b2e ksym(lttng_strlen_user_inatomic) = 0xce58fba5
ksym(lttng_trace_clock) = 0xf038f471 ksym(lttng_transport_register) =
0x2174c352 ksym(lttng_transport_unregister) = 0xd6df49d0
ksym(vfs_lib_ring_buffer_mmap) = 0xb6d3823f
ksym(vfs_lib_ring_buffer_no_llseek) = 0xb51dcda9
ksym(vfs_lib_ring_buffer_splice_read) = 0x64aad26a
Requires(interp): /bin/sh /bin/sh /bin/sh
Requires(rpmlib): rpmlib(FileDigests) <= 4.6.0-1
rpmlib(PayloadFilesHavePrefix) <= 4.0-1 rpmlib(CompressedFileNames) <=
3.0.4-1
Requires(post): /usr/sbin/depmod /bin/sh
Requires(preun): /bin/sh
Requires(postun): /usr/sbin/depmod /bin/sh
Requires: kernel(__alloc_pages_nodemask) = 0x8616cca3
kernel(__alloc_percpu) = 0x949f7342 kernel(__bitmap_weight) = 0x4cbbd171
kernel(__fentry__) = 0xbdfb6dbb kernel(__free_pages) = 0xa281370e
kernel(__get_page_tail) = 0xadd2aceb kernel(__get_user_4) = 0x6729d3df
kernel(__get_user_8) = 0x6d334118 kernel(__init_waitqueue_head) =
0xf432dd3d kernel(__kmalloc) = 0xd2b09ce5 kernel(__kmalloc_node) =
0x55f5019b kernel(__list_add) = 0x0343a1a8 kernel(__per_cpu_offset) =
0x0d94cc09 kernel(__put_user_4) = 0xb2fd5ceb kernel(__put_user_8) =
0xb8e7ce2c kernel(__smp_mb__after_atomic) = 0x52b645e5
kernel(__smp_mb__before_atomic) = 0x384e70ae kernel(__stack_chk_fail) =
0xf0fdf6cb kernel(__wake_up) = 0xcf21d241 kernel(_cond_resched) =
0xa1c76e0a kernel(_raw_spin_lock) = 0xd52bf1ce kernel(_raw_spin_unlock) =
0xda3e43d1 kernel(add_timer) = 0xbe2c0274 kernel(add_timer_on) = 0x121ed3f3
kernel(atomic_notifier_chain_unregister) = 0x758a3812
kernel(autoremove_wake_function) = 0xc8b57c27
kernel(copy_user_enhanced_fast_string) = 0x60b40fd8
kernel(copy_user_generic_string) = 0xe5772d4a
kernel(copy_user_generic_unrolled) = 0xdcc3a419 kernel(cpu_number) =
0x54efb5d6 kernel(cpu_online_mask) = 0x930484aa kernel(cpu_possible_mask) =
0xc311ec22 kernel(current_task) = 0xb8c7ff88 kernel(del_timer_sync) =
0xd5f2172f kernel(find_next_bit) = 0xc0a3d105 kernel(finish_wait) =
0xfa66f77c kernel(free_cpumask_var) = 0xdbc34085 kernel(free_percpu) =
0xc9ec4e21 kernel(generic_pipe_buf_confirm) = 0xb369ab86
kernel(generic_pipe_buf_get) = 0x168f15f6 kernel(generic_pipe_buf_map) =
0x020ec224 kernel(generic_pipe_buf_steal) = 0x0d7ce4f3
kernel(generic_pipe_buf_unmap) = 0x60625ff8 kernel(get_online_cpus) =
0x3efb35c9 kernel(init_timer_key) = 0x0593a99b kernel(jiffies) = 0x7d11c268
kernel(jiffies_to_msecs) = 0x37befc70 kernel(jiffies_to_usecs) = 0x7f24de73
kernel(kallsyms_lookup_name) = 0xe007de41 kernel(kernel_stack) = 0x4c4fef19
kernel(kfree) = 0x037a0cba kernel(kmalloc_caches) = 0x98ab5c8d
kernel(kmem_cache_alloc_trace) = 0x41ec4c1a kernel(list_del) = 0x0521445b
kernel(memcpy) = 0x69acdf38 kernel(mod_timer) = 0x8834396c
kernel(mod_timer_pinned) = 0x98fa21b0 kernel(module_layout) = 0x28950ef1
kernel(msleep) = 0xf9a482f9 kernel(node_data) = 0x3142b10b
kernel(nonseekable_open) = 0xd288ca07 kernel(nr_cpu_ids) = 0xfe7c4287
kernel(numa_node) = 0x618911fc kernel(prepare_to_wait) = 0x5c8b5ce8
kernel(printk) = 0x27e1a049 kernel(put_online_cpus) = 0xd7d79132
kernel(register_cpu_notifier) = 0x8b43159b kernel(schedule) = 0x01000e51
kernel(smp_call_function) = 0xd75c79df kernel(smp_call_function_single) =
0x6228c21f kernel(strlcpy) = 0x5792f848 kernel(strnlen) = 0xa916b694
kernel(unregister_cpu_notifier) = 0x1fe9f800 kernel(usecs_to_jiffies) =
0xb54533f7 kernel(warn_slowpath_null) = 0x16305289
kernel(zalloc_cpumask_var) = 0x3e092b88
Processing files: lttng-modules-debuginfo-2.8.0-1.el7.x86_64
Provides: lttng-modules-debuginfo = 2.8.0-1.el7
lttng-modules-debuginfo(x86-64) = 2.8.0-1.el7
Requires(rpmlib): rpmlib(FileDigests) <= 4.6.0-1
rpmlib(PayloadFilesHavePrefix) <= 4.0-1 rpmlib(CompressedFileNames) <=
3.0.4-1
Checking for unpackaged file(s): /usr/lib/rpm/check-files
/root/rpmbuild/BUILDROOT/lttng-modules-2.8.0-1.el7.x86_64
Wrote: /root/rpmbuild/RPMS/x86_64/kmod-lttng-modules-2.8.0-1.el7.x86_64.rpm
Wrote:
/root/rpmbuild/RPMS/x86_64/lttng-modules-debuginfo-2.8.0-1.el7.x86_64.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.i0XGqF
+ umask 022
+ cd /root/rpmbuild/BUILD
+ cd lttng-modules-2.8.0
+ /usr/bin/rm -rf /root/rpmbuild/BUILDROOT/lttng-modules-2.8.0-1.el7.x86_64
+ exit 0




On Fri, Jun 17, 2016 at 11:08 AM, Michael Jeanson <mjeanson@efficios.com>
wrote:

> Hi,
>
> The 'kmod-lttng-modules' binary package we provide only supports the latest
> RHEL 7.x kernel, you can either upgrade your system to the latest kernel or
> get the source package [1] and build it against your current kernel.
>
> Regards,
>
> Michael
>
> [1]
> http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-modules-2.8.0-1.el7.src.rpm
>
>
> ----- On Jun 17, 2016, at 8:53 AM, Ravi Inder Singh raviinder@gmail.com
> wrote:
>
> > Hi all,
> > 1)
> > RHEL 7.1 OS version is :-
> >
> > *****************************************************************8
> > cat /etc/*release
> > NAME="Red Hat Enterprise Linux Workstation"
> > VERSION="7.1 (Maipo)"
> > ID="rhel"
> > ID_LIKE="fedora"
> > VERSION_ID="7.1"
> > PRETTY_NAME="Red Hat Enterprise Linux Workstation 7.1 (Maipo)"
> > ANSI_COLOR="0;31"
> > CPE_NAME="cpe:/o:redhat:enterprise_linux:7.1:GA:workstation"
> > HOME_URL=" https://www.redhat.com/ "
> > BUG_REPORT_URL=" https://bugzilla.redhat.com/ "
> > *********************************************************************
> > 2) I installed everything but when i start kernel tracer it throws me
> error
> > "Kernel Tracer not available"
> >
> >
> > lttng enable-event --kernel allError: Event all: Kernel tracer not
> available
> > (channel channel0, session auto-20160616-165319)
> >
> >
> > Issue i beleive is while installing kernel modules it give me following
> > warnings.
> > Here is output.
> >
> >
> > root # yum install kmod-lttng-modules
> > Loaded plugins: langpacks, product-id, subscription-manager
> > This system is not registered to Red Hat Subscription Management. You
> can use
> > subscription-manager to register.
> > Resolving Dependencies
> > --> Running transaction check
> > ---> Package kmod-lttng-modules.x86_64 0:2.8.0-1.el7 will be installed
> > --> Finished Dependency Resolution
> >
> > Dependencies Resolved
> >
> >
> ================================================================================================================================================================================
> > Package Arch Version Repository Size
> >
> ================================================================================================================================================================================
> > Installing:
> > kmod-lttng-modules x86_64 2.8.0-1.el7 EfficiOS-RHEL7-x86-64 281 k
> >
> > Transaction Summary
> >
> ================================================================================================================================================================================
> > Install 1 Package
> >
> > Total download size: 281 k
> > Installed size: 2.5 M
> > Is this ok [y/d/N]: y
> > Downloading packages:
> > kmod-lttng-modules-2.8.0-1.el7.x86_64.rpm | 281 kB 00:00:00
> > Running transaction check
> > Running transaction test
> > Transaction test succeeded
> > Running transaction
> > Installing : kmod-lttng-modules-2.8.0-1.el7.x86_64 1/1
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kvm.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kvm.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kvm.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sock.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-metadata-client.ko
> > needs unknown symbol lttng_transport_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-metadata-client.ko
> > needs unknown symbol lttng_transport_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-printk.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-napi.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-napi.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-napi.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-discard.ko
> > needs unknown symbol lttng_transport_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-discard.ko
> > needs unknown symbol lttng_transport_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kmem.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kmem.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-kmem.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-compaction.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-overwrite.ko
> > needs unknown symbol lttng_transport_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-overwrite.ko
> > needs unknown symbol lttng_transport_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-overwrite.ko
> > needs unknown symbol lttng_transport_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-mmap-overwrite.ko
> > needs unknown symbol lttng_transport_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-x86-exceptions.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-sunrpc.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-signal.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-signal.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-signal.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-module.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-module.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-module.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-discard.ko
> > needs unknown symbol lttng_transport_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ring-buffer-client-discard.ko
> > needs unknown symbol lttng_transport_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-timer.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-net.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-net.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-net.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/probes/lttng-test.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/probes/lttng-test.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/probes/lttng-test.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-writeback.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-workqueue.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-irq.ko
> > needs unknown symbol lttng_probe_unregister
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-irq.ko
> > needs unknown symbol lttng_probe_register
> > depmod: WARNING:
> >
> /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/lttng-probe-irq.ko
> > needs unknown symbol lttng_pid_tracker_lookup
> > Verifying : kmod-lttng-modules-2.8.0-1.el7.x86_64 1/1
> >
> > Installed:
> > kmod-lttng-modules.x86_64 0:2.8.0-1.el7
> >
> > Complete!
> >
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--94eb2c0649b2ac25280536f9fbdc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Michael, <br></div><div>=C2=A0=C2=A0=C2=A0=C2=A0 K=
ernel version used is :- Linux 3.10.0-229.el7.x86_64 x86_64<br></div><div>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Redahat version 7.1 <br></div><div><br></div=
><div></div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br></div>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 I compiled source package against my kernel it gives me fol=
lowing Warning &quot;Kernel ABI&quot;. Doees this effect my lttng-modules f=
or getting intsalld??<br><br><br>nm: /root/rpmbuild/BUILDROOT/lttng-modules=
-2.8.0-1.el7.x86_64/lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/t=
ests/clock-plugin/lttng-clock-plugin-test.ko: No symbols<br>extracting debu=
g info from /root/rpmbuild/BUILDROOT/lttng-modules-2.8.0-1.el7.x86_64/lib/m=
odules/3.10.0-229.el7.x86_64/extra/lttng-modules/tests/probes/lttng-test.ko=
<br>nm: /root/rpmbuild/BUILDROOT/lttng-modules-2.8.0-1.el7.x86_64/lib/modul=
es/3.10.0-229.el7.x86_64/extra/lttng-modules/tests/probes/lttng-test.ko: No=
 symbols<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modu=
les/lib/lttng-lib-ring-buffer.ko.debug&quot; is not a shared library<br>dwz=
: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-clock=
.ko.debug&quot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-=
229.el7.x86_64/extra/lttng-modules/lttng-ring-buffer-client-discard.ko.debu=
g&quot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.=
x86_64/extra/lttng-modules/lttng-ring-buffer-client-mmap-discard.ko.debug&q=
uot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86=
_64/extra/lttng-modules/lttng-ring-buffer-client-mmap-overwrite.ko.debug&qu=
ot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_=
64/extra/lttng-modules/lttng-ring-buffer-client-overwrite.ko.debug&quot; is=
 not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/ext=
ra/lttng-modules/lttng-ring-buffer-metadata-client.ko.debug&quot; is not a =
shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttn=
g-modules/lttng-ring-buffer-metadata-mmap-client.ko.debug&quot; is not a sh=
ared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-=
modules/lttng-statedump.ko.debug&quot; is not a shared library<br>dwz: &quo=
t;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/lttng-tracer.ko.d=
ebug&quot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.e=
l7.x86_64/extra/lttng-modules/probes/lttng-ftrace.ko.debug&quot; is not a s=
hared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng=
-modules/probes/lttng-kprobes.ko.debug&quot; is not a shared library<br>dwz=
: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttn=
g-kretprobes.ko.debug&quot; is not a shared library<br>dwz: &quot;./lib/mod=
ules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-block.ko.=
debug&quot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.=
el7.x86_64/extra/lttng-modules/probes/lttng-probe-compaction.ko.debug&quot;=
 is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/=
extra/lttng-modules/probes/lttng-probe-irq.ko.debug&quot; is not a shared l=
ibrary<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-module=
s/probes/lttng-probe-jbd2.ko.debug&quot; is not a shared library<br>dwz: &q=
uot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-pr=
obe-kmem.ko.debug&quot; is not a shared library<br>dwz: &quot;./lib/modules=
/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-kvm.ko.debug&=
quot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x8=
6_64/extra/lttng-modules/probes/lttng-probe-module.ko.debug&quot; is not a =
shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttn=
g-modules/probes/lttng-probe-napi.ko.debug&quot; is not a shared library<br=
>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/=
lttng-probe-net.ko.debug&quot; is not a shared library<br>dwz: &quot;./lib/=
modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-power.=
ko.debug&quot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-2=
29.el7.x86_64/extra/lttng-modules/probes/lttng-probe-printk.ko.debug&quot; =
is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/e=
xtra/lttng-modules/probes/lttng-probe-random.ko.debug&quot; is not a shared=
 library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modu=
les/probes/lttng-probe-rcu.ko.debug&quot; is not a shared library<br>dwz: &=
quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-p=
robe-rpm.ko.debug&quot; is not a shared library<br>dwz: &quot;./lib/modules=
/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-sched.ko.debu=
g&quot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.=
x86_64/extra/lttng-modules/probes/lttng-probe-scsi.ko.debug&quot; is not a =
shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttn=
g-modules/probes/lttng-probe-signal.ko.debug&quot; is not a shared library<=
br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probe=
s/lttng-probe-skb.ko.debug&quot; is not a shared library<br>dwz: &quot;./li=
b/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-sock=
.ko.debug&quot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-=
229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-statedump.ko.debug&qu=
ot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_=
64/extra/lttng-modules/probes/lttng-probe-sunrpc.ko.debug&quot; is not a sh=
ared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-=
modules/probes/lttng-probe-timer.ko.debug&quot; is not a shared library<br>=
dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/l=
ttng-probe-udp.ko.debug&quot; is not a shared library<br>dwz: &quot;./lib/m=
odules/3.10.0-229.el7.x86_64/extra/lttng-modules/probes/lttng-probe-vmscan.=
ko.debug&quot; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-2=
29.el7.x86_64/extra/lttng-modules/probes/lttng-probe-workqueue.ko.debug&quo=
t; is not a shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_6=
4/extra/lttng-modules/probes/lttng-probe-writeback.ko.debug&quot; is not a =
shared library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttn=
g-modules/probes/lttng-probe-x86-exceptions.ko.debug&quot; is not a shared =
library<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modul=
es/probes/lttng-probe-x86-irq-vectors.ko.debug&quot; is not a shared librar=
y<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/tes=
ts/clock-plugin/lttng-clock-plugin-test.ko.debug&quot; is not a shared libr=
ary<br>dwz: &quot;./lib/modules/3.10.0-229.el7.x86_64/extra/lttng-modules/t=
ests/probes/lttng-test.ko.debug&quot; is not a shared library<br>dwz: Too f=
ew files for multifile optimization<br>/usr/lib/rpm/sepdebugcrcfix: Updated=
 0 CRC32s, 43 CRC32s did match.<br>2620 blocks<br>+ /usr/lib/rpm/check-buil=
droot<br>+ /usr/lib/rpm/redhat/brp-compress<br>+ /usr/lib/rpm/redhat/brp-st=
rip-static-archive /usr/bin/strip<br>+ /usr/lib/rpm/brp-python-bytecompile =
/usr/bin/python 1<br>+ /usr/lib/rpm/redhat/brp-python-hardlink<br>+ /usr/li=
b/rpm/redhat/brp-java-repack-jars<br>Processing files: kmod-lttng-modules-2=
.8.0-1.el7.x86_64<br>Finding=C2=A0 Provides: /usr/lib/rpm/redhat/find-provi=
des<br>Finding=C2=A0 Requires(interp): <br>Finding=C2=A0 Requires(rpmlib): =
<br>Finding=C2=A0 Requires(verify): <br>Finding=C2=A0 Requires(pre): <br>Fi=
nding=C2=A0 Requires(post): <br>Finding=C2=A0 Requires(preun): <br>Finding=
=C2=A0 Requires(postun): <br>Finding=C2=A0 Requires(pretrans): <br>Finding=
=C2=A0 Requires(posttrans): <br>Finding=C2=A0 Requires: /usr/lib/rpm/redhat=
/find-requires<br><br>*****************************************************=
***************************<br>*********************** KERNEL ABI COMPATIBI=
LITY WARNING ***********************<br>***********************************=
*********************************************<br>The kernel ABI reference f=
iles (provided by kabi-whitelists) were not found.<br>No compatibility chec=
k was performed. Please install the kABI reference files<br>and rebuild if =
you would like to verify compatibility with kernel ABI.<br><br>Provides: ke=
rnel-modules &gt;=3D 3.10.0-229.el7.x86_64 lttng-modules-kmod =3D 2.8.0-1.e=
l7 kmod-lttng-modules =3D 2.8.0-1.el7 kmod-lttng-modules(x86-64) =3D 2.8.0-=
1.el7 ksym(channel_create) =3D 0xa7997152 ksym(channel_destroy) =3D 0x4cb4c=
7f1 ksym(channel_get_next_record) =3D 0xf604aa9c ksym(channel_get_ring_buff=
er) =3D 0xff8d9824 ksym(channel_iterator_open) =3D 0x045cc6f5 ksym(channel_=
iterator_release) =3D 0x42c43c29 ksym(channel_payload_file_operations) =3D =
0x0adb1633 ksym(channel_reset) =3D 0x51094d69 ksym(lib_ring_buffer_clear_qu=
iescent_channel) =3D 0x77c58966 ksym(lib_ring_buffer_compat_ioctl) =3D 0x80=
8f7bc3 ksym(_lib_ring_buffer_copy_from_user_inatomic) =3D 0x0e15057d ksym(_=
_lib_ring_buffer_copy_to_user) =3D 0xbe7c2c7e ksym(lib_ring_buffer_file_ope=
rations) =3D 0x7fd7bb44 ksym(lib_ring_buffer_get_next_record) =3D 0x988ea56=
2 ksym(lib_ring_buffer_get_subbuf) =3D 0x9b0a88c1 ksym(lib_ring_buffer_ioct=
l) =3D 0x8e28d608 ksym(lib_ring_buffer_iterator_open) =3D 0x4ca1462a ksym(l=
ib_ring_buffer_iterator_release) =3D 0xce8713f1 ksym(_lib_ring_buffer_memse=
t) =3D 0x587f6477 ksym(lib_ring_buffer_mmap) =3D 0xd50b19d8 ksym(lib_ring_b=
uffer_move_consumer) =3D 0xbad2c526 ksym(lib_ring_buffer_nesting) =3D 0x277=
6a3e5 ksym(lib_ring_buffer_offset_address) =3D 0xd42e81f1 ksym(lib_ring_buf=
fer_open) =3D 0x6440a359 ksym(lib_ring_buffer_open_read) =3D 0x84e26fbb ksy=
m(lib_ring_buffer_payload_file_operations) =3D 0x3fd0207d ksym(lib_ring_buf=
fer_poll) =3D 0xd5ffe503 ksym(lib_ring_buffer_put_subbuf) =3D 0x27f7c765 ks=
ym(lib_ring_buffer_read) =3D 0x20e07ac8 ksym(lib_ring_buffer_read_cstr) =3D=
 0x98e54af8 ksym(lib_ring_buffer_read_get_pfn) =3D 0x6df83d91 ksym(lib_ring=
_buffer_read_offset_address) =3D 0xdfb7ac9e ksym(lib_ring_buffer_release) =
=3D 0xe361ceca ksym(lib_ring_buffer_release_read) =3D 0x849cd194 ksym(lib_r=
ing_buffer_reserve_slow) =3D 0x10ccb673 ksym(lib_ring_buffer_reset) =3D 0x0=
7e6658d ksym(lib_ring_buffer_set_quiescent_channel) =3D 0x5bda1b1e ksym(lib=
_ring_buffer_snapshot) =3D 0x4336af02 ksym(lib_ring_buffer_splice_read) =3D=
 0x6522d6ed ksym(_lib_ring_buffer_strcpy) =3D 0x9c6da1d0 ksym(_lib_ring_buf=
fer_strcpy_from_user_inatomic) =3D 0xc1562a34 ksym(lib_ring_buffer_switch_r=
emote) =3D 0xefff2b40 ksym(lib_ring_buffer_switch_remote_empty) =3D 0x5cfe9=
7b3 ksym(lib_ring_buffer_switch_slow) =3D 0x5200ba7e ksym(_lib_ring_buffer_=
write) =3D 0xb63bbe79 ksym(lttng_add_cpu_id_to_ctx) =3D 0xba7ce894 ksym(ltt=
ng_add_hostname_to_ctx) =3D 0x6394574a ksym(lttng_add_interruptible_to_ctx)=
 =3D 0xd7771943 ksym(lttng_add_need_reschedule_to_ctx) =3D 0x08b3302f ksym(=
lttng_add_nice_to_ctx) =3D 0xbaa33870 ksym(lttng_add_pid_to_ctx) =3D 0xb1cb=
4a79 ksym(lttng_add_ppid_to_ctx) =3D 0x5e54eb95 ksym(lttng_add_prio_to_ctx)=
 =3D 0xc3886bbd ksym(lttng_add_procname_to_ctx) =3D 0x85946da6 ksym(lttng_a=
dd_tid_to_ctx) =3D 0x061c7c5e ksym(lttng_add_vpid_to_ctx) =3D 0xc0fd9a02 ks=
ym(lttng_add_vppid_to_ctx) =3D 0x1c9043d0 ksym(lttng_add_vtid_to_ctx) =3D 0=
x772aac25 ksym(lttng_append_context) =3D 0x360043ff ksym(lttng_clock_ref) =
=3D 0x52f30bf0 ksym(lttng_clock_register_plugin) =3D 0x75d0077f ksym(lttng_=
clock_unref) =3D 0xbc072131 ksym(lttng_clock_unregister_plugin) =3D 0x33543=
f11 ksym(lttng_event_get) =3D 0x6c9752a3 ksym(lttng_event_put) =3D 0x5a1d35=
72 ksym(lttng_find_context) =3D 0xeb0fed18 ksym(lttng_ftrace_destroy_privat=
e) =3D 0xa79975a6 ksym(lttng_ftrace_register) =3D 0x785a786f ksym(lttng_ftr=
ace_unregister) =3D 0x4def02b9 ksym(lttng_get_context_index) =3D 0xaf595534=
 ksym(lttng_kprobes_destroy_private) =3D 0x049ed49c ksym(lttng_kprobes_regi=
ster) =3D 0x3c7531ec ksym(lttng_kprobes_unregister) =3D 0x214f3079 ksym(ltt=
ng_kretprobes_destroy_private) =3D 0x840a437c ksym(lttng_kretprobes_event_e=
nable_state) =3D 0x4a5ba2b7 ksym(lttng_kretprobes_register) =3D 0x415ff55c =
ksym(lttng_kretprobes_unregister) =3D 0x141b3cfe ksym(lttng_metadata_channe=
l_destroy) =3D 0x72a21830 ksym(lttng_pid_tracker_lookup) =3D 0xd2c8889e ksy=
m(lttng_probe_register) =3D 0x59ef07be ksym(lttng_probe_unregister) =3D 0xf=
0bd62a5 ksym(lttng_remove_context_field) =3D 0xd6954ba4 ksym(lttng_statedum=
p_start) =3D 0x092d4b2e ksym(lttng_strlen_user_inatomic) =3D 0xce58fba5 ksy=
m(lttng_trace_clock) =3D 0xf038f471 ksym(lttng_transport_register) =3D 0x21=
74c352 ksym(lttng_transport_unregister) =3D 0xd6df49d0 ksym(vfs_lib_ring_bu=
ffer_mmap) =3D 0xb6d3823f ksym(vfs_lib_ring_buffer_no_llseek) =3D 0xb51dcda=
9 ksym(vfs_lib_ring_buffer_splice_read) =3D 0x64aad26a<br>Requires(interp):=
 /bin/sh /bin/sh /bin/sh<br>Requires(rpmlib): rpmlib(FileDigests) &lt;=3D 4=
.6.0-1 rpmlib(PayloadFilesHavePrefix) &lt;=3D 4.0-1 rpmlib(CompressedFileNa=
mes) &lt;=3D 3.0.4-1<br>Requires(post): /usr/sbin/depmod /bin/sh<br>Require=
s(preun): /bin/sh<br>Requires(postun): /usr/sbin/depmod /bin/sh<br>Requires=
: kernel(__alloc_pages_nodemask) =3D 0x8616cca3 kernel(__alloc_percpu) =3D =
0x949f7342 kernel(__bitmap_weight) =3D 0x4cbbd171 kernel(__fentry__) =3D 0x=
bdfb6dbb kernel(__free_pages) =3D 0xa281370e kernel(__get_page_tail) =3D 0x=
add2aceb kernel(__get_user_4) =3D 0x6729d3df kernel(__get_user_8) =3D 0x6d3=
34118 kernel(__init_waitqueue_head) =3D 0xf432dd3d kernel(__kmalloc) =3D 0x=
d2b09ce5 kernel(__kmalloc_node) =3D 0x55f5019b kernel(__list_add) =3D 0x034=
3a1a8 kernel(__per_cpu_offset) =3D 0x0d94cc09 kernel(__put_user_4) =3D 0xb2=
fd5ceb kernel(__put_user_8) =3D 0xb8e7ce2c kernel(__smp_mb__after_atomic) =
=3D 0x52b645e5 kernel(__smp_mb__before_atomic) =3D 0x384e70ae kernel(__stac=
k_chk_fail) =3D 0xf0fdf6cb kernel(__wake_up) =3D 0xcf21d241 kernel(_cond_re=
sched) =3D 0xa1c76e0a kernel(_raw_spin_lock) =3D 0xd52bf1ce kernel(_raw_spi=
n_unlock) =3D 0xda3e43d1 kernel(add_timer) =3D 0xbe2c0274 kernel(add_timer_=
on) =3D 0x121ed3f3 kernel(atomic_notifier_chain_unregister) =3D 0x758a3812 =
kernel(autoremove_wake_function) =3D 0xc8b57c27 kernel(copy_user_enhanced_f=
ast_string) =3D 0x60b40fd8 kernel(copy_user_generic_string) =3D 0xe5772d4a =
kernel(copy_user_generic_unrolled) =3D 0xdcc3a419 kernel(cpu_number) =3D 0x=
54efb5d6 kernel(cpu_online_mask) =3D 0x930484aa kernel(cpu_possible_mask) =
=3D 0xc311ec22 kernel(current_task) =3D 0xb8c7ff88 kernel(del_timer_sync) =
=3D 0xd5f2172f kernel(find_next_bit) =3D 0xc0a3d105 kernel(finish_wait) =3D=
 0xfa66f77c kernel(free_cpumask_var) =3D 0xdbc34085 kernel(free_percpu) =3D=
 0xc9ec4e21 kernel(generic_pipe_buf_confirm) =3D 0xb369ab86 kernel(generic_=
pipe_buf_get) =3D 0x168f15f6 kernel(generic_pipe_buf_map) =3D 0x020ec224 ke=
rnel(generic_pipe_buf_steal) =3D 0x0d7ce4f3 kernel(generic_pipe_buf_unmap) =
=3D 0x60625ff8 kernel(get_online_cpus) =3D 0x3efb35c9 kernel(init_timer_key=
) =3D 0x0593a99b kernel(jiffies) =3D 0x7d11c268 kernel(jiffies_to_msecs) =
=3D 0x37befc70 kernel(jiffies_to_usecs) =3D 0x7f24de73 kernel(kallsyms_look=
up_name) =3D 0xe007de41 kernel(kernel_stack) =3D 0x4c4fef19 kernel(kfree) =
=3D 0x037a0cba kernel(kmalloc_caches) =3D 0x98ab5c8d kernel(kmem_cache_allo=
c_trace) =3D 0x41ec4c1a kernel(list_del) =3D 0x0521445b kernel(memcpy) =3D =
0x69acdf38 kernel(mod_timer) =3D 0x8834396c kernel(mod_timer_pinned) =3D 0x=
98fa21b0 kernel(module_layout) =3D 0x28950ef1 kernel(msleep) =3D 0xf9a482f9=
 kernel(node_data) =3D 0x3142b10b kernel(nonseekable_open) =3D 0xd288ca07 k=
ernel(nr_cpu_ids) =3D 0xfe7c4287 kernel(numa_node) =3D 0x618911fc kernel(pr=
epare_to_wait) =3D 0x5c8b5ce8 kernel(printk) =3D 0x27e1a049 kernel(put_onli=
ne_cpus) =3D 0xd7d79132 kernel(register_cpu_notifier) =3D 0x8b43159b kernel=
(schedule) =3D 0x01000e51 kernel(smp_call_function) =3D 0xd75c79df kernel(s=
mp_call_function_single) =3D 0x6228c21f kernel(strlcpy) =3D 0x5792f848 kern=
el(strnlen) =3D 0xa916b694 kernel(unregister_cpu_notifier) =3D 0x1fe9f800 k=
ernel(usecs_to_jiffies) =3D 0xb54533f7 kernel(warn_slowpath_null) =3D 0x163=
05289 kernel(zalloc_cpumask_var) =3D 0x3e092b88<br>Processing files: lttng-=
modules-debuginfo-2.8.0-1.el7.x86_64<br>Provides: lttng-modules-debuginfo =
=3D 2.8.0-1.el7 lttng-modules-debuginfo(x86-64) =3D 2.8.0-1.el7<br>Requires=
(rpmlib): rpmlib(FileDigests) &lt;=3D 4.6.0-1 rpmlib(PayloadFilesHavePrefix=
) &lt;=3D 4.0-1 rpmlib(CompressedFileNames) &lt;=3D 3.0.4-1<br>Checking for=
 unpackaged file(s): /usr/lib/rpm/check-files /root/rpmbuild/BUILDROOT/lttn=
g-modules-2.8.0-1.el7.x86_64<br>Wrote: /root/rpmbuild/RPMS/x86_64/kmod-lttn=
g-modules-2.8.0-1.el7.x86_64.rpm<br>Wrote: /root/rpmbuild/RPMS/x86_64/lttng=
-modules-debuginfo-2.8.0-1.el7.x86_64.rpm<br>Executing(%clean): /bin/sh -e =
/var/tmp/rpm-tmp.i0XGqF<br>+ umask 022<br>+ cd /root/rpmbuild/BUILD<br>+ cd=
 lttng-modules-2.8.0<br>+ /usr/bin/rm -rf /root/rpmbuild/BUILDROOT/lttng-mo=
dules-2.8.0-1.el7.x86_64<br>+ exit 0<br><br><br><br><div><div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Jun 17, 2016 at 11:08 =
AM, Michael Jeanson <span dir=3D"ltr">&lt;<a href=3D"mailto:mjeanson@effici=
os.com" target=3D"_blank">mjeanson@efficios.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
The &#39;kmod-lttng-modules&#39; binary package we provide only supports th=
e latest<br>
RHEL 7.x kernel, you can either upgrade your system to the latest kernel or=
<br>
get the source package [1] and build it against your current kernel.<br>
<br>
Regards,<br>
<br>
Michael<br>
<br>
[1] <a href=3D"http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modul=
es/lttng-modules-2.8.0-1.el7.src.rpm" rel=3D"noreferrer" target=3D"_blank">=
http://packages.efficios.com/rhel/7/SRPMS/latest/lttng-modules/lttng-module=
s-2.8.0-1.el7.src.rpm</a><br>
<div><div><br>
<br>
----- On Jun 17, 2016, at 8:53 AM, Ravi Inder Singh <a href=3D"mailto:ravii=
nder@gmail.com" target=3D"_blank">raviinder@gmail.com</a> wrote:<br>
<br>
&gt; Hi all,<br>
&gt; 1)<br>
&gt; RHEL 7.1 OS version is :-<br>
&gt;<br>
&gt; *****************************************************************8<br>
&gt; cat /etc/*release<br>
&gt; NAME=3D&quot;Red Hat Enterprise Linux Workstation&quot;<br>
&gt; VERSION=3D&quot;7.1 (Maipo)&quot;<br>
&gt; ID=3D&quot;rhel&quot;<br>
&gt; ID_LIKE=3D&quot;fedora&quot;<br>
&gt; VERSION_ID=3D&quot;7.1&quot;<br>
&gt; PRETTY_NAME=3D&quot;Red Hat Enterprise Linux Workstation 7.1 (Maipo)&q=
uot;<br>
&gt; ANSI_COLOR=3D&quot;0;31&quot;<br>
&gt; CPE_NAME=3D&quot;cpe:/o:redhat:enterprise_linux:7.1:GA:workstation&quo=
t;<br>
&gt; HOME_URL=3D&quot; <a href=3D"https://www.redhat.com/" rel=3D"noreferre=
r" target=3D"_blank">https://www.redhat.com/</a> &quot;<br>
&gt; BUG_REPORT_URL=3D&quot; <a href=3D"https://bugzilla.redhat.com/" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/</a> &quot;<b=
r>
&gt; *********************************************************************<=
br>
&gt; 2) I installed everything but when i start kernel tracer it throws me =
error<br>
&gt; &quot;Kernel Tracer not available&quot;<br>
&gt;<br>
&gt;<br>
&gt; lttng enable-event --kernel allError: Event all: Kernel tracer not ava=
ilable<br>
&gt; (channel channel0, session auto-20160616-165319)<br>
&gt;<br>
&gt;<br>
&gt; Issue i beleive is while installing kernel modules it give me followin=
g<br>
&gt; warnings.<br>
&gt; Here is output.<br>
&gt;<br>
&gt;<br>
&gt; root # yum install kmod-lttng-modules<br>
&gt; Loaded plugins: langpacks, product-id, subscription-manager<br>
&gt; This system is not registered to Red Hat Subscription Management. You =
can use<br>
&gt; subscription-manager to register.<br>
&gt; Resolving Dependencies<br>
&gt; --&gt; Running transaction check<br>
&gt; ---&gt; Package kmod-lttng-modules.x86_64 0:2.8.0-1.el7 will be instal=
led<br>
&gt; --&gt; Finished Dependency Resolution<br>
&gt;<br>
&gt; Dependencies Resolved<br>
&gt;<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
&gt; Package Arch Version Repository Size<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
&gt; Installing:<br>
&gt; kmod-lttng-modules x86_64 2.8.0-1.el7 EfficiOS-RHEL7-x86-64 281 k<br>
&gt;<br>
&gt; Transaction Summary<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
&gt; Install 1 Package<br>
&gt;<br>
&gt; Total download size: 281 k<br>
&gt; Installed size: 2.5 M<br>
&gt; Is this ok [y/d/N]: y<br>
&gt; Downloading packages:<br>
&gt; kmod-lttng-modules-2.8.0-1.el7.x86_64.rpm | 281 kB 00:00:00<br>
&gt; Running transaction check<br>
&gt; Running transaction test<br>
&gt; Transaction test succeeded<br>
&gt; Running transaction<br>
&gt; Installing : kmod-lttng-modules-2.8.0-1.el7.x86_64 1/1<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-kvm.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-kvm.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-kvm.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-sock.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-sock.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-sock.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-metadata-client.ko<br>
&gt; needs unknown symbol lttng_transport_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-metadata-client.ko<br>
&gt; needs unknown symbol lttng_transport_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-printk.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-printk.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-printk.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-napi.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-napi.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-napi.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-client-mmap-discard.ko<br>
&gt; needs unknown symbol lttng_transport_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-client-mmap-discard.ko<br>
&gt; needs unknown symbol lttng_transport_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-kmem.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-kmem.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-kmem.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-compaction.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-compaction.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-compaction.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-client-overwrite.ko<br>
&gt; needs unknown symbol lttng_transport_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-client-overwrite.ko<br>
&gt; needs unknown symbol lttng_transport_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-client-mmap-overwrite.ko<br>
&gt; needs unknown symbol lttng_transport_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-client-mmap-overwrite.ko<br>
&gt; needs unknown symbol lttng_transport_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-x86-exceptions.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-x86-exceptions.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-x86-exceptions.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-sunrpc.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-sunrpc.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-sunrpc.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-signal.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-signal.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-signal.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-module.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-module.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-module.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-client-discard.ko<br>
&gt; needs unknown symbol lttng_transport_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/lttng-ri=
ng-buffer-client-discard.ko<br>
&gt; needs unknown symbol lttng_transport_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-timer.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-timer.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-timer.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-net.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-net.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-net.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/pr=
obes/lttng-test.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/pr=
obes/lttng-test.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/tests/pr=
obes/lttng-test.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-writeback.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-workqueue.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-irq.ko<br>
&gt; needs unknown symbol lttng_probe_unregister<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-irq.ko<br>
&gt; needs unknown symbol lttng_probe_register<br>
&gt; depmod: WARNING:<br>
&gt; /lib/modules/3.10.0-229.el7.x86_64/weak-updates/lttng-modules/probes/l=
ttng-probe-irq.ko<br>
&gt; needs unknown symbol lttng_pid_tracker_lookup<br>
&gt; Verifying : kmod-lttng-modules-2.8.0-1.el7.x86_64 1/1<br>
&gt;<br>
&gt; Installed:<br>
&gt; kmod-lttng-modules.x86_64 0:2.8.0-1.el7<br>
&gt;<br>
&gt; Complete!<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
</blockquote></div><br></div></div></div></div>

--94eb2c0649b2ac25280536f9fbdc--

--===============0461152961411716189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0461152961411716189==--
