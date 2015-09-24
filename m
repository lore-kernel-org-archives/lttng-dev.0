From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.7.0 (Linux user-space tracer)
Date: Thu, 24 Sep 2015 21:39:48 +0000 (UTC)
Message-ID: <2085167955.4275.1443130788530.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org, LKML <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I hereby announce the release of LTTng-UST 2.7.0. LTTng-UST is a
low-overhead application tracer for Linux. The library "liblttng-ust"
enables tracing of applications and libraries.

Here is what is new and noteworthy in LTTng-UST 2.7:


* tracelog() instrumentation facility. Excerpt from lttng-ust(3):

USAGE WITH TRACELOG
       If you want to migrate existing logging (info, errors, ...)   to=
  LTTng
       UST, you can use the tracelog() interface.  To do it, in a nutsh=
ell:

       1) #include <lttng/tracelog.h>

       2) /* in your code, use like a printf, with extra loglevel info.=
 */
          tracelog(TRACE_INFO, "Message with integer %d", 1234);

       3) Link your program against liblttng-ust.so.

       4)  Enable  UST events when tracing with the following sequence =
of com=E2=80=90
       mands
          from lttng-tools:

          lttng create
          lttng enable-event -u "lttng_ust_tracelog:*"
          lttng start
          [... run your program ...]
          lttng stop
          lttng view

       That's it!

       You can replace  the  enable-event  line  above  with  a  select=
ion  of
       loglevels, e.g.:

          lttng enable-event -u -a --loglevel TRACE_INFO

       Which  will  gather  all  events  from  TRACE_INFO  and  more im=
portant
       loglevels.


* File-backed user space buffers

This feature allows mapping ring buffer into filesystems. Useful in com=
bination
with pramfs or DAX+pmem (kernels 4.0+ for DAX and 4.1+ for pmem) to kee=
p tracer
ring buffers around in persistent memory upon system reboot.

These buffers can be salvaged and converted to regular CTF traces using=
 the
newly introduced lttng-crash utility to see the events that led to a cr=
ash.

How to use it:

[ mount dax-enabled FS backed by pmem block device... ]

$ lttng create my_session --shm-path=3D/path/to/dax/fs/
$ lttng enable-event --userspace --all
$ lttng start
[ do some UST tracing ]

[ run kexec to reboot, mount dax-enabled FS again... ]

# View or convert trace to CTF with lttng-crash:

$ lttng-crash /path/to/dax/fs/my_session*


* Process ID (PID) tracker

The new "track" and "untrack" commands allows the tracking of events as=
sociated
with specific PIDs, both in user space and kernel space.

=46or example, the following commands may be used to track all user spa=
ce events
of PID "1234":
$ lttng create my_session
$ lttng track --userspace --pid 1234
$ lttng enable-event --userspace --all
$ lttng start


* Python logging support

=46ollowing in the footsteps of the Java Util Logging and Log4J logging=
 backend
support, which were introduced as part of LTTng 2.4 and LTTng 2.6 respe=
ctively,
this new version adds support for the Python logging backend. This mean=
s that
logging statements emitted by the Python logging module can now be coll=
ected as
part of user space traces by enabling events from the "python" domain.

$ lttng create my_session
$ lttng enable-event --python --all
$ lttng start

The lttngust Python module is provided as part of LTTng-UST 2.7.
https://github.com/lttng/lttng-ust/tree/master/liblttng-ust-python-agen=
t


* getcpu and clock plugin support.

In the interest of keeping LTTng as unintrusive as possible, LTTng 2.7
introduces support for platform-specific plug-ins providing custom
implementations of getcpu() (user space) and clock sources for both ker=
nel and
user space tracers.

getcpu override plugins can prove useful in cases where direct hardware=
 access
is available for architecture-specific registers storing the CPU number=
, and
where those should be used instead of the Linux kernel sched_getcpu()
vDSO/syscall.

Clock override plugins, which may be implemented as shared objects (use=
r space)
or kernel modules (kernel space) may prove useful in cases where direct
hardware access to architecture-specific clocks is available, and when =
it should
be used in place of the Linux kernel Monotonic clock.


Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog since 2.7.0-rc2:

2015-09-24 lttng-ust 2.7.0
        * Fix: don't dereference NULL pointers
        * Cleanup: Remove unused values
        * Fix: Value stored to 'has_waited' is never read
        * Fix: Argument with 'nonnull' attribute passed null
        * Cleanup: Unnecessary bit shift
        * Fix: sysconf() unchecked return value
        * doc: add Python example
        * Fix: Python agent: do not register twice to same port

Enjoy this release!

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
