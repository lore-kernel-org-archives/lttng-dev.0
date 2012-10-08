From: Hollis Blanchard <hollis_blanchard@mentor.com>
Subject: UST segfault: memcpy too big
Date: Mon, 8 Oct 2012 16:14:27 -0700
Message-ID: <50735E53.1010104__48730.8303163902$1349738106$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0651671768=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Hollis_Blanchard@mentor.com>) id 1TLMWx-0000YF-Eb
	for lttng-dev@lists.lttng.org; Mon, 08 Oct 2012 19:14:35 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1TLMWr-0000mC-1q from Hollis_Blanchard@mentor.com
	for lttng-dev@lists.lttng.org; Mon, 08 Oct 2012 16:14:29 -0700
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

--===============0651671768==
Content-Type: multipart/alternative;
	boundary="------------030005000808020807030104"

--------------030005000808020807030104
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

I seem to have hit a little problem with a "hello world" test app and 
lttng-ust 2.0.3. lttng-ust.git seems to be affected as well. Basically, 
I created a single UST tracepoint, but as soon as I run "lttng 
enable-event -u -a", my app segfaults. The problem seems to be that when 
creating the event to pass to ltt_event_create(), we try to memcpy the 
full 256 bytes of name. However, the name might be shorter, and if we 
get unlucky it falls within 256 bytes of the segment boundary...

Completely untested patch, using strncpy instead of memcpy:

--- liblttng-ust/ltt-events.c.orig      2012-10-08 16:02:16.421494319 -0700
+++ liblttng-ust/ltt-events.c   2012-10-08 16:03:24.770293756 -0700
@@ -248,9 +248,10 @@ int pending_probe_fix_events(const struc

                                 memcpy(&event_param, &sw->event_param,
                                                 sizeof(event_param));
-                               memcpy(event_param.name,
+                               stncpy(event_param.name,
                                         desc->name,
                                         sizeof(event_param.name));
+                               event_param.name[sizeof(event_param.name)-1] = '\0';
                                 /* create event */
                                 ret = ltt_event_create(sw->chan,
                                         &event_param, NULL,


In addition to not testing this patch, I haven't audited other callers 
to see if it's a pattern that also needs to be fixed elsewhere.

Debug info:

Program received signal SIGSEGV, Segmentation fault.
0x4da8d8d4 in memcpy () from /home/hollisb/work/panda-mel-sysroot/lib/libc.so.6
(gdb) bt
#0  0x4da8d8d4 in memcpy () from /home/hollisb/work/panda-mel-sysroot/lib/libc.so.6
#1  0x4007eacc in pending_probe_fix_events (desc=0x8bec) at ltt-events.c:251
#2  0x4007b980 in ltt_probe_register (desc=0x11164) at ltt-probes.c:119
#3  0x0000886c in __lttng_events_init__lighttpd_connection ()
     at /home/hollisb/work/panda-mel-sysroot/usr/include/lttng/ust-tracepoint-event.h:554
#4  0x00008b84 in __libc_csu_init (argc=0x1, argv=0xbe8cfe24, envp=0xbe8cfe2c) at elf-init.c:124
#5  0x4da1f848 in __libc_start_main (main=0xbe8cfe24, argc=0x4db4a000, ubp_av=0x4da1f848,
     init=0x8ad0 <__libc_csu_init>, fini=0x8b98 <__libc_csu_fini>, rtld_fini=0x4d9e8018 <_dl_fini>,
     stack_end=0xbe8cfe24) at libc-start.c:185
#6  0x00008968 in _start ()
(gdb) up
#1  0x4007eacc in pending_probe_fix_events (desc=0x8bec) at ltt-events.c:251
(gdb) list
247					int ret;
248	
249					memcpy(&event_param, &sw->event_param,
250							sizeof(event_param));
251					memcpy(event_param.name,
252						desc->name,
253						sizeof(event_param.name));
254					/* create event */
255					ret = ltt_event_create(sw->chan,
256						&event_param, NULL,
(gdb) p desc->name
$10 = 0x8f10 "lighttpd_connection:create"
(gdb) p sizeof(event_param.name)
$11 = 0x100
(gdb) x/64 desc->name
0x8f10:	0x6867696c	0x64707474	0x6e6f635f	0x7463656e
0x8f20:	0x3a6e6f69	0x61657263	0x6574	0x2c746e69
0x8f30:	0x6e6f6320	0x0	0x6867696c	0x64707474
0x8f40:	0x6e6f635f	0x7463656e	0x6e6f69	0x727470
0x8f50 <__tp_strtab_lighttpd_connection___create>:	0x6867696c	0x64707474	0x6e6f635f	0x7463656e
0x8f60 <__tp_strtab_lighttpd_connection___create+16>:	0x3a6e6f69	0x61657263	0x6574	0x8101b108
0x8f70:	0x8400b0b0	0x0	0x8101b108	0x8400b0b0
0x8f80:	0x0	0x8101b108	0x8400b0b0	0x0
0x8f90:	0x7ffff740	0x7fffffe4	0x7ffff76c	0x80a8b0b0
0x8fa0:	0x7ffff7ec	0x80b0b0b0	0x7ffff7f0	0x80a8b0b0
0x8fb0:	0x7ffff8b0	0x7fffffd0	0x7ffff8e4	0x80b108af
0x8fc0:	0x7ffff97c	0x1	0x7ffff9d4	0x80b0b0b0
0x8fd0:	0x7ffff9e8	0x7fffff98	0x7ffffa10	0x8015aab0
0x8fe0:	0x7ffffaf0	0x80aeb0b0	0x7ffffbb0	0x80b0b0b0
0x8ff0:	0x7ffffbac	0x1	0x0	0x0
0x9000:	Cannot access memory at address 0x9000


Uh oh...

% readelf -l tracetest-arm

Elf file type is EXEC (Executable file)
Entry point 0x893c
There are 8 program headers, starting at offset 52

Program Headers:
   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
   EXIDX          0x000f90 0x00008f90 0x00008f90 0x00068 0x00068 R   0x4
   PHDR           0x000034 0x00008034 0x00008034 0x00100 0x00100 R E 0x4
   INTERP         0x000134 0x00008134 0x00008134 0x00013 0x00013 R   0x1
       [Requesting program interpreter: /lib/ld-linux.so.3]
   LOAD           0x000000 0x00008000 0x00008000 0x00ffc 0x00ffc R E 0x8000
   LOAD           0x001000 0x00011000 0x00011000 0x001cc 0x001f8 RW  0x8000
   DYNAMIC        0x00101c 0x0001101c 0x0001101c 0x00100 0x00100 RW  0x4
   NOTE           0x000148 0x00008148 0x00008148 0x00020 0x00020 R   0x4
   GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x4

Note the hole between those two LOAD segments. desc->name landed very 
close to the end of the first. I got lucky on x86, where (at least with 
my toolchain) the next segment happens to land closer:

   LOAD           0x000000 0x08048000 0x08048000 0x00f98 0x00f98 R E 0x1000
   LOAD           0x001000 0x08049000 0x08049000 0x00204 0x00248 RW  0x1000


-- 
Hollis Blanchard
Product Owner, Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Systems Division


--------------030005000808020807030104
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    I seem to have hit a little problem with a "hello world" test app
    and lttng-ust 2.0.3. lttng-ust.git seems to be affected as well.
    Basically, I created a single UST tracepoint, but as soon as I run
    "lttng enable-event -u -a", my app segfaults. The problem seems to
    be that when creating the event to pass to ltt_event_create(), we
    try to memcpy the full 256 bytes of name. However, the name might be
    shorter, and if we get unlucky it falls within 256 bytes of the
    segment boundary...<br>
    <br>
    Completely untested patch, using strncpy instead of memcpy:<br>
    <pre>--- liblttng-ust/ltt-events.c.orig      2012-10-08 16:02:16.421494319 -0700
+++ liblttng-ust/ltt-events.c   2012-10-08 16:03:24.770293756 -0700
@@ -248,9 +248,10 @@ int pending_probe_fix_events(const struc

                                memcpy(&amp;event_param, &amp;sw-&gt;event_param,
                                                sizeof(event_param));
-                               memcpy(event_param.name,
+                               stncpy(event_param.name,
                                        desc-&gt;name,
                                        sizeof(event_param.name));
+                               event_param.name[sizeof(event_param.name)-1] = '\0';
                                /* create event */
                                ret = ltt_event_create(sw-&gt;chan,
                                        &amp;event_param, NULL,


</pre>
    In addition to not testing this patch, I haven't audited other
    callers to see if it's a pattern that also needs to be fixed
    elsewhere.<br>
    <br>
    Debug info:<br>
    <pre>
Program received signal SIGSEGV, Segmentation fault.
0x4da8d8d4 in memcpy () from /home/hollisb/work/panda-mel-sysroot/lib/libc.so.6
(gdb) bt
#0&nbsp; 0x4da8d8d4 in memcpy () from /home/hollisb/work/panda-mel-sysroot/lib/libc.so.6
#1&nbsp; 0x4007eacc in pending_probe_fix_events (desc=0x8bec) at ltt-events.c:251
#2&nbsp; 0x4007b980 in ltt_probe_register (desc=0x11164) at ltt-probes.c:119
#3&nbsp; 0x0000886c in __lttng_events_init__lighttpd_connection ()
&nbsp;&nbsp;&nbsp; at /home/hollisb/work/panda-mel-sysroot/usr/include/lttng/ust-tracepoint-event.h:554
#4&nbsp; 0x00008b84 in __libc_csu_init (argc=0x1, argv=0xbe8cfe24, envp=0xbe8cfe2c) at elf-init.c:124
#5&nbsp; 0x4da1f848 in __libc_start_main (main=0xbe8cfe24, argc=0x4db4a000, ubp_av=0x4da1f848, 
&nbsp;&nbsp;&nbsp; init=0x8ad0 &lt;__libc_csu_init&gt;, fini=0x8b98 &lt;__libc_csu_fini&gt;, rtld_fini=0x4d9e8018 &lt;_dl_fini&gt;, 
&nbsp;&nbsp;&nbsp; stack_end=0xbe8cfe24) at libc-start.c:185
#6&nbsp; 0x00008968 in _start ()
(gdb) up
#1  0x4007eacc in pending_probe_fix_events (desc=0x8bec) at ltt-events.c:251
(gdb) list
247					int ret;
248	
249					memcpy(&amp;event_param, &amp;sw-&gt;event_param,
250							sizeof(event_param));
251					memcpy(event_param.name,
252						desc-&gt;name,
253						sizeof(event_param.name));
254					/* create event */
255					ret = ltt_event_create(sw-&gt;chan,
256						&amp;event_param, NULL,
(gdb) p desc-&gt;name
$10 = 0x8f10 "lighttpd_connection:create"
(gdb) p sizeof(event_param.name)
$11 = 0x100
(gdb) x/64 desc-&gt;name
0x8f10:	0x6867696c	0x64707474	0x6e6f635f	0x7463656e
0x8f20:	0x3a6e6f69	0x61657263	0x6574	0x2c746e69
0x8f30:	0x6e6f6320	0x0	0x6867696c	0x64707474
0x8f40:	0x6e6f635f	0x7463656e	0x6e6f69	0x727470
0x8f50 &lt;__tp_strtab_lighttpd_connection___create&gt;:	0x6867696c	0x64707474	0x6e6f635f	0x7463656e
0x8f60 &lt;__tp_strtab_lighttpd_connection___create+16&gt;:	0x3a6e6f69	0x61657263	0x6574	0x8101b108
0x8f70:	0x8400b0b0	0x0	0x8101b108	0x8400b0b0
0x8f80:	0x0	0x8101b108	0x8400b0b0	0x0
0x8f90:	0x7ffff740	0x7fffffe4	0x7ffff76c	0x80a8b0b0
0x8fa0:	0x7ffff7ec	0x80b0b0b0	0x7ffff7f0	0x80a8b0b0
0x8fb0:	0x7ffff8b0	0x7fffffd0	0x7ffff8e4	0x80b108af
0x8fc0:	0x7ffff97c	0x1	0x7ffff9d4	0x80b0b0b0
0x8fd0:	0x7ffff9e8	0x7fffff98	0x7ffffa10	0x8015aab0
0x8fe0:	0x7ffffaf0	0x80aeb0b0	0x7ffffbb0	0x80b0b0b0
0x8ff0:	0x7ffffbac	0x1	0x0	0x0
0x9000:	Cannot access memory at address 0x9000
</pre>
    <br>
    Uh oh...<br>
    <br>
    <pre>% readelf -l tracetest-arm

Elf file type is EXEC (Executable file)
Entry point 0x893c
There are 8 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  EXIDX          0x000f90 0x00008f90 0x00008f90 0x00068 0x00068 R   0x4
  PHDR           0x000034 0x00008034 0x00008034 0x00100 0x00100 R E 0x4
  INTERP         0x000134 0x00008134 0x00008134 0x00013 0x00013 R   0x1
      [Requesting program interpreter: /lib/ld-linux.so.3]
  LOAD           0x000000 0x00008000 0x00008000 0x00ffc 0x00ffc R E 0x8000
  LOAD           0x001000 0x00011000 0x00011000 0x001cc 0x001f8 RW  0x8000
  DYNAMIC        0x00101c 0x0001101c 0x0001101c 0x00100 0x00100 RW  0x4
  NOTE           0x000148 0x00008148 0x00008148 0x00020 0x00020 R   0x4
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x4

</pre>
    Note the hole between those two LOAD segments. desc-&gt;name landed
    very close to the end of the first. I got lucky on x86, where (at
    least with my toolchain) the next segment happens to land closer:<br>
    <pre>  LOAD           0x000000 0x08048000 0x08048000 0x00f98 0x00f98 R E 0x1000
  LOAD           0x001000 0x08049000 0x08049000 0x00204 0x00248 RW  0x1000

</pre>
    <br>
    <div class="moz-signature">-- <br>
      Hollis Blanchard<br>
      Product Owner, <a href="http://go.mentor.com/sourceryanalyzer">Sourcery
        Analyzer</a><br>
      Mentor Graphics, Embedded Systems Division<br>
      <br>
    </div>
  </body>
</html>

--------------030005000808020807030104--


--===============0651671768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0651671768==--
