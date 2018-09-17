From: srikanth krishnakar <skrishnakar@gmail.com>
Subject: Lttng-modules-2.10.x builds with warning of undefined
 "__migrate_disabled" with RT Kernels >= 4.14
Date: Tue, 18 Sep 2018 00:03:18 +0530
Message-ID: <CALDxG5gmKr9NzeVyQ9uzWfK0kTdqiyut=CWjRRUqHOs4kdRSNg__48744.8645443239$1537209123$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5744341657904167320=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 by lists.lttng.org (Postfix) with ESMTPS id 42DZX625Fjzy7B
 for <lttng-dev@lists.lttng.org>; Mon, 17 Sep 2018 14:33:58 -0400 (EDT)
Received: by mail-yb1-xb2b.google.com with SMTP id s8-v6so4011774ybo.11
 for <lttng-dev@lists.lttng.org>; Mon, 17 Sep 2018 11:33:57 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============5744341657904167320==
Content-Type: multipart/alternative; boundary="00000000000076bef10576156a67"

--00000000000076bef10576156a67
Content-Type: text/plain; charset="UTF-8"

Hi All,

Sub: Lttng-modules-2.10.x builds with warning of undefined
"__migrate_disabled" with RT Kernels >= 4.14
Kernel: Linux-4.14.59-rt37 (Upstream)
Arch: x86_64
Build and runtime environment: Debian-9

-------------------
Runtime Impact: Lttng modules arent loading and throws error during runtime
as shown below
-------------------
debian@debian:~$ lsmod | grep -i lttng
lttng_statedump        65536  0
lttng_kprobes          16384  0
lttng_clock            16384  0
lttng_lib_ring_buffer    69632  0
lttng_kretprobes       16384  0
debian@debian:~$
debian@debian:~$ sudo dmesg  | grep -i migrate
[   10.721478] lttng_tracer: Unknown symbol __migrate_disabled (err 0)
debian@debian:~$
-------------------

The since Linux-4.9 there seems to be upstream modifications in LTTng
dependencies like headers and other needed files. I have been trying to
build the latest Lttng-modules-2.10.7 with a RT kernel as out-of-tree
modules and been seeing the issue of undefined reference of
"__migrate_disabled" which is defined in kernel source
"include/linux/preempt.h" and yes the kernel has already enabled all needed
dependencies that are seen below:

-------------------------------------
Kernel config options:
--------------------------------------
CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_RT_BASE=y
CONFIG_HAVE_PREEMPT_LAZY=y
CONFIG_PREEMPT_LAZY=y
CONFIG_PREEMPT_RT_FULL=y
CONFIG_PREEMPT_COUNT=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_TRACEPOINTS=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
--------------------------------------

The build completes successfully without warning and lttng runs fine only
when the LTTng-modules are made as built-in meaning when they are built via
"built-in.sh" script and embedded into kernel.

Another scenario where the issue is reproduced is:

The Error behaviour is seen in the "linux-yocto-4.14-59-rt37"  when
meta-intel is built with rocko release.

---------------------------------------
Build log in debian environment:
------------------------------------------------------------
---------------------------------------
dpkg-source: warning: no source format specified in debian/source/format,
see dpkg-source(1)
dpkg-source: info: using source format '1.0'
dpkg-source: info: building lttng-modules in lttng-modules_2.10.7.tar.gz
dpkg-source: info: building lttng-modules in lttng-modules_2.10.7.dsc
 debian/rules build
dh build -- KERNELDIR="/usr/src/linux-headers-4.14.59-rt37+"
   dh_testdir -O--=KERNELDIR=/usr/src/linux-headers-4.14.59-rt37\+
   dh_update_autotools_config -O--=KERNELDIR=/usr/src/linux-
headers-4.14.59-rt37\+
   dh_auto_configure -O--=KERNELDIR=/usr/src/linux-headers-4.14.59-rt37\+
   debian/rules override_dh_auto_build
make[1]: Entering directory '/home/builder/lttng-modules/
lttng-modules-2.10.7'
/usr/bin/make KERNELDIR="/usr/src/linux-headers-4.14.59-rt37+"
make[2]: Entering directory '/home/builder/lttng-modules/
lttng-modules-2.10.7'
/usr/bin/make -C /usr/src/linux-headers-4.14.59-rt37+
M=/home/builder/lttng-modules/lttng-modules-2.10.7 CONFIG_LTTNG=m
CONFIG_LTTNG_CLOCK_PLUGIN_TEST=m modules
make[3]: Entering directory '/usr/src/linux-headers-4.14.59-rt37+'
find: '/home/builder/lttng-modules/lttng-modules-2.10.7/extra_version/patches/':
No such file or directory
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-discard.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-overwrite.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-metadata-client.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-mmap-discard.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-mmap-overwrite.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-metadata-mmap-client.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-clock.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-events.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-abi.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
string-utils.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-probes.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-context.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-pid.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-procname.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-prio.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-nice.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-vpid.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-tid.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-vtid.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-ppid.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-vppid.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-cpu-id.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-interruptible.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-need-reschedule.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-calibrate.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-hostname.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/wrapper/random.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/lttng.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/wrapper/
trace-clock.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/wrapper/
page_alloc.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
tracker-pid.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-filter.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
filter-interpreter.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
filter-specialize.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
filter-validator.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-user.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-tp-
mempool.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-syscalls.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-perf-counters.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-migratable.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
context-preemptible.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
tracepoint.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-tracer.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
statedump-impl.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/wrapper/irqdesc.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/wrapper/fdtable.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-statedump.o
find: '/home/builder/lttng-modules/lttng-modules-2.10.7/lib/../extra_version/patches/':
No such file or directory
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lib/
ringbuffer/ring_buffer_backend.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lib/
ringbuffer/ring_buffer_frontend.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lib/
ringbuffer/ring_buffer_iterator.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lib/
ringbuffer/ring_buffer_vfs.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lib/
ringbuffer/ring_buffer_splice.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lib/
ringbuffer/ring_buffer_mmap.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lib/prio_
heap/lttng_prio_heap.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lib/../
wrapper/splice.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lib/
lttng-lib-ring-buffer.o
find: '/home/builder/lttng-modules/lttng-modules-2.10.7/probes/../extra_version/patches/':
No such file or directory
/home/builder/lttng-modules/lttng-modules-2.10.7/probes/Kbuild:41: File
./arch/x86/kvm/lapic.h not found. Probe "kvm" x86-specific is disabled. Use
full kernel source tree to enable it.
/home/builder/lttng-modules/lttng-modules-2.10.7/probes/Kbuild:166: Files
./fs/btrfs/*.h not found. Probe "btrfs" is disabled. Use full kernel source
tree to enable it.
/home/builder/lttng-modules/lttng-modules-2.10.7/probes/Kbuild:182: Files
./fs/ext4/*.h not found. Probe "ext4" is disabled. Use full kernel source
tree to enable it.
/home/builder/lttng-modules/lttng-modules-2.10.7/probes/Kbuild:215: File
./drivers/base/regmap/trace.h not found. Probe "regmap" is disabled. Need
Linux 4.1+ kernel source tree to enable it.
/home/builder/lttng-modules/lttng-modules-2.10.7/probes/Kbuild:265: Files
./kernel/trace/trace.h not found. Probe "ftrace" is disabled. Use full
kernel source tree to enable it.
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sched.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-irq.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-timer.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-kmem.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-module.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-power.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-statedump.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-i2c.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-kvm.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-x86-irq-vectors.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-x86-exceptions.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-signal.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-block.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-napi.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-skb.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-net.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sock.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-udp.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-asoc.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-gpio.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-jbd2.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-regulator.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-scsi.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-vmscan.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-compaction.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-printk.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-random.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-rcu.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sunrpc.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-v4l2.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-workqueue.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-writeback.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-kprobes.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-kretprobes.o
find: '/home/builder/lttng-modules/lttng-modules-2.10.7/tests/../extra_version/patches/':
No such file or directory
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/tests/
probes/lttng-test.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/tests/
lttng-test.o
  CC [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/tests/
clock-plugin/lttng-clock-plugin-test.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/tests/
lttng-clock-plugin-test.o
  Building modules, stage 2.
find: '/home/builder/lttng-modules/lttng-modules-2.10.7/extra_version/patches/':
No such file or directory
  MODPOST 46 modules
WARNING: "__migrate_disabled" [/home/builder/lttng-modules/
lttng-modules-2.10.7/lttng-tracer.ko] undefined!
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/lib/
lttng-lib-ring-buffer.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lib/
lttng-lib-ring-buffer.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-clock.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-clock.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-discard.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-discard.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-mmap-discard.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-mmap-discard.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-mmap-overwrite.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-mmap-overwrite.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-overwrite.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-overwrite.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-metadata-client.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-metadata-client.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-metadata-mmap-client.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-metadata-mmap-client.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
statedump.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
statedump.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
tracer.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-tracer.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-kprobes.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-kprobes.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-kretprobes.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-kretprobes.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-asoc.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-asoc.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-block.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-block.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-compaction.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-compaction.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-gpio.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-gpio.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-i2c.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-i2c.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-irq.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-irq.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-jbd2.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-jbd2.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-kmem.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-kmem.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-kvm.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-kvm.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-module.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-module.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-napi.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-napi.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-net.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-net.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-power.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-power.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-printk.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-printk.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-random.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-random.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-rcu.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-rcu.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-regulator.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-regulator.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sched.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sched.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-scsi.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-scsi.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-signal.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-signal.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-skb.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-skb.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sock.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sock.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-statedump.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-statedump.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sunrpc.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sunrpc.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-timer.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-timer.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-udp.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-udp.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-v4l2.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-v4l2.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-vmscan.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-vmscan.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-workqueue.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-workqueue.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-writeback.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-writeback.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-x86-exceptions.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-x86-exceptions.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-x86-irq-vectors.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-x86-irq-vectors.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/tests/
lttng-clock-plugin-test.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/tests/
lttng-clock-plugin-test.ko
  CC      /home/builder/lttng-modules/lttng-modules-2.10.7/tests/
lttng-test.mod.o
  LD [M]  /home/builder/lttng-modules/lttng-modules-2.10.7/tests/
lttng-test.ko
make[3]: Leaving directory '/usr/src/linux-headers-4.14.59-rt37+'
make[2]: Leaving directory '/home/builder/lttng-modules/
lttng-modules-2.10.7'
make[1]: Leaving directory '/home/builder/lttng-modules/
lttng-modules-2.10.7'
   dh_auto_test -O--=KERNELDIR=/usr/src/linux-headers-4.14.59-rt37\+
   create-stamp debian/debhelper-build-stamp
 debian/rules binary
dh binary -- KERNELDIR="/usr/src/linux-headers-4.14.59-rt37+"
   create-stamp debian/debhelper-build-stamp
   dh_testroot -O--=KERNELDIR=/usr/src/linux-headers-4.14.59-rt37\+
   dh_prep -O--=KERNELDIR=/usr/src/linux-headers-4.14.59-rt37\+
   dh_installdirs -O--=KERNELDIR=/usr/src/linux-headers-4.14.59-rt37\+
   debian/rules override_dh_auto_install
make[1]: Entering directory '/home/builder/lttng-modules/
lttng-modules-2.10.7'
mkdir installed-modules
/usr/bin/make KERNELDIR="/usr/src/linux-headers-4.14.59-rt37+"
modules_install && cp -a /lib/modules/*/extra/* /home/builder/lttng-modules/
lttng-modules-2.10.7/installed-modules
make[2]: Entering directory '/home/builder/lttng-modules/
lttng-modules-2.10.7'
/usr/bin/make -C /usr/src/linux-headers-4.14.59-rt37+
M=/home/builder/lttng-modules/lttng-modules-2.10.7 CONFIG_LTTNG=m
CONFIG_LTTNG_CLOCK_PLUGIN_TEST=m modules_install
make[3]: Entering directory '/usr/src/linux-headers-4.14.59-rt37+'
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/lib/
lttng-lib-ring-buffer.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-clock.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-discard.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-mmap-discard.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-mmap-overwrite.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-client-overwrite.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-metadata-client.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
ring-buffer-metadata-mmap-client.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-
statedump.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/lttng-tracer.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-kprobes.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-kretprobes.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-asoc.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-block.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-compaction.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-gpio.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-i2c.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-irq.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-jbd2.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-kmem.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-kvm.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-module.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-napi.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-net.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-power.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-printk.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-random.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-rcu.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-regulator.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sched.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-scsi.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-signal.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-skb.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sock.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-statedump.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-sunrpc.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-timer.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-udp.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-v4l2.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-vmscan.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-workqueue.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-writeback.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-x86-exceptions.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/probes/
lttng-probe-x86-irq-vectors.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/tests/
lttng-clock-plugin-test.ko
  INSTALL /home/builder/lttng-modules/lttng-modules-2.10.7/tests/
lttng-test.ko
  DEPMOD  4.14.59-rt37+
------------------------------------------------------------
-------------------------------------

The same version of modules builds fine with "Linux-4.9.x-rt". Also the
kconfig of lttng is designed as "Tristate" and the build error is seen when
we build with "built-in.sh <KERNEL_SRC>" and CONFIG_LTTNG=m in kernel
menuconfig.

Anyone has seen the issue with the RT kernels >= 4.14 ?  Appreciate your
inputs.

Thanks,
Srikanth

--00000000000076bef10576156a67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><span style=3D"font=
-family:monospace,monospace">Hi All,</span></div><div><span style=3D"font-f=
amily:monospace,monospace"><br></span></div><div><span style=3D"font-family=
:monospace,monospace">Sub: Lttng-modules-2.10.x builds with warning of unde=
fined &quot;__migrate_disabled&quot; with RT Kernels &gt;=3D 4.14</span></d=
iv><div><span style=3D"font-family:monospace,monospace">Kernel: Linux-4.14.=
59-rt37 (Upstream)<br></span></div><div><span style=3D"font-family:monospac=
e,monospace">Arch: x86_64</span></div><div><span style=3D"font-family:monos=
pace,monospace">Build and runtime environment: Debian-9<br></span></div><di=
v><span style=3D"font-family:monospace,monospace"><br></span></div><div><sp=
an style=3D"font-family:monospace,monospace">-------------------<br></span>=
</div><div><span style=3D"font-family:monospace,monospace">Runtime Impact: =
Lttng modules arent loading and throws error during runtime as shown below<=
br></span></div><div><span style=3D"font-family:monospace,monospace">------=
-------------</span></div><div><span style=3D"font-family:monospace,monospa=
ce">debian@debian:~$ lsmod | grep -i lttng<br>lttng_statedump=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 65536=C2=A0 0<br>lttng_kprobes=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384=C2=A0 0<br>lttng_clock=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384=C2=A0=
 0<br>lttng_lib_ring_buffer=C2=A0=C2=A0=C2=A0 69632=C2=A0 0<br>lttng_kretpr=
obes=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16384=C2=A0 0<br>debian@debian:~$ =
<br>debian@debian:~$ sudo dmesg=C2=A0 | grep -i migrate<br>[=C2=A0=C2=A0 10=
.721478] lttng_tracer: Unknown symbol __migrate_disabled (err 0)<br>debian@=
debian:~$ <br></span></div><div><span style=3D"font-family:monospace,monosp=
ace">-------------------<br></span></div><div><span style=3D"font-family:mo=
nospace,monospace"><br></span></div><div><span style=3D"font-family:monospa=
ce,monospace">The
 since Linux-4.9 there seems to be upstream modifications in LTTng=20
dependencies like headers and other needed files. I have been trying to=20
build the latest Lttng-modules-2.10.7 with a RT kernel as out-of-tree=20
modules and been seeing the issue of undefined reference of=20
&quot;__migrate_disabled&quot; which is defined in kernel source=20
&quot;include/linux/preempt.h&quot; and yes the kernel has already enabled =
all=20
needed dependencies that are seen below:</span></div><div><span style=3D"fo=
nt-family:monospace,monospace"><br></span></div><div><span style=3D"font-fa=
mily:monospace,monospace">------------------------------</span><span style=
=3D"font-family:monospace,monospace">-------<br></span></div><div><span sty=
le=3D"font-family:monospace,monospace">Kernel config options:</span></div><=
div><span style=3D"font-family:monospace,monospace">-----------------------=
-------</span><span style=3D"font-family:monospace,monospace">--------</spa=
n></div><div><span style=3D"font-family:monospace,monospace">CONFIG_PREEMPT=
_RCU=3Dy<br>CONFIG_PREEMPT_NOTIFIERS=3Dy<br>CONFIG_PREEMPT=3Dy<br>CONFIG_PR=
EEMPT_RT_BASE=3Dy<br>CONFIG_HAVE_PREEMPT_LAZY=3Dy<br>CONFIG_PREEMPT_LAZY=3D=
y<br>CONFIG_PREEMPT_RT_FULL=3Dy<br>CONFIG_PREEMPT_COUNT=3Dy<br>CONFIG_DEBUG=
_PREEMPT=3Dy<br>CONFIG_TRACEPOINTS=3Dy<br>CONFIG_HAVE_SYSCALL_</span><span =
style=3D"font-family:monospace,monospace">TRACEPOINTS=3Dy<br>CONFIG_KALLSYM=
S=3Dy<br>CONFIG_KALLSYMS_ALL=3Dy<br>CONFIG_KALLSYMS_ABSOLUTE_</span><span s=
tyle=3D"font-family:monospace,monospace">PERCPU=3Dy<br>CONFIG_KALLSYMS_BASE=
_RELATIVE=3D</span><span style=3D"font-family:monospace,monospace">y<br></s=
pan></div><div><span style=3D"font-family:monospace,monospace">------------=
------------------</span><span style=3D"font-family:monospace,monospace">--=
------<br></span></div><div><span style=3D"font-family:monospace,monospace"=
><br></span></div><div><span style=3D"font-family:monospace,monospace">The
 build completes successfully without warning and lttng runs fine only=20
when the LTTng-modules are made as built-in meaning when they are built=20
via &quot;built-in.sh&quot; script and embedded into kernel.</span></div><d=
iv><span style=3D"font-family:monospace,monospace"><br></span></div><div><s=
pan style=3D"font-family:monospace,monospace">Another scenario where the is=
sue is reproduced is:</span></div><div><span style=3D"font-family:monospace=
,monospace"><br></span></div><div><span style=3D"font-family:monospace,mono=
space">The Error behaviour is seen in the &quot;linux-yocto-4.14-59-rt37&qu=
ot;=C2=A0 when meta-intel is built with rocko release.<br></span></div><div=
><span style=3D"font-family:monospace,monospace"><br></span></div><div dir=
=3D"ltr"><span style=3D"font-family:monospace,monospace">------------------=
------------</span><span style=3D"font-family:monospace,monospace">--------=
-<br></span></div><div><span style=3D"font-family:monospace,monospace">Buil=
d log in debian environment:</span></div><div><span style=3D"font-family:mo=
nospace,monospace">------------------------------</span><span style=3D"font=
-family:monospace,monospace">------------------------------</span><span sty=
le=3D"font-family:monospace,monospace">------------------------------</span=
><span style=3D"font-family:monospace,monospace">---------</span></div><div=
 dir=3D"ltr"><span style=3D"font-family:monospace,monospace">dpkg-source: w=
arning: no source format specified in debian/source/format, see dpkg-source=
(1)<br>dpkg-source: info: using source format &#39;1.0&#39;<br>dpkg-source:=
 info: building lttng-modules in lttng-modules_2.10.7.tar.gz<br>dpkg-source=
: info: building lttng-modules in lttng-modules_2.10.7.dsc<br>=C2=A0debian/=
rules build<br>dh build -- KERNELDIR=3D&quot;/usr/src/linux-</span><span st=
yle=3D"font-family:monospace,monospace">headers-4.14.59-rt37+&quot;<br>=C2=
=A0=C2=A0 dh_testdir -O--=3DKERNELDIR=3D/usr/src/linux-</span><span style=
=3D"font-family:monospace,monospace">headers-4.14.59-rt37\+<br>=C2=A0=C2=A0=
 dh_update_autotools_config -O--=3DKERNELDIR=3D/usr/src/linux-</span><span =
style=3D"font-family:monospace,monospace">headers-4.14.59-rt37\+<br>=C2=A0=
=C2=A0 dh_auto_configure -O--=3DKERNELDIR=3D/usr/src/linux-</span><span sty=
le=3D"font-family:monospace,monospace">headers-4.14.59-rt37\+<br>=C2=A0=C2=
=A0 debian/rules override_dh_auto_build<br>make[1]: Entering directory &#39=
;/home/builder/lttng-modules/</span><span style=3D"font-family:monospace,mo=
nospace">lttng-modules-2.10.7&#39;<br>/usr/bin/make KERNELDIR=3D&quot;/usr/=
src/linux-</span><span style=3D"font-family:monospace,monospace">headers-4.=
14.59-rt37+&quot;<br>make[2]: Entering directory &#39;/home/builder/lttng-m=
odules/</span><span style=3D"font-family:monospace,monospace">lttng-modules=
-2.10.7&#39;<br>/usr/bin/make -C /usr/src/linux-headers-4.14.</span><span s=
tyle=3D"font-family:monospace,monospace">59-rt37+ M=3D/home/builder/lttng-m=
odules/</span><span style=3D"font-family:monospace,monospace">lttng-modules=
-2.10.7 CONFIG_LTTNG=3Dm CONFIG_LTTNG_CLOCK_PLUGIN_</span><span style=3D"fo=
nt-family:monospace,monospace">TEST=3Dm modules<br>make[3]: Entering direct=
ory &#39;/usr/src/linux-headers-4.14.</span><span style=3D"font-family:mono=
space,monospace">59-rt37+&#39;<br>find: &#39;/home/builder/lttng-modules/</=
span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/e=
xtra_</span><span style=3D"font-family:monospace,monospace">version/patches=
/&#39;: No such file or directory<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttn=
g-modules/</span><span style=3D"font-family:monospace,monospace">lttng-modu=
les-2.10.7/lttng-</span><span style=3D"font-family:monospace,monospace">rin=
g-buffer-client-discard.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-module=
s/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10=
.7/lttng-</span><span style=3D"font-family:monospace,monospace">ring-buffer=
-client-overwrite.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</sp=
an><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/ltt=
ng-</span><span style=3D"font-family:monospace,monospace">ring-buffer-metad=
ata-client.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><spa=
n style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</sp=
an><span style=3D"font-family:monospace,monospace">ring-buffer-client-mmap-=
</span><span style=3D"font-family:monospace,monospace">discard.o<br>=C2=A0 =
CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:=
monospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-=
family:monospace,monospace">ring-buffer-client-mmap-</span><span style=3D"f=
ont-family:monospace,monospace">overwrite.o<br>=C2=A0 CC [M]=C2=A0 /home/bu=
ilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace">=
lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace,mono=
space">ring-buffer-metadata-mmap-</span><span style=3D"font-family:monospac=
e,monospace">client.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</=
span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/l=
ttng-</span><span style=3D"font-family:monospace,monospace">clock.o<br>=C2=
=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-fam=
ily:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"f=
ont-family:monospace,monospace">events.o<br>=C2=A0 CC [M]=C2=A0 /home/build=
er/lttng-modules/</span><span style=3D"font-family:monospace,monospace">ltt=
ng-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace,monospa=
ce">abi.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span s=
tyle=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span>=
<span style=3D"font-family:monospace,monospace">string-utils.o<br>=C2=A0 CC=
 [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:mo=
nospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-fa=
mily:monospace,monospace">probes.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/ltt=
ng-modules/</span><span style=3D"font-family:monospace,monospace">lttng-mod=
ules-2.10.7/lttng-</span><span style=3D"font-family:monospace,monospace">co=
ntext.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span sty=
le=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><s=
pan style=3D"font-family:monospace,monospace">context-pid.o<br>=C2=A0 CC [M=
]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monos=
pace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-famil=
y:monospace,monospace">context-procname.o<br>=C2=A0 CC [M]=C2=A0 /home/buil=
der/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lt=
tng-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace,monosp=
ace">context-prio.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</sp=
an><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/ltt=
ng-</span><span style=3D"font-family:monospace,monospace">context-nice.o<br=
>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font=
-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=
=3D"font-family:monospace,monospace">context-vpid.o<br>=C2=A0 CC [M]=C2=A0 =
/home/builder/lttng-modules/</span><span style=3D"font-family:monospace,mon=
ospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monosp=
ace,monospace">context-tid.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-mod=
ules/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2=
.10.7/lttng-</span><span style=3D"font-family:monospace,monospace">context-=
vtid.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span styl=
e=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><sp=
an style=3D"font-family:monospace,monospace">context-ppid.o<br>=C2=A0 CC [M=
]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monos=
pace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-famil=
y:monospace,monospace">context-vppid.o<br>=C2=A0 CC [M]=C2=A0 /home/builder=
/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttng=
-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace,monospace=
">context-cpu-id.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</spa=
n><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttn=
g-</span><span style=3D"font-family:monospace,monospace">context-interrupti=
ble.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=
=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><spa=
n style=3D"font-family:monospace,monospace">context-need-reschedule.o<br>=
=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-=
family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=
=3D"font-family:monospace,monospace">calibrate.o<br>=C2=A0 CC [M]=C2=A0 /ho=
me/builder/lttng-modules/</span><span style=3D"font-family:monospace,monosp=
ace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace=
,monospace">context-hostname.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-m=
odules/</span><span style=3D"font-family:monospace,monospace">lttng-modules=
-2.10.7/wrapper/</span><span style=3D"font-family:monospace,monospace">rand=
om.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=
=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><sp=
an style=3D"font-family:monospace,monospace">lttng.o<br>=C2=A0 CC [M]=C2=A0=
 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace,mo=
nospace">lttng-modules-2.10.7/wrapper/</span><span style=3D"font-family:mon=
ospace,monospace">trace-clock.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-=
modules/</span><span style=3D"font-family:monospace,monospace">lttng-module=
s-2.10.7/wrapper/</span><span style=3D"font-family:monospace,monospace">pag=
e_alloc.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span s=
tyle=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span>=
<span style=3D"font-family:monospace,monospace">tracker-pid.o<br>=C2=A0 CC =
[M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:mon=
ospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-fam=
ily:monospace,monospace">filter.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttn=
g-modules/</span><span style=3D"font-family:monospace,monospace">lttng-modu=
les-2.10.7/lttng-</span><span style=3D"font-family:monospace,monospace">fil=
ter-interpreter.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span=
><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng=
-</span><span style=3D"font-family:monospace,monospace">filter-specialize.o=
<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"f=
ont-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span sty=
le=3D"font-family:monospace,monospace">filter-validator.o<br>=C2=A0 CC [M]=
=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monosp=
ace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-famil=
y:monospace,monospace">lttng-probe-user.o<br>=C2=A0 CC [M]=C2=A0 /home/buil=
der/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lt=
tng-modules-2.10.7/lttng-tp-</span><span style=3D"font-family:monospace,mon=
ospace">mempool.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span=
><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng=
-</span><span style=3D"font-family:monospace,monospace">syscalls.o<br>=C2=
=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-fam=
ily:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"f=
ont-family:monospace,monospace">context-perf-counters.o<br>=C2=A0 CC [M]=C2=
=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace=
,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:mo=
nospace,monospace">context-migratable.o<br>=C2=A0 CC [M]=C2=A0 /home/builde=
r/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttn=
g-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace,monospac=
e">context-preemptible.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules=
/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.=
7/lttng-</span><span style=3D"font-family:monospace,monospace">tracepoint.o=
<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"f=
ont-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span sty=
le=3D"font-family:monospace,monospace">tracer.o<br>=C2=A0 CC [M]=C2=A0 /hom=
e/builder/lttng-modules/</span><span style=3D"font-family:monospace,monospa=
ce">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace,=
monospace">statedump-impl.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modu=
les/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.=
10.7/wrapper/</span><span style=3D"font-family:monospace,monospace">irqdesc=
.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D=
"font-family:monospace,monospace">lttng-modules-2.10.7/wrapper/</span><span=
 style=3D"font-family:monospace,monospace">fdtable.o<br>=C2=A0 LD [M]=C2=A0=
 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace,mo=
nospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monos=
pace,monospace">statedump.o<br>find: &#39;/home/builder/lttng-modules/</spa=
n><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lib/=
../</span><span style=3D"font-family:monospace,monospace">extra_version/pat=
ches/&#39;: No such file or directory<br>=C2=A0 CC [M]=C2=A0 /home/builder/=
lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttng-=
modules-2.10.7/lib/</span><span style=3D"font-family:monospace,monospace">r=
ingbuffer/ring_buffer_</span><span style=3D"font-family:monospace,monospace=
">backend.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span=
 style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lib/</span>=
<span style=3D"font-family:monospace,monospace">ringbuffer/ring_buffer_</sp=
an><span style=3D"font-family:monospace,monospace">frontend.o<br>=C2=A0 CC =
[M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:mon=
ospace,monospace">lttng-modules-2.10.7/lib/</span><span style=3D"font-famil=
y:monospace,monospace">ringbuffer/ring_buffer_</span><span style=3D"font-fa=
mily:monospace,monospace">iterator.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/l=
ttng-modules/</span><span style=3D"font-family:monospace,monospace">lttng-m=
odules-2.10.7/lib/</span><span style=3D"font-family:monospace,monospace">ri=
ngbuffer/ring_buffer_vfs.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modul=
es/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.1=
0.7/lib/</span><span style=3D"font-family:monospace,monospace">ringbuffer/r=
ing_buffer_splice.</span><span style=3D"font-family:monospace,monospace">o<=
br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"fo=
nt-family:monospace,monospace">lttng-modules-2.10.7/lib/</span><span style=
=3D"font-family:monospace,monospace">ringbuffer/ring_buffer_mmap.o<br>=C2=
=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-fam=
ily:monospace,monospace">lttng-modules-2.10.7/lib/prio_</span><span style=
=3D"font-family:monospace,monospace">heap/lttng_prio_heap.o<br>=C2=A0 CC [M=
]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monos=
pace,monospace">lttng-modules-2.10.7/lib/../</span><span style=3D"font-fami=
ly:monospace,monospace">wrapper/splice.o<br>=C2=A0 LD [M]=C2=A0 /home/build=
er/lttng-modules/</span><span style=3D"font-family:monospace,monospace">ltt=
ng-modules-2.10.7/lib/</span><span style=3D"font-family:monospace,monospace=
">lttng-lib-ring-buffer.o<br>find: &#39;/home/builder/lttng-modules/</span>=
<span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes=
/..</span><span style=3D"font-family:monospace,monospace">/extra_version/pa=
tches/&#39;: No such file or directory<br>/home/builder/lttng-modules/</spa=
n><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/prob=
es/</span><span style=3D"font-family:monospace,monospace">Kbuild:41:
 File ./arch/x86/kvm/lapic.h not found. Probe &quot;kvm&quot; x86-specific =
is=20
disabled. Use full kernel source tree to enable it.<br>/home/builder/lttng-=
modules/</span><span style=3D"font-family:monospace,monospace">lttng-module=
s-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">Kbui=
ld:166: Files ./fs/btrfs/*.h not found. Probe &quot;btrfs&quot; is disabled=
. Use full kernel source tree to enable it.<br>/home/builder/lttng-modules/=
</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7=
/probes/</span><span style=3D"font-family:monospace,monospace">Kbuild:182: =
Files ./fs/ext4/*.h not found. Probe &quot;ext4&quot; is disabled. Use full=
 kernel source tree to enable it.<br>/home/builder/lttng-modules/</span><sp=
an style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</=
span><span style=3D"font-family:monospace,monospace">Kbuild:215:
 File ./drivers/base/regmap/trace.h not found. Probe &quot;regmap&quot; is=
=20
disabled. Need Linux 4.1+ kernel source tree to enable it.<br>/home/builder=
/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttng=
-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospac=
e">Kbuild:265: Files ./kernel/trace/trace.h not found. Probe &quot;ftrace&q=
uot; is disabled. Use full kernel source tree to enable it.<br>=C2=A0 CC [M=
]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monos=
pace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-fami=
ly:monospace,monospace">lttng-probe-sched.o<br>=C2=A0 CC [M]=C2=A0 /home/bu=
ilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace">=
lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,mon=
ospace">lttng-probe-irq.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-module=
s/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10=
.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-prob=
e-timer.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span s=
tyle=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span=
><span style=3D"font-family:monospace,monospace">lttng-probe-kmem.o<br>=C2=
=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-fam=
ily:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"=
font-family:monospace,monospace">lttng-probe-module.o<br>=C2=A0 CC [M]=C2=
=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace=
,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:m=
onospace,monospace">lttng-probe-power.o<br>=C2=A0 CC [M]=C2=A0 /home/builde=
r/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttn=
g-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospa=
ce">lttng-probe-statedump.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modu=
les/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.=
10.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-pr=
obe-i2c.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span s=
tyle=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span=
><span style=3D"font-family:monospace,monospace">lttng-probe-kvm.o<br>=C2=
=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-fam=
ily:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"=
font-family:monospace,monospace">lttng-probe-x86-irq-vectors.o<br>=C2=A0 CC=
 [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:mo=
nospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-f=
amily:monospace,monospace">lttng-probe-x86-exceptions.o<br>=C2=A0 CC [M]=C2=
=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace=
,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:m=
onospace,monospace">lttng-probe-signal.o<br>=C2=A0 CC [M]=C2=A0 /home/build=
er/lttng-modules/</span><span style=3D"font-family:monospace,monospace">ltt=
ng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,monosp=
ace">lttng-probe-block.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules=
/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.=
7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-probe=
-napi.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span sty=
le=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><=
span style=3D"font-family:monospace,monospace">lttng-probe-skb.o<br>=C2=A0 =
CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:=
monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font=
-family:monospace,monospace">lttng-probe-net.o<br>=C2=A0 CC [M]=C2=A0 /home=
/builder/lttng-modules/</span><span style=3D"font-family:monospace,monospac=
e">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,=
monospace">lttng-probe-sock.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-mo=
dules/</span><span style=3D"font-family:monospace,monospace">lttng-modules-=
2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-=
probe-udp.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span=
 style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</sp=
an><span style=3D"font-family:monospace,monospace">lttng-probe-asoc.o<br>=
=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-=
family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=
=3D"font-family:monospace,monospace">lttng-probe-gpio.o<br>=C2=A0 CC [M]=C2=
=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace=
,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:m=
onospace,monospace">lttng-probe-jbd2.o<br>=C2=A0 CC [M]=C2=A0 /home/builder=
/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttng=
-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospac=
e">lttng-probe-regulator.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modul=
es/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.1=
0.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-pro=
be-scsi.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span s=
tyle=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span=
><span style=3D"font-family:monospace,monospace">lttng-probe-vmscan.o<br>=
=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-=
family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=
=3D"font-family:monospace,monospace">lttng-probe-compaction.o<br>=C2=A0 CC =
[M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:mon=
ospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-fa=
mily:monospace,monospace">lttng-probe-printk.o<br>=C2=A0 CC [M]=C2=A0 /home=
/builder/lttng-modules/</span><span style=3D"font-family:monospace,monospac=
e">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,=
monospace">lttng-probe-random.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-=
modules/</span><span style=3D"font-family:monospace,monospace">lttng-module=
s-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">lttn=
g-probe-rcu.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><sp=
an style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</=
span><span style=3D"font-family:monospace,monospace">lttng-probe-sunrpc.o<b=
r>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"fon=
t-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span styl=
e=3D"font-family:monospace,monospace">lttng-probe-v4l2.o<br>=C2=A0 CC [M]=
=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monosp=
ace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-famil=
y:monospace,monospace">lttng-probe-workqueue.o<br>=C2=A0 CC [M]=C2=A0 /home=
/builder/lttng-modules/</span><span style=3D"font-family:monospace,monospac=
e">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,=
monospace">lttng-probe-writeback.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/ltt=
ng-modules/</span><span style=3D"font-family:monospace,monospace">lttng-mod=
ules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">l=
ttng-kprobes.o<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><s=
pan style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/<=
/span><span style=3D"font-family:monospace,monospace">lttng-kretprobes.o<br=
>find: &#39;/home/builder/lttng-modules/</span><span style=3D"font-family:m=
onospace,monospace">lttng-modules-2.10.7/tests/../</span><span style=3D"fon=
t-family:monospace,monospace">extra_version/patches/&#39;: No such file or =
directory<br>=C2=A0 CC [M]=C2=A0 /home/builder/lttng-modules/</span><span s=
tyle=3D"font-family:monospace,monospace">lttng-modules-2.10.7/tests/</span>=
<span style=3D"font-family:monospace,monospace">probes/lttng-test.o<br>=C2=
=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-fam=
ily:monospace,monospace">lttng-modules-2.10.7/tests/</span><span style=3D"f=
ont-family:monospace,monospace">lttng-test.o<br>=C2=A0 CC [M]=C2=A0 /home/b=
uilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace"=
>lttng-modules-2.10.7/tests/</span><span style=3D"font-family:monospace,mon=
ospace">clock-plugin/lttng-clock-</span><span style=3D"font-family:monospac=
e,monospace">plugin-test.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modul=
es/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.1=
0.7/tests/</span><span style=3D"font-family:monospace,monospace">lttng-cloc=
k-plugin-test.o<br>=C2=A0 Building modules, stage 2.<br>find: &#39;/home/bu=
ilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace">=
lttng-modules-2.10.7/extra_</span><span style=3D"font-family:monospace,mono=
space">version/patches/&#39;: No such file or directory<br>=C2=A0 MODPOST 4=
6 modules<br>WARNING: &quot;__migrate_disabled&quot; [/home/builder/lttng-m=
odules/</span><span style=3D"font-family:monospace,monospace">lttng-modules=
-2.10.7/lttng-</span><span style=3D"font-family:monospace,monospace">tracer=
.ko] undefined!<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lt=
tng-modules/</span><span style=3D"font-family:monospace,monospace">lttng-mo=
dules-2.10.7/lib/</span><span style=3D"font-family:monospace,monospace">ltt=
ng-lib-ring-buffer.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules=
/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.=
7/lib/</span><span style=3D"font-family:monospace,monospace">lttng-lib-ring=
-buffer.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-m=
odules/</span><span style=3D"font-family:monospace,monospace">lttng-modules=
-2.10.7/lttng-</span><span style=3D"font-family:monospace,monospace">clock.=
mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=
=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><spa=
n style=3D"font-family:monospace,monospace">clock.ko<br>=C2=A0 CC=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"fon=
t-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=
=3D"font-family:monospace,monospace">ring-buffer-client-discard.</span><spa=
n style=3D"font-family:monospace,monospace">mod.o<br>=C2=A0 LD [M]=C2=A0 /h=
ome/builder/lttng-modules/</span><span style=3D"font-family:monospace,monos=
pace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monospac=
e,monospace">ring-buffer-client-discard.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:=
monospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-=
family:monospace,monospace">ring-buffer-client-mmap-</span><span style=3D"f=
ont-family:monospace,monospace">discard.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/=
builder/lttng-modules/</span><span style=3D"font-family:monospace,monospace=
">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace,mo=
nospace">ring-buffer-client-mmap-</span><span style=3D"font-family:monospac=
e,monospace">discard.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/bu=
ilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace">=
lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace,mono=
space">ring-buffer-client-mmap-</span><span style=3D"font-family:monospace,=
monospace">overwrite.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modul=
es/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.1=
0.7/lttng-</span><span style=3D"font-family:monospace,monospace">ring-buffe=
r-client-mmap-</span><span style=3D"font-family:monospace,monospace">overwr=
ite.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modul=
es/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.1=
0.7/lttng-</span><span style=3D"font-family:monospace,monospace">ring-buffe=
r-client-overwrite.</span><span style=3D"font-family:monospace,monospace">m=
od.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=
=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><spa=
n style=3D"font-family:monospace,monospace">ring-buffer-client-overwrite.</=
span><span style=3D"font-family:monospace,monospace">ko<br>=C2=A0 CC=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"=
font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span st=
yle=3D"font-family:monospace,monospace">ring-buffer-metadata-client.</span>=
<span style=3D"font-family:monospace,monospace">mod.o<br>=C2=A0 LD [M]=C2=
=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace=
,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:mo=
nospace,monospace">ring-buffer-metadata-client.ko<br>=C2=A0 CC=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-f=
amily:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D=
"font-family:monospace,monospace">ring-buffer-metadata-mmap-</span><span st=
yle=3D"font-family:monospace,monospace">client.mod.o<br>=C2=A0 LD [M]=C2=A0=
 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace,mo=
nospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monos=
pace,monospace">ring-buffer-metadata-mmap-</span><span style=3D"font-family=
:monospace,monospace">client.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/home/builder/lttng-modules/</span><span style=3D"font-family:monospace,mon=
ospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monosp=
ace,monospace">statedump.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-m=
odules/</span><span style=3D"font-family:monospace,monospace">lttng-modules=
-2.10.7/lttng-</span><span style=3D"font-family:monospace,monospace">stated=
ump.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modul=
es/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.1=
0.7/lttng-</span><span style=3D"font-family:monospace,monospace">tracer.mod=
.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D=
"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span s=
tyle=3D"font-family:monospace,monospace">tracer.ko<br>=C2=A0 CC=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-f=
amily:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=
=3D"font-family:monospace,monospace">lttng-kprobes.mod.o<br>=C2=A0 LD [M]=
=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monosp=
ace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-famil=
y:monospace,monospace">lttng-kprobes.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:mon=
ospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-fa=
mily:monospace,monospace">lttng-kretprobes.mod.o<br>=C2=A0 LD [M]=C2=A0 /ho=
me/builder/lttng-modules/</span><span style=3D"font-family:monospace,monosp=
ace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospac=
e,monospace">lttng-kretprobes.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace,mo=
nospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:mono=
space,monospace">lttng-probe-asoc.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builde=
r/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttn=
g-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospa=
ce">lttng-probe-asoc.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/bu=
ilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace">=
lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,mon=
ospace">lttng-probe-block.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-=
modules/</span><span style=3D"font-family:monospace,monospace">lttng-module=
s-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">lttn=
g-probe-block.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/l=
ttng-modules/</span><span style=3D"font-family:monospace,monospace">lttng-m=
odules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace"=
>lttng-probe-compaction.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-mo=
dules/</span><span style=3D"font-family:monospace,monospace">lttng-modules-=
2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-=
probe-compaction.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builde=
r/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttn=
g-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospa=
ce">lttng-probe-gpio.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modul=
es/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.1=
0.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-pro=
be-gpio.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-m=
odules/</span><span style=3D"font-family:monospace,monospace">lttng-modules=
-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng=
-probe-i2c.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span>=
<span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes=
/</span><span style=3D"font-family:monospace,monospace">lttng-probe-i2c.ko<=
br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</sp=
an><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/pro=
bes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-irq.=
mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=
=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><sp=
an style=3D"font-family:monospace,monospace">lttng-probe-irq.ko<br>=C2=A0 C=
C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span st=
yle=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span>=
<span style=3D"font-family:monospace,monospace">lttng-probe-jbd2.mod.o<br>=
=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-=
family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=
=3D"font-family:monospace,monospace">lttng-probe-jbd2.ko<br>=C2=A0 CC=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"=
font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span s=
tyle=3D"font-family:monospace,monospace">lttng-probe-kmem.mod.o<br>=C2=A0 L=
D [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:m=
onospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-=
family:monospace,monospace">lttng-probe-kmem.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-fami=
ly:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"f=
ont-family:monospace,monospace">lttng-probe-kvm.mod.o<br>=C2=A0 LD [M]=C2=
=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace=
,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:m=
onospace,monospace">lttng-probe-kvm.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monosp=
ace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-famil=
y:monospace,monospace">lttng-probe-module.mod.o<br>=C2=A0 LD [M]=C2=A0 /hom=
e/builder/lttng-modules/</span><span style=3D"font-family:monospace,monospa=
ce">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace=
,monospace">lttng-probe-module.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace=
,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:m=
onospace,monospace">lttng-probe-napi.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/bui=
lder/lttng-modules/</span><span style=3D"font-family:monospace,monospace">l=
ttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,mono=
space">lttng-probe-napi.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home=
/builder/lttng-modules/</span><span style=3D"font-family:monospace,monospac=
e">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,=
monospace">lttng-probe-net.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng=
-modules/</span><span style=3D"font-family:monospace,monospace">lttng-modul=
es-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">ltt=
ng-probe-net.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lt=
tng-modules/</span><span style=3D"font-family:monospace,monospace">lttng-mo=
dules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">=
lttng-probe-power.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/=
</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7=
/probes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-=
power.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-mod=
ules/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2=
.10.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-p=
robe-printk.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span=
><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probe=
s/</span><span style=3D"font-family:monospace,monospace">lttng-probe-printk=
.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/=
</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7=
/probes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-=
random.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><spa=
n style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</s=
pan><span style=3D"font-family:monospace,monospace">lttng-probe-random.ko<b=
r>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</spa=
n><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/prob=
es/</span><span style=3D"font-family:monospace,monospace">lttng-probe-rcu.m=
od.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=
=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><sp=
an style=3D"font-family:monospace,monospace">lttng-probe-rcu.ko<br>=C2=A0 C=
C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span st=
yle=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span>=
<span style=3D"font-family:monospace,monospace">lttng-probe-regulator.mod.o=
<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"f=
ont-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span st=
yle=3D"font-family:monospace,monospace">lttng-probe-regulator.ko<br>=C2=A0 =
CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span s=
tyle=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span=
><span style=3D"font-family:monospace,monospace">lttng-probe-sched.mod.o<br=
>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font=
-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=
=3D"font-family:monospace,monospace">lttng-probe-sched.ko<br>=C2=A0 CC=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span style=
=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><sp=
an style=3D"font-family:monospace,monospace">lttng-probe-scsi.mod.o<br>=C2=
=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-fam=
ily:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"=
font-family:monospace,monospace">lttng-probe-scsi.ko<br>=C2=A0 CC=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"fon=
t-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span styl=
e=3D"font-family:monospace,monospace">lttng-probe-signal.mod.o<br>=C2=A0 LD=
 [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:mo=
nospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-f=
amily:monospace,monospace">lttng-probe-signal.ko<br>=C2=A0 CC=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-f=
amily:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=
=3D"font-family:monospace,monospace">lttng-probe-skb.mod.o<br>=C2=A0 LD [M]=
=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monosp=
ace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-famil=
y:monospace,monospace">lttng-probe-skb.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:mon=
ospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-fa=
mily:monospace,monospace">lttng-probe-sock.mod.o<br>=C2=A0 LD [M]=C2=A0 /ho=
me/builder/lttng-modules/</span><span style=3D"font-family:monospace,monosp=
ace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospac=
e,monospace">lttng-probe-sock.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace,mo=
nospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:mono=
space,monospace">lttng-probe-statedump.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/b=
uilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace"=
>lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,mo=
nospace">lttng-probe-statedump.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /home/builder/lttng-modules/</span><span style=3D"font-family:monospace=
,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:m=
onospace,monospace">lttng-probe-sunrpc.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/b=
uilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace"=
>lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,mo=
nospace">lttng-probe-sunrpc.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
home/builder/lttng-modules/</span><span style=3D"font-family:monospace,mono=
space">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monosp=
ace,monospace">lttng-probe-timer.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder=
/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttng=
-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospac=
e">lttng-probe-timer.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/bu=
ilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace">=
lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,mon=
ospace">lttng-probe-udp.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-mo=
dules/</span><span style=3D"font-family:monospace,monospace">lttng-modules-=
2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-=
probe-udp.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng=
-modules/</span><span style=3D"font-family:monospace,monospace">lttng-modul=
es-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">ltt=
ng-probe-v4l2.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</sp=
an><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/pro=
bes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-v4l2=
.ko<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/=
</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7=
/probes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-=
vmscan.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><spa=
n style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</s=
pan><span style=3D"font-family:monospace,monospace">lttng-probe-vmscan.ko<b=
r>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</spa=
n><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/prob=
es/</span><span style=3D"font-family:monospace,monospace">lttng-probe-workq=
ueue.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span =
style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</spa=
n><span style=3D"font-family:monospace,monospace">lttng-probe-workqueue.ko<=
br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</sp=
an><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/pro=
bes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-writ=
eback.mod.o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span=
 style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</sp=
an><span style=3D"font-family:monospace,monospace">lttng-probe-writeback.ko=
<br>=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</s=
pan><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/pr=
obes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-x86=
-exceptions.</span><span style=3D"font-family:monospace,monospace">mod.o<br=
>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font=
-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=
=3D"font-family:monospace,monospace">lttng-probe-x86-exceptions.ko<br>=C2=
=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><sp=
an style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</=
span><span style=3D"font-family:monospace,monospace">lttng-probe-x86-irq-ve=
ctors.</span><span style=3D"font-family:monospace,monospace">mod.o<br>=C2=
=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-fam=
ily:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"=
font-family:monospace,monospace">lttng-probe-x86-irq-vectors.ko<br>=C2=A0 C=
C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><span st=
yle=3D"font-family:monospace,monospace">lttng-modules-2.10.7/tests/</span><=
span style=3D"font-family:monospace,monospace">lttng-clock-plugin-test.mod.=
o<br>=C2=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"=
font-family:monospace,monospace">lttng-modules-2.10.7/tests/</span><span st=
yle=3D"font-family:monospace,monospace">lttng-clock-plugin-test.ko<br>=C2=
=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /home/builder/lttng-modules/</span><sp=
an style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/tests/</s=
pan><span style=3D"font-family:monospace,monospace">lttng-test.mod.o<br>=C2=
=A0 LD [M]=C2=A0 /home/builder/lttng-modules/</span><span style=3D"font-fam=
ily:monospace,monospace">lttng-modules-2.10.7/tests/</span><span style=3D"f=
ont-family:monospace,monospace">lttng-test.ko<br>make[3]: Leaving directory=
 &#39;/usr/src/linux-headers-4.14.</span><span style=3D"font-family:monospa=
ce,monospace">59-rt37+&#39;<br>make[2]: Leaving directory &#39;/home/builde=
r/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttn=
g-modules-2.10.7&#39;<br>make[1]: Leaving directory &#39;/home/builder/lttn=
g-modules/</span><span style=3D"font-family:monospace,monospace">lttng-modu=
les-2.10.7&#39;<br>=C2=A0=C2=A0 dh_auto_test -O--=3DKERNELDIR=3D/usr/src/li=
nux-</span><span style=3D"font-family:monospace,monospace">headers-4.14.59-=
rt37\+<br>=C2=A0=C2=A0 create-stamp debian/debhelper-build-stamp<br>=C2=A0d=
ebian/rules binary<br>dh binary -- KERNELDIR=3D&quot;/usr/src/linux-</span>=
<span style=3D"font-family:monospace,monospace">headers-4.14.59-rt37+&quot;=
<br>=C2=A0=C2=A0 create-stamp debian/debhelper-build-stamp<br>=C2=A0=C2=A0 =
dh_testroot -O--=3DKERNELDIR=3D/usr/src/linux-</span><span style=3D"font-fa=
mily:monospace,monospace">headers-4.14.59-rt37\+<br>=C2=A0=C2=A0 dh_prep -O=
--=3DKERNELDIR=3D/usr/src/linux-</span><span style=3D"font-family:monospace=
,monospace">headers-4.14.59-rt37\+<br>=C2=A0=C2=A0 dh_installdirs -O--=3DKE=
RNELDIR=3D/usr/src/linux-</span><span style=3D"font-family:monospace,monosp=
ace">headers-4.14.59-rt37\+<br>=C2=A0=C2=A0 debian/rules override_dh_auto_i=
nstall<br>make[1]: Entering directory &#39;/home/builder/lttng-modules/</sp=
an><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7&#39=
;<br>mkdir installed-modules<br>/usr/bin/make KERNELDIR=3D&quot;/usr/src/li=
nux-</span><span style=3D"font-family:monospace,monospace">headers-4.14.59-=
rt37+&quot; modules_install &amp;&amp; cp -a /lib/modules/*/extra/* /home/b=
uilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace"=
>lttng-modules-2.10.7/</span><span style=3D"font-family:monospace,monospace=
">installed-modules<br>make[2]: Entering directory &#39;/home/builder/lttng=
-modules/</span><span style=3D"font-family:monospace,monospace">lttng-modul=
es-2.10.7&#39;<br>/usr/bin/make -C /usr/src/linux-headers-4.14.</span><span=
 style=3D"font-family:monospace,monospace">59-rt37+ M=3D/home/builder/lttng=
-modules/</span><span style=3D"font-family:monospace,monospace">lttng-modul=
es-2.10.7 CONFIG_LTTNG=3Dm CONFIG_LTTNG_CLOCK_PLUGIN_</span><span style=3D"=
font-family:monospace,monospace">TEST=3Dm modules_install<br>make[3]: Enter=
ing directory &#39;/usr/src/linux-headers-4.14.</span><span style=3D"font-f=
amily:monospace,monospace">59-rt37+&#39;<br>=C2=A0 INSTALL /home/builder/lt=
tng-modules/</span><span style=3D"font-family:monospace,monospace">lttng-mo=
dules-2.10.7/lib/</span><span style=3D"font-family:monospace,monospace">ltt=
ng-lib-ring-buffer.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span>=
<span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-=
</span><span style=3D"font-family:monospace,monospace">clock.ko<br>=C2=A0 I=
NSTALL /home/builder/lttng-modules/</span><span style=3D"font-family:monosp=
ace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family=
:monospace,monospace">ring-buffer-client-discard.ko<br>=C2=A0 INSTALL /home=
/builder/lttng-modules/</span><span style=3D"font-family:monospace,monospac=
e">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace,m=
onospace">ring-buffer-client-mmap-</span><span style=3D"font-family:monospa=
ce,monospace">discard.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</sp=
an><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/ltt=
ng-</span><span style=3D"font-family:monospace,monospace">ring-buffer-clien=
t-mmap-</span><span style=3D"font-family:monospace,monospace">overwrite.ko<=
br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D"font-fa=
mily:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span style=3D"=
font-family:monospace,monospace">ring-buffer-client-overwrite.</span><span =
style=3D"font-family:monospace,monospace">ko<br>=C2=A0 INSTALL /home/builde=
r/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttn=
g-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace,monospac=
e">ring-buffer-metadata-client.ko<br>=C2=A0 INSTALL /home/builder/lttng-mod=
ules/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2=
.10.7/lttng-</span><span style=3D"font-family:monospace,monospace">ring-buf=
fer-metadata-mmap-</span><span style=3D"font-family:monospace,monospace">cl=
ient.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D=
"font-family:monospace,monospace">lttng-modules-2.10.7/lttng-</span><span s=
tyle=3D"font-family:monospace,monospace">statedump.ko<br>=C2=A0 INSTALL /ho=
me/builder/lttng-modules/</span><span style=3D"font-family:monospace,monosp=
ace">lttng-modules-2.10.7/lttng-</span><span style=3D"font-family:monospace=
,monospace">tracer.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span>=
<span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes=
/</span><span style=3D"font-family:monospace,monospace">lttng-kprobes.ko<br=
>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D"font-fami=
ly:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"f=
ont-family:monospace,monospace">lttng-kretprobes.ko<br>=C2=A0 INSTALL /home=
/builder/lttng-modules/</span><span style=3D"font-family:monospace,monospac=
e">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,=
monospace">lttng-probe-asoc.ko<br>=C2=A0 INSTALL /home/builder/lttng-module=
s/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10=
.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-prob=
e-block.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=
=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><sp=
an style=3D"font-family:monospace,monospace">lttng-probe-compaction.ko<br>=
=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D"font-famil=
y:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"fo=
nt-family:monospace,monospace">lttng-probe-gpio.ko<br>=C2=A0 INSTALL /home/=
builder/lttng-modules/</span><span style=3D"font-family:monospace,monospace=
">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,m=
onospace">lttng-probe-i2c.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/=
</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7=
/probes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-=
irq.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D"=
font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span s=
tyle=3D"font-family:monospace,monospace">lttng-probe-jbd2.ko<br>=C2=A0 INST=
ALL /home/builder/lttng-modules/</span><span style=3D"font-family:monospace=
,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:m=
onospace,monospace">lttng-probe-kmem.ko<br>=C2=A0 INSTALL /home/builder/ltt=
ng-modules/</span><span style=3D"font-family:monospace,monospace">lttng-mod=
ules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">l=
ttng-probe-kvm.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><spa=
n style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</s=
pan><span style=3D"font-family:monospace,monospace">lttng-probe-module.ko<b=
r>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D"font-fam=
ily:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"=
font-family:monospace,monospace">lttng-probe-napi.ko<br>=C2=A0 INSTALL /hom=
e/builder/lttng-modules/</span><span style=3D"font-family:monospace,monospa=
ce">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace=
,monospace">lttng-probe-net.ko<br>=C2=A0 INSTALL /home/builder/lttng-module=
s/</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10=
.7/probes/</span><span style=3D"font-family:monospace,monospace">lttng-prob=
e-power.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=
=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><sp=
an style=3D"font-family:monospace,monospace">lttng-probe-printk.ko<br>=C2=
=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D"font-family:m=
onospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-=
family:monospace,monospace">lttng-probe-random.ko<br>=C2=A0 INSTALL /home/b=
uilder/lttng-modules/</span><span style=3D"font-family:monospace,monospace"=
>lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,mo=
nospace">lttng-probe-rcu.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/<=
/span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/=
probes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-r=
egulator.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span styl=
e=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><s=
pan style=3D"font-family:monospace,monospace">lttng-probe-sched.ko<br>=C2=
=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D"font-family:m=
onospace,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-=
family:monospace,monospace">lttng-probe-scsi.ko<br>=C2=A0 INSTALL /home/bui=
lder/lttng-modules/</span><span style=3D"font-family:monospace,monospace">l=
ttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,mono=
space">lttng-probe-signal.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/=
</span><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7=
/probes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-=
skb.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D"=
font-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span s=
tyle=3D"font-family:monospace,monospace">lttng-probe-sock.ko<br>=C2=A0 INST=
ALL /home/builder/lttng-modules/</span><span style=3D"font-family:monospace=
,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:m=
onospace,monospace">lttng-probe-statedump.ko<br>=C2=A0 INSTALL /home/builde=
r/lttng-modules/</span><span style=3D"font-family:monospace,monospace">lttn=
g-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,monospa=
ce">lttng-probe-sunrpc.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</s=
pan><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/pr=
obes/</span><span style=3D"font-family:monospace,monospace">lttng-probe-tim=
er.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D"f=
ont-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span st=
yle=3D"font-family:monospace,monospace">lttng-probe-udp.ko<br>=C2=A0 INSTAL=
L /home/builder/lttng-modules/</span><span style=3D"font-family:monospace,m=
onospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:mon=
ospace,monospace">lttng-probe-v4l2.ko<br>=C2=A0 INSTALL /home/builder/lttng=
-modules/</span><span style=3D"font-family:monospace,monospace">lttng-modul=
es-2.10.7/probes/</span><span style=3D"font-family:monospace,monospace">ltt=
ng-probe-vmscan.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><sp=
an style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/probes/</=
span><span style=3D"font-family:monospace,monospace">lttng-probe-workqueue.=
ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</span><span style=3D"font=
-family:monospace,monospace">lttng-modules-2.10.7/probes/</span><span style=
=3D"font-family:monospace,monospace">lttng-probe-writeback.ko<br>=C2=A0 INS=
TALL /home/builder/lttng-modules/</span><span style=3D"font-family:monospac=
e,monospace">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:=
monospace,monospace">lttng-probe-x86-exceptions.ko<br>=C2=A0 INSTALL /home/=
builder/lttng-modules/</span><span style=3D"font-family:monospace,monospace=
">lttng-modules-2.10.7/probes/</span><span style=3D"font-family:monospace,m=
onospace">lttng-probe-x86-irq-vectors.ko<br>=C2=A0 INSTALL /home/builder/lt=
tng-modules/</span><span style=3D"font-family:monospace,monospace">lttng-mo=
dules-2.10.7/tests/</span><span style=3D"font-family:monospace,monospace">l=
ttng-clock-plugin-test.ko<br>=C2=A0 INSTALL /home/builder/lttng-modules/</s=
pan><span style=3D"font-family:monospace,monospace">lttng-modules-2.10.7/te=
sts/</span><span style=3D"font-family:monospace,monospace">lttng-test.ko<br=
>=C2=A0 DEPMOD=C2=A0 4.14.59-rt37+</span></div><div dir=3D"ltr"><span style=
=3D"font-family:monospace,monospace">------------------------------</span><=
span style=3D"font-family:monospace,monospace">----------------------------=
--</span><span style=3D"font-family:monospace,monospace">------------------=
------------</span><span style=3D"font-family:monospace,monospace">-------<=
/span></div><div dir=3D"ltr"><span style=3D"font-family:monospace,monospace=
"><br></span></div><div><span style=3D"font-family:monospace,monospace">The=
 same version of modules builds fine with &quot;Linux-4.9.x-rt&quot;. Also =
the kconfig of lttng is designed as &quot;Tristate&quot; and the build erro=
r is seen when we build with &quot;built-in.sh &lt;KERNEL_SRC&gt;&quot; and=
 CONFIG_LTTNG=3Dm in kernel menuconfig.<br></span></div><div><span style=3D=
"font-family:monospace,monospace"><br></span></div><div><span style=3D"font=
-family:monospace,monospace">Anyone has seen the issue with the RT kernels =
&gt;=3D 4.14 ?=C2=A0 Appreciate your inputs. <br></span></div><div><span st=
yle=3D"font-family:monospace,monospace"><br></span></div><div><span style=
=3D"font-family:monospace,monospace">Thanks,</span></div><div><span style=
=3D"font-family:monospace,monospace">Srikanth</span></div></div></div></div=
>

--00000000000076bef10576156a67--

--===============5744341657904167320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5744341657904167320==--
