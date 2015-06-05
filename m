From: Thomas Bertauld <thomas.bertauld@gmail.com>
Subject: Re: LTTng-modules install failed on a Parallella
Date: Fri, 5 Jun 2015 11:30:23 -0400
Message-ID: <CALzKSt57FF+J2cvcWE96W0CQ1ZU0=yjMY6PYYBAa5ULwsPW4wg__39561.684386763$1433518315$gmane$org@mail.gmail.com>
References: <CALzKSt7AhA=gTrpzGyk-dNG7jMfKHP=kgjbgcEgY4Hfg31g9og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1551914191=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thomas.bertauld@gmail.com>) id 1Z0tZi-0003pe-U6
 for lttng-dev@lists.lttng.org; Fri, 05 Jun 2015 11:30:37 -0400
Received: by oihb142 with SMTP id b142so55727657oih.3
 for <lttng-dev@lists.lttng.org>; Fri, 05 Jun 2015 08:30:23 -0700 (PDT)
In-Reply-To: <CALzKSt7AhA=gTrpzGyk-dNG7jMfKHP=kgjbgcEgY4Hfg31g9og@mail.gmail.com>
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

--===============1551914191==
Content-Type: multipart/alternative; boundary=001a11c2fe647dc4320517c6f86d

--001a11c2fe647dc4320517c6f86d
Content-Type: text/plain; charset=UTF-8

Hi !

While solving my problem (I had to rebuild the kernel since there were some
configurations file for the modules missing and I didn't have access to the
headers of the distribution in the repositories), I encoutered what seemed
to be an incompatibility between the lttng-modules "block.h" code and some
of the libraries of the 3.14.12 kernel, especially with the bio struct (see
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=748953).

In fact, even after applying the "blktrace-test.patch" (
https://bugs.launchpad.net/ubuntu/+source/lttng-modules/+bug/1328335) there
were still problems with the use of "bio->bi_sector" in the "block.h" code.
So I made a little patch correcting the use of the structure, and now
everything work fine :

--- a/instrumentation/events/lttng-module/block.h
+++ b/instrumentation/events/lttng-module/block.h
@@ -221,6 +221,62 @@
     TP_ARGS(q, rq)
 )

+#ifdef CONFIG_VERSION_SIGNATURE
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,5)    \
+    || LTTNG_KERNEL_RANGE(3,12,21, 3,13,0)        \
+    || LTTNG_KERNEL_RANGE(3,10,41, 3,11,0)        \
+    || LTTNG_KERNEL_RANGE(3,4,91, 3,5,0)        \
+    || LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))
+
+/**
+ * block_rq_complete - block IO operation completed by device driver
+ * @q: queue containing the block operation request
+ * @rq: block operations request
+ * @nr_bytes: number of completed bytes
+ *
+ * The block_rq_complete tracepoint event indicates that some portion
+ * of operation request has been completed by the device driver.  If
+ * the @rq->bio is %NULL, then there is absolutely no additional work to
+ * do for the request. If @rq->bio is non-NULL then there is
+ * additional work required to complete the request.
+ */
+TRACE_EVENT(block_rq_complete,
+
+    TP_PROTO(struct request_queue *q, struct request *rq,
+         unsigned int nr_bytes),
+
+    TP_ARGS(q, rq, nr_bytes),
+
+    TP_STRUCT__entry(
+        __field(  dev_t,    dev            )
+        __field(  sector_t,    sector            )
+        __field(  unsigned int,    nr_sector        )
+        __field(  int,        errors            )
+        __field(  unsigned int,    rwbs            )
+        __dynamic_array_hex( unsigned char,    cmd,
+            (rq->cmd_type == REQ_TYPE_BLOCK_PC) ?
+                rq->cmd_len : 0)
+    ),
+
+    TP_fast_assign(
+        tp_assign(dev, rq->rq_disk ? disk_devt(rq->rq_disk) : 0)
+        tp_assign(sector, blk_rq_pos(rq))
+        tp_assign(nr_sector, nr_bytes >> 9)
+        tp_assign(errors, rq->errors)
+        blk_fill_rwbs(rwbs, rq->cmd_flags, nr_bytes)
+        tp_memcpy_dyn(cmd, (rq->cmd_type == REQ_TYPE_BLOCK_PC) ?
+                    rq->cmd : NULL)
+    ),
+
+    TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+          MAJOR(__entry->dev), MINOR(__entry->dev),
+          __entry->rwbs, __get_str(cmd),
+          (unsigned long long)__entry->sector,
+          __entry->nr_sector, __entry->errors)
+)
+
+#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)) */
+
 /**
  * block_rq_complete - block IO operation completed by device driver
  * @q: queue containing the block operation request
@@ -239,6 +295,8 @@
     TP_ARGS(q, rq)
 )

+#endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)) */
+
 DECLARE_EVENT_CLASS(block_rq,

     TP_PROTO(struct request_queue *q, struct request *rq),
@@ -341,9 +399,9 @@
     TP_fast_assign(
         tp_assign(dev, bio->bi_bdev ?
                       bio->bi_bdev->bd_dev : 0)
-        tp_assign(sector, bio->bi_sector)
-        tp_assign(nr_sector, bio->bi_size >> 9)
-        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
+        tp_assign(sector, bio->bi_iter.bi_sector)
+        tp_assign(nr_sector, bio->bi_iter.bi_size >> 9)
+        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
         tp_memcpy(comm, current->comm, TASK_COMM_LEN)
     ),

@@ -385,14 +443,14 @@

     TP_fast_assign(
         tp_assign(dev, bio->bi_bdev->bd_dev)
-        tp_assign(sector, bio->bi_sector)
-        tp_assign(nr_sector, bio->bi_size >> 9)
+        tp_assign(sector, bio->bi_iter.bi_sector)
+        tp_assign(nr_sector, bio->bi_iter.bi_size >> 9)
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
         tp_assign(error, error)
 #else
         tp_assign(error, 0)
 #endif
-        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
+        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
     ),

     TP_printk("%d,%d %s %llu + %u [%d]",
@@ -419,9 +477,9 @@

     TP_fast_assign(
         tp_assign(dev, bio->bi_bdev->bd_dev)
-        tp_assign(sector, bio->bi_sector)
-        tp_assign(nr_sector, bio->bi_size >> 9)
-        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
+        tp_assign(sector, bio->bi_iter.bi_sector)
+        tp_assign(nr_sector, bio->bi_iter.bi_size >> 9)
+        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
         tp_memcpy(comm, current->comm, TASK_COMM_LEN)
     ),

@@ -485,9 +543,9 @@

     TP_fast_assign(
         tp_assign(dev, bio->bi_bdev->bd_dev)
-        tp_assign(sector, bio->bi_sector)
-        tp_assign(nr_sector, bio->bi_size >> 9)
-        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
+        tp_assign(sector, bio->bi_iter.bi_sector)
+        tp_assign(nr_sector, bio->bi_iter.bi_size >> 9)
+        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
         tp_memcpy(comm, current->comm, TASK_COMM_LEN)
     ),

@@ -513,9 +571,9 @@

     TP_fast_assign(
         tp_assign(dev, bio->bi_bdev ? bio->bi_bdev->bd_dev : 0)
-        tp_assign(sector, bio->bi_sector)
-        tp_assign(nr_sector, bio->bi_size >> 9)
-        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
+        tp_assign(sector, bio->bi_iter.bi_sector)
+        tp_assign(nr_sector, bio->bi_iter.bi_size >> 9)
+        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
         tp_memcpy(comm, current->comm, TASK_COMM_LEN)
     ),

@@ -587,10 +645,10 @@

     TP_fast_assign(
         tp_assign(dev, bio ? bio->bi_bdev->bd_dev : 0)
-        tp_assign(sector, bio ? bio->bi_sector : 0)
-        tp_assign(nr_sector, bio ? bio->bi_size >> 9 : 0)
+        tp_assign(sector, bio ? bio->bi_iter.bi_sector : 0)
+        tp_assign(nr_sector, bio ? bio->bi_iter.bi_size >> 9 : 0)
         blk_fill_rwbs(rwbs, bio ? bio->bi_rw : 0,
-                  bio ? bio->bi_size >> 9 : 0)
+                  bio ? bio->bi_iter.bi_size >> 9 : 0)
         tp_memcpy(comm, current->comm, TASK_COMM_LEN)
         ),

@@ -759,9 +817,9 @@

     TP_fast_assign(
         tp_assign(dev, bio->bi_bdev->bd_dev)
-        tp_assign(sector, bio->bi_sector)
+        tp_assign(sector, bio->bi_iter.bi_sector)
         tp_assign(new_sector, new_sector)
-        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
+        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
         tp_memcpy(comm, current->comm, TASK_COMM_LEN)
     ),

@@ -805,11 +863,11 @@

     TP_fast_assign(
         tp_assign(dev, bio->bi_bdev->bd_dev)
-        tp_assign(sector, bio->bi_sector)
-        tp_assign(nr_sector, bio->bi_size >> 9)
+        tp_assign(sector, bio->bi_iter.bi_sector)
+        tp_assign(nr_sector, bio->bi_iter.bi_size >> 9)
         tp_assign(old_dev, dev)
         tp_assign(old_sector, from)
-        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_size)
+        blk_fill_rwbs(rwbs, bio->bi_rw, bio->bi_iter.bi_size)
     ),

     TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu",

Maybe it already was a known issue I'm not aware of and in this case i'm
sorry for the long post, otherwise i hope it can be useful for some people !

Regards,

Thomas.

2015-05-20 16:31 GMT-04:00 Thomas Bertauld <thomas.bertauld@gmail.com>:

> Hi !
>
> I recently began to work on a Parallella board and I wanted to try tracing
> the ARM processor with LTTng before doing ant work with the Epiphany chip
> (co-processor).
>
> Nevertheless, i'm stuck with an error anytime i try to install the
> lttng-modules. I've tried installing it from the official repositories and
> from the PPA but none worked.
>
> For now i only tried with the headless version of Ubuntu 14.04 (
> http://www.parallella.org/create-sdcard/) for the Zynq-7010 (the
> processor itself is a ARM Cortex A9).
>
> The kernel version is 3.14.12, as seen in the error message below
>
>
> parallella@parallella:~$ sudo apt-get install lttng-modules-dkms
> Reading package lists... Done
> Building dependency tree
> Reading state information... Done
> The following extra packages will be installed:
>   dkms
> The following NEW packages will be installed:
>   dkms lttng-modules-dkms
> 0 upgraded, 2 newly installed, 0 to remove and 1 not upgraded.
> Need to get 286 kB of archives.
> After this operation, 2816 kB of additional disk space will be used.
> Do you want to continue? [Y/n]
> Get:1 http://ports.ubuntu.com/ trusty-updates/main dkms all
> 2.2.0.3-1.1ubuntu5.14.04 [64.6 kB]
> Get:2 http://ports.ubuntu.com/ trusty-updates/universe lttng-modules-dkms
> all 2.4.0-1ubuntu1.1 [221 kB]
> Fetched 286 kB in 0s (356 kB/s)
> Selecting previously unselected package dkms.
> (Reading database ... 39070 files and directories currently installed.)
> Preparing to unpack .../dkms_2.2.0.3-1.1ubuntu5.14.04_all.deb ...
> Unpacking dkms (2.2.0.3-1.1ubuntu5.14.04) ...
> Selecting previously unselected package lttng-modules-dkms.
> Preparing to unpack .../lttng-modules-dkms_2.4.0-1ubuntu1.1_all.deb ...
> Unpacking lttng-modules-dkms (2.4.0-1ubuntu1.1) ...
> Processing triggers for man-db (2.6.7.1-1ubuntu1) ...
> Setting up dkms (2.2.0.3-1.1ubuntu5.14.04) ...
> Setting up lttng-modules-dkms (2.4.0-1ubuntu1.1) ...
>
>
>
> *Loading new lttng-modules-2.4.0 DKMS files...First Installation: checking
> all kernels...dpkg: warning: version '*-*' has bad syntax: version number
> does not start with digitIt is likely that
> 3.14.12-parallella-xilinx-g40a90c3 belongs to a chroot's host*
>
> And at this point the installation just stop and i'm back with the prompt.
>
> Since i'm quite new in the LTTng universe i don't know what to do. I made
> some researches on the subject but there was nothing for the Parallella. I
> only found an answer for a similar problem suggesting to install the kernel
> causing this trouble in the chroot environment, but i'm not quite sure how
> to do this properly.
>
> Thanks in advance !
>
> Thomas.
>

--001a11c2fe647dc4320517c6f86d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi ! <br><br></div>While solving my pr=
oblem (I had to rebuild the kernel since there were some configurations fil=
e for the modules missing and I didn&#39;t have access to the headers of th=
e distribution in the repositories), I encoutered what seemed to be an inco=
mpatibility between the lttng-modules &quot;block.h&quot; code and some of =
the libraries of the 3.14.12 kernel, especially with the bio struct (see <a=
 href=3D"https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D748953">https:=
//bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D748953</a>).<br><br>In fact, =
even after applying the &quot;blktrace-test.patch&quot; (<a href=3D"https:/=
/bugs.launchpad.net/ubuntu/+source/lttng-modules/+bug/1328335">https://bugs=
.launchpad.net/ubuntu/+source/lttng-modules/+bug/1328335</a>) there were st=
ill problems with the use of &quot;bio-&gt;bi_sector&quot; in the &quot;blo=
ck.h&quot; code. So I made a little patch correcting the use of the structu=
re, and now everything work fine :<br><br>--- a/instrumentation/events/lttn=
g-module/block.h<br>+++ b/instrumentation/events/lttng-module/block.h<br>@@=
 -221,6 +221,62 @@<br>=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(q, rq)<br>=C2=A0)<br=
>=C2=A0<br>+#ifdef CONFIG_VERSION_SIGNATURE<br>+#elif (LINUX_VERSION_CODE &=
gt;=3D KERNEL_VERSION(3,14,5)=C2=A0=C2=A0=C2=A0 \<br>+=C2=A0=C2=A0=C2=A0 ||=
 LTTNG_KERNEL_RANGE(3,12,21, 3,13,0)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 \=
<br>+=C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,10,41, 3,11,0)=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 \<br>+=C2=A0=C2=A0=C2=A0 || LTTNG_KERNEL_RANGE(3,=
4,91, 3,5,0)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 \<br>+=C2=A0=C2=A0=C2=A0 =
|| LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))<br>+<br>+/**<br>+ * block_rq_complete=
 - block IO operation completed by device driver<br>+ * @q: queue containin=
g the block operation request<br>+ * @rq: block operations request<br>+ * @=
nr_bytes: number of completed bytes<br>+ *<br>+ * The block_rq_complete tra=
cepoint event indicates that some portion<br>+ * of operation request has b=
een completed by the device driver.=C2=A0 If<br>+ * the @rq-&gt;bio is %NUL=
L, then there is absolutely no additional work to<br>+ * do for the request=
. If @rq-&gt;bio is non-NULL then there is<br>+ * additional work required =
to complete the request.<br>+ */<br>+TRACE_EVENT(block_rq_complete,<br>+<br=
>+=C2=A0=C2=A0=C2=A0 TP_PROTO(struct request_queue *q, struct request *rq,<=
br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0unsigned int nr_bytes),<br>=
+<br>+=C2=A0=C2=A0=C2=A0 TP_ARGS(q, rq, nr_bytes),<br>+<br>+=C2=A0=C2=A0=C2=
=A0 TP_STRUCT__entry(<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __field(=C2=
=A0 dev_t,=C2=A0=C2=A0=C2=A0 dev=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 )<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __field(=C2=A0 =
sector_t,=C2=A0=C2=A0=C2=A0 sector=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 )<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __field(=C2=A0 =
unsigned int,=C2=A0=C2=A0=C2=A0 nr_sector=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 )<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __field(=C2=A0 int,=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 errors=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 )<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __field(=C2=
=A0 unsigned int,=C2=A0=C2=A0=C2=A0 rwbs=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 )<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __dynami=
c_array_hex( unsigned char,=C2=A0=C2=A0=C2=A0 cmd,<br>+=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (rq-&gt;cmd_type =3D=3D REQ_TYPE_BLOC=
K_PC) ?<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 rq-&gt;cmd_len : 0)<br>+=C2=A0=C2=A0=C2=A0 ),<br>+<br>+=C2=A0=
=C2=A0=C2=A0 TP_fast_assign(<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_a=
ssign(dev, rq-&gt;rq_disk ? disk_devt(rq-&gt;rq_disk) : 0)<br>+=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sector, blk_rq_pos(rq))<br>+=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(nr_sector, nr_bytes &gt;&gt; 9)<br>+=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(errors, rq-&gt;errors)<br>+=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, rq-&gt;cmd_flags,=
 nr_bytes)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_memcpy_dyn(cmd, (rq=
-&gt;cmd_type =3D=3D REQ_TYPE_BLOCK_PC) ?<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 rq-&gt;c=
md : NULL)<br>+=C2=A0=C2=A0=C2=A0 ),<br>+<br>+=C2=A0=C2=A0=C2=A0 TP_printk(=
&quot;%d,%d %s (%s) %llu + %u [%d]&quot;,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0 MAJOR(__entry-&gt;dev), MINOR(__entry-&gt;dev),<br>+=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 __entry-&gt;rwbs, __get_str(cmd),<br=
>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 (unsigned long long)__entry-=
&gt;sector,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 __entry-&gt;nr=
_sector, __entry-&gt;errors)<br>+)<br>+<br>+#else /* #if (LINUX_VERSION_COD=
E &gt;=3D KERNEL_VERSION(3,15,0)) */<br>+<br>=C2=A0/**<br>=C2=A0 * block_rq=
_complete - block IO operation completed by device driver<br>=C2=A0 * @q: q=
ueue containing the block operation request<br>@@ -239,6 +295,8 @@<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(q, rq)<br>=C2=A0)<br>=C2=A0<br>+#endif /* #el=
se #if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(3,15,0)) */<br>+<br>=C2=
=A0DECLARE_EVENT_CLASS(block_rq,<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 TP_P=
ROTO(struct request_queue *q, struct request *rq),<br>@@ -341,9 +399,9 @@<b=
r>=C2=A0=C2=A0=C2=A0=C2=A0 TP_fast_assign(<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 tp_assign(dev, bio-&gt;bi_bdev ?<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0 bio-&gt;bi_bdev-&gt;bd_dev : 0)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 tp_assign(sector, bio-&gt;bi_sector)<br>-=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 tp_assign(nr_sector, bio-&gt;bi_size &gt;&gt; 9)<br>-=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, bio-&gt;bi_rw, bio-&=
gt;bi_size)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sector, bio=
-&gt;bi_iter.bi_sector)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign=
(nr_sector, bio-&gt;bi_iter.bi_size &gt;&gt; 9)<br>+=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, bio-&gt;bi_rw, bio-&gt;bi_iter.bi_size)=
<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_memcpy(comm, current-&gt=
;comm, TASK_COMM_LEN)<br>=C2=A0=C2=A0=C2=A0=C2=A0 ),<br>=C2=A0<br>@@ -385,1=
4 +443,14 @@<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 TP_fast_assign(<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(dev, bio-&gt;bi_bdev-&gt=
;bd_dev)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sector, bio-&g=
t;bi_sector)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(nr_sector,=
 bio-&gt;bi_size &gt;&gt; 9)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_a=
ssign(sector, bio-&gt;bi_iter.bi_sector)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 tp_assign(nr_sector, bio-&gt;bi_iter.bi_size &gt;&gt; 9)<br>=C2=
=A0#if (LINUX_VERSION_CODE &gt;=3D KERNEL_VERSION(2,6,38))<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(error, error)<br>=C2=A0#else<br>=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(error, 0)<br>=C2=A0#e=
ndif<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, bio-&gt;=
bi_rw, bio-&gt;bi_size)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_=
rwbs(rwbs, bio-&gt;bi_rw, bio-&gt;bi_iter.bi_size)<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 ),<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 TP_printk(&quot;%d,%d %s %llu =
+ %u [%d]&quot;,<br>@@ -419,9 +477,9 @@<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 TP_fast_assign(<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assig=
n(dev, bio-&gt;bi_bdev-&gt;bd_dev)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 tp_assign(sector, bio-&gt;bi_sector)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 tp_assign(nr_sector, bio-&gt;bi_size &gt;&gt; 9)<br>-=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, bio-&gt;bi_rw, bio-&gt;bi_siz=
e)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sector, bio-&gt;bi_i=
ter.bi_sector)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(nr_secto=
r, bio-&gt;bi_iter.bi_size &gt;&gt; 9)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 blk_fill_rwbs(rwbs, bio-&gt;bi_rw, bio-&gt;bi_iter.bi_size)<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_memcpy(comm, current-&gt;comm, =
TASK_COMM_LEN)<br>=C2=A0=C2=A0=C2=A0=C2=A0 ),<br>=C2=A0<br>@@ -485,9 +543,9=
 @@<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 TP_fast_assign(<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(dev, bio-&gt;bi_bdev-&gt;bd_dev)<=
br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sector, bio-&gt;bi_sect=
or)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(nr_sector, bio-&gt;=
bi_size &gt;&gt; 9)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs=
(rwbs, bio-&gt;bi_rw, bio-&gt;bi_size)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 tp_assign(sector, bio-&gt;bi_iter.bi_sector)<br>+=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 tp_assign(nr_sector, bio-&gt;bi_iter.bi_size &gt;&gt; 9)=
<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, bio-&gt;bi_r=
w, bio-&gt;bi_iter.bi_size)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
tp_memcpy(comm, current-&gt;comm, TASK_COMM_LEN)<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 ),<br>=C2=A0<br>@@ -513,9 +571,9 @@<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 TP_fast_assign(<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assig=
n(dev, bio-&gt;bi_bdev ? bio-&gt;bi_bdev-&gt;bd_dev : 0)<br>-=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sector, bio-&gt;bi_sector)<br>-=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(nr_sector, bio-&gt;bi_size &gt;&g=
t; 9)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, bio-&gt=
;bi_rw, bio-&gt;bi_size)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assig=
n(sector, bio-&gt;bi_iter.bi_sector)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 tp_assign(nr_sector, bio-&gt;bi_iter.bi_size &gt;&gt; 9)<br>+=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, bio-&gt;bi_rw, bio-&gt;bi_=
iter.bi_size)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_memcpy(comm=
, current-&gt;comm, TASK_COMM_LEN)<br>=C2=A0=C2=A0=C2=A0=C2=A0 ),<br>=C2=A0=
<br>@@ -587,10 +645,10 @@<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 TP_fast_ass=
ign(<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(dev, bio ? bi=
o-&gt;bi_bdev-&gt;bd_dev : 0)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_=
assign(sector, bio ? bio-&gt;bi_sector : 0)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 tp_assign(nr_sector, bio ? bio-&gt;bi_size &gt;&gt; 9 : 0)<br>=
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sector, bio ? bio-&gt;bi_i=
ter.bi_sector : 0)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(nr_s=
ector, bio ? bio-&gt;bi_iter.bi_size &gt;&gt; 9 : 0)<br>=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, bio ? bio-&gt;bi_rw : 0,<br>-=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bio ? bio-&gt;bi_size &gt;&gt; 9 : 0)<br>+=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio ? =
bio-&gt;bi_iter.bi_size &gt;&gt; 9 : 0)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 tp_memcpy(comm, current-&gt;comm, TASK_COMM_LEN)<br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ),<br>=C2=A0<br>@@ -759,9 +817,9 @@=
<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 TP_fast_assign(<br>=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(dev, bio-&gt;bi_bdev-&gt;bd_dev)<br>=
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sector, bio-&gt;bi_sector)=
<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sector, bio-&gt;bi_ite=
r.bi_sector)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(new_s=
ector, new_sector)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(=
rwbs, bio-&gt;bi_rw, bio-&gt;bi_size)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 blk_fill_rwbs(rwbs, bio-&gt;bi_rw, bio-&gt;bi_iter.bi_size)<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_memcpy(comm, current-&gt;comm, =
TASK_COMM_LEN)<br>=C2=A0=C2=A0=C2=A0=C2=A0 ),<br>=C2=A0<br>@@ -805,11 +863,=
11 @@<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 TP_fast_assign(<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(dev, bio-&gt;bi_bdev-&gt;bd_dev)<=
br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sector, bio-&gt;bi_sect=
or)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(nr_sector, bio-&gt;=
bi_size &gt;&gt; 9)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(sec=
tor, bio-&gt;bi_iter.bi_sector)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 t=
p_assign(nr_sector, bio-&gt;bi_iter.bi_size &gt;&gt; 9)<br>=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(old_dev, dev)<br>=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 tp_assign(old_sector, from)<br>-=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, bio-&gt;bi_rw, bio-&gt;bi_size)<=
br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 blk_fill_rwbs(rwbs, bio-&gt;bi_rw=
, bio-&gt;bi_iter.bi_size)<br>=C2=A0=C2=A0=C2=A0=C2=A0 ),<br>=C2=A0<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 TP_printk(&quot;%d,%d %s %llu + %u &lt;- (%d,%d) %llu=
&quot;,<br><br></div>Maybe it already was a known issue I&#39;m not aware o=
f and in this case i&#39;m sorry for the long post, otherwise i hope it can=
 be useful for some people !<br><br></div>Regards,<br><br></div>Thomas.<br>=
<div><div><div><div><div><div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">2015-05-20 16:31 GMT-04:00 Thomas Bertauld <span dir=3D"ltr">&=
lt;<a href=3D"mailto:thomas.bertauld@gmail.com" target=3D"_blank">thomas.be=
rtauld@gmail.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div><div><div>Hi !<br><br></div>I recently beg=
an to work on a Parallella board and I wanted to try tracing the ARM proces=
sor with LTTng before doing ant work with the Epiphany chip (co-processor).=
<br><br></div>Nevertheless, i&#39;m stuck with an error anytime i try to in=
stall the lttng-modules. I&#39;ve tried installing it from the official rep=
ositories and from the PPA but none worked.<br><br></div>For now i only tri=
ed with the headless version of Ubuntu 14.04 (<a href=3D"http://www.paralle=
lla.org/create-sdcard/" target=3D"_blank">http://www.parallella.org/create-=
sdcard/</a>) for the Zynq-7010 (the processor itself is a ARM Cortex A9).<b=
r><div><div><br></div><div>The kernel version is 3.14.12, as seen in the er=
ror message below<br><br><br></div><div><font size=3D"2"><span style=3D"fon=
t-family:times new roman,serif">parallella@parallella:~$ sudo apt-get insta=
ll lttng-modules-dkms<br>Reading package lists... Done<br>Building dependen=
cy tree=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>Reading state information..=
. Done<br>The following extra packages will be installed:<br>=C2=A0 dkms<br=
>The following NEW packages will be installed:<br>=C2=A0 dkms lttng-modules=
-dkms<br>0 upgraded, 2 newly installed, 0 to remove and 1 not upgraded.<br>=
Need to get 286 kB of archives.<br>After this operation, 2816 kB of additio=
nal disk space will be used.<br>Do you want to continue? [Y/n] <br>Get:1 <a=
 href=3D"http://ports.ubuntu.com/" target=3D"_blank">http://ports.ubuntu.co=
m/</a> trusty-updates/main dkms all 2.2.0.3-1.1ubuntu5.14.04 [64.6 kB]<br>G=
et:2 <a href=3D"http://ports.ubuntu.com/" target=3D"_blank">http://ports.ub=
untu.com/</a> trusty-updates/universe lttng-modules-dkms all 2.4.0-1ubuntu1=
.1 [221 kB]<br>Fetched 286 kB in 0s (356 kB/s)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 <br>Selecting previously unselected package dkms.<br>=
(Reading database ... 39070 files and directories currently installed.)<br>=
Preparing to unpack .../dkms_2.2.0.3-1.1ubuntu5.14.04_all.deb ...<br>Unpack=
ing dkms (2.2.0.3-1.1ubuntu5.14.04) ...<br>Selecting previously unselected =
package lttng-modules-dkms.<br>Preparing to unpack .../lttng-modules-dkms_2=
.4.0-1ubuntu1.1_all.deb ...<br>Unpacking lttng-modules-dkms (2.4.0-1ubuntu1=
.1) ...<br>Processing triggers for man-db (2.6.7.1-1ubuntu1) ...<br>Setting=
 up dkms (2.2.0.3-1.1ubuntu5.14.04) ...<br>Setting up lttng-modules-dkms (2=
.4.0-1ubuntu1.1) ...<br><b>Loading new lttng-modules-2.4.0 DKMS files...<br=
>First Installation: checking all kernels...<br>dpkg: warning: version &#39=
;*-*&#39; has bad syntax: version number does not start with digit<br>It is=
 likely that 3.14.12-parallella-xilinx-g40a90c3 belongs to a chroot&#39;s h=
ost</b></span></font><br><br></div><div>And at this point the installation =
just stop and i&#39;m back with the prompt.<br></div><div><br></div><div>Si=
nce i&#39;m quite new in the LTTng universe i don&#39;t know what to do. I =
made some researches on the subject but there was nothing for the Parallell=
a. I only found an answer for a similar problem suggesting to install the k=
ernel causing this trouble in the chroot environment, but i&#39;m not quite=
 sure how to do this properly.<br><br></div><div>Thanks in advance !<span c=
lass=3D""><font color=3D"#888888"><br><br></font></span></div><span class=
=3D""><font color=3D"#888888"><div>Thomas.<br></div></font></span></div></d=
iv>
</blockquote></div><br></div></div></div></div></div></div></div></div>

--001a11c2fe647dc4320517c6f86d--


--===============1551914191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1551914191==--
