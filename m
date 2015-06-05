From: SMITH Peter T <peter.t.smith@alstom.com>
Subject: lttng fails to install on Ubunti 14.04
Date: Fri, 5 Jun 2015 10:22:13 +0000
Message-ID: <92BAB684D31DCD4A8F623A7EE7FD8C06013FEEB2__26742.369173053$1433501889$gmane$org@041-DB3MPN1-092.041d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1196860363=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mcegsmtp4.alstom.com ([159.245.16.224])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <peter.t.smith@alstom.com>) id 1Z0olp-0001y4-Ff
 for lttng-dev@lists.lttng.org; Fri, 05 Jun 2015 06:22:44 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1196860363==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_92BAB684D31DCD4A8F623A7EE7FD8C06013FEEB2041DB3MPN109204_"

--_000_92BAB684D31DCD4A8F623A7EE7FD8C06013FEEB2041DB3MPN109204_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am attempting to install LLTng on Ubuntu 14.04 with the following kernel.

Linux user-VirtualBox 3.13.0-53-generic #89-Ubuntu SMP Wed May 20 10:34:39 =
UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

I have followed the generic installation procedure i.e.
sudo apt-get install lttng-tools
sudo apt-get install lttng-modules-dkms
sudo apt-get install liblttng-ust-dev
The installation fails at the second step i.e. the modules.

Below is the make.log
DKMS make.log for lttng-modules-2.4.0 for kernel 3.13.0-53-generic (x86_64)
Fri Jun  5 11:17:48 BST 2015
make: Entering directory `/usr/src/linux-headers-3.13.0-53-generic'
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-client-=
discard.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-client-=
overwrite.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-metadat=
a-client.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-client-=
mmap-discard.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-client-=
mmap-overwrite.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-ring-buffer-metadat=
a-mmap-client.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-statedump-impl.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/wrapper/irqdesc.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/wrapper/fdtable.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-events.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-abi.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-probes.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-pid.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-procname.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-prio.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-nice.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-vpid.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-tid.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-vtid.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-ppid.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-vppid.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-calibrate.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-hostname.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/wrapper/random.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-syscalls.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-user.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-context-perf-counte=
rs.o
  LD [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-tracer.o
  LD [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lttng-statedump.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_buffe=
r_backend.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_buffe=
r_frontend.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_buffe=
r_iterator.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_buffe=
r_vfs.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_buffe=
r_splice.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/ringbuffer/ring_buffe=
r_mmap.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/prio_heap/lttng_prio_=
heap.o
 CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/../wrapper/splice.o
  LD [M]  /var/lib/dkms/lttng-modules/2.4.0/build/lib/lttng-lib-ring-buffer=
.o
/var/lib/dkms/lttng-modules/2.4.0/build/probes/Makefile:30: File /usr/src/l=
inux-headers-3.13.0-53-generic/virt/kvm/iodev.h not found. Probe "kvm" x86-=
specific is disabled. Use full kernel source tree to enable it.
/var/lib/dkms/lttng-modules/2.4.0/build/probes/Makefile:142: Files /usr/src=
/linux-headers-3.13.0-53-generic/fs/btrfs/*.h not found. Probe "btrfs" is d=
isabled. Use full kernel source tree to enable it.
/var/lib/dkms/lttng-modules/2.4.0/build/probes/Makefile:158: Files /usr/src=
/linux-headers-3.13.0-53-generic/fs/ext4/*.h not found. Probe "ext4" is dis=
abled. Use full kernel source tree to enable it.
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-types.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-sched.=
o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-irq.o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-timer.=
o
  CC [M]  /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-kmem.o
In file included from /var/lib/dkms/lttng-modules/2.4.0/build/probes/../ins=
trumentation/events/lttng-module/../../../probes/define_trace.h:148:0,
                 from /var/lib/dkms/lttng-modules/2.4.0/build/probes/../ins=
trumentation/events/lttng-module/kmem.h:380,
                 from /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-=
probe-kmem.c:41:
/var/lib/dkms/lttng-modules/2.4.0/build/probes/../instrumentation/events/lt=
tng-module/../../../probes/lttng-events.h:151:6: error: conflicting types f=
or 'trace_mm_page_alloc_extfrag'
void trace_##_name(_proto);
      ^
/var/lib/dkms/lttng-modules/2.4.0/build/probes/../instrumentation/events/lt=
tng-module/../../../probes/lttng-events.h:47:2: note: in expansion of macro=
 'DEFINE_EVENT_MAP'
  DEFINE_EVENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))
  ^
/var/lib/dkms/lttng-modules/2.4.0/build/probes/../instrumentation/events/lt=
tng-module/../../../probes/lttng-events.h:89:2: note: in expansion of macro=
 'TRACE_EVENT_MAP'
  TRACE_EVENT_MAP(name, name,    \
  ^
/var/lib/dkms/lttng-modules/2.4.0/build/probes/../instrumentation/events/lt=
tng-module/../../../probes/../instrumentation/events/lttng-module/kmem.h:29=
1:1: note: in expansion of macro 'TRACE_EVENT'
TRACE_EVENT(mm_page_alloc_extfrag,
^
In file included from include/linux/module.h:18:0,
                 from /var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-=
probe-kmem.c:24:
include/linux/tracepoint.h:168:21: note: previous definition of 'trace_mm_p=
age_alloc_extfrag' was here
  static inline void trace_##name(proto)    \
                     ^
include/linux/tracepoint.h:265:3: note: in expansion of macro '__DECLARE_TR=
ACE'
   __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
   ^
include/linux/tracepoint.h:399:2: note: in expansion of macro 'DECLARE_TRAC=
E'
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  ^
include/trace/events/kmem.h:267:1: note: in expansion of macro 'TRACE_EVENT=
'
TRACE_EVENT(mm_page_alloc_extfrag,
^
make[2]: *** [/var/lib/dkms/lttng-modules/2.4.0/build/probes/lttng-probe-km=
em.o] Error 1
make[1]: *** [/var/lib/dkms/lttng-modules/2.4.0/build/probes] Error 2
make: *** [_module_/var/lib/dkms/lttng-modules/2.4.0/build] Error 2
make: Leaving directory `/usr/src/linux-headers-3.13.0-53-generic'










________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.

--_000_92BAB684D31DCD4A8F623A7EE7FD8C06013FEEB2041DB3MPN109204_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";
	mso-fareast-language:EN-GB;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">I am attempting to install LLTng on Ubuntu 14.04 wit=
h the following kernel.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Linux user-VirtualBox 3.13.0-53-generic #89-Ubuntu S=
MP Wed May 20 10:34:39 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have followed the generic installation procedure i=
.e.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:18.0pt;margin-right:0cm;=
margin-bottom:18.0pt;margin-left:0cm;line-height:11.25pt">
<span style=3D"font-size:9.0pt;font-family:Consolas;mso-fareast-language:EN=
-GB">sudo apt-get install lttng-tools<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:18.0pt;margin-right:0cm;=
margin-bottom:18.0pt;margin-left:0cm;line-height:11.25pt">
<span style=3D"font-size:9.0pt;font-family:Consolas;mso-fareast-language:EN=
-GB">sudo apt-get install lttng-modules-dkms<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:18.0pt;margin-right:0cm;=
margin-bottom:18.0pt;margin-left:0cm;line-height:11.25pt">
<span style=3D"font-size:9.0pt;font-family:Consolas;mso-fareast-language:EN=
-GB">sudo apt-get install liblttng-ust-dev<o:p></o:p></span></p>
<p class=3D"MsoNormal">The installation fails at the second step i.e. the m=
odules.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Below is the make.log<o:p></o:p></p>
<p class=3D"MsoNormal">DKMS make.log for lttng-modules-2.4.0 for kernel 3.1=
3.0-53-generic (x86_64)<o:p></o:p></p>
<p class=3D"MsoNormal">Fri Jun&nbsp; 5 11:17:48 BST 2015<o:p></o:p></p>
<p class=3D"MsoNormal">make: Entering directory `/usr/src/linux-headers-3.1=
3.0-53-generic'<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-ring-buffer-client-discard.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-ring-buffer-client-overwrite.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-ring-buffer-metadata-client.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-ring-buffer-client-mmap-discard.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-ring-buffer-client-mmap-overwrite.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-ring-buffer-metadata-mmap-client.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-statedump-impl.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/wrapper/irqdesc.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/wrapper/fdtable.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-events.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-abi.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-probes.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-pid.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-procname.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-prio.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-nice.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-vpid.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-tid.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-vtid.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-ppid.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-vppid.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-calibrate.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-hostname.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M] &nbsp;/var/lib/dkms/lttng-modules/2.4.=
0/build/wrapper/random.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-syscalls.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/probes/lttng-probe-user.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-context-perf-counters.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; LD [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-tracer.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; LD [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lttng-statedump.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lib/ringbuffer/ring_buffer_backend.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lib/ringbuffer/ring_buffer_frontend.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lib/ringbuffer/ring_buffer_iterator.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lib/ringbuffer/ring_buffer_vfs.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lib/ringbuffer/ring_buffer_splice.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lib/ringbuffer/ring_buffer_mmap.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lib/prio_heap/lttng_prio_heap.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.0=
/build/lib/../wrapper/splice.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; LD [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/lib/lttng-lib-ring-buffer.o<o:p></o:p></p>
<p class=3D"MsoNormal">/var/lib/dkms/lttng-modules/2.4.0/build/probes/Makef=
ile:30: File /usr/src/linux-headers-3.13.0-53-generic/virt/kvm/iodev.h not =
found. Probe &quot;kvm&quot; x86-specific is disabled. Use full kernel sour=
ce tree to enable it.<o:p></o:p></p>
<p class=3D"MsoNormal">/var/lib/dkms/lttng-modules/2.4.0/build/probes/Makef=
ile:142: Files /usr/src/linux-headers-3.13.0-53-generic/fs/btrfs/*.h not fo=
und. Probe &quot;btrfs&quot; is disabled. Use full kernel source tree to en=
able it.<o:p></o:p></p>
<p class=3D"MsoNormal">/var/lib/dkms/lttng-modules/2.4.0/build/probes/Makef=
ile:158: Files /usr/src/linux-headers-3.13.0-53-generic/fs/ext4/*.h not fou=
nd. Probe &quot;ext4&quot; is disabled. Use full kernel source tree to enab=
le it.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/probes/lttng-types.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/probes/lttng-probe-sched.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/probes/lttng-probe-irq.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/probes/lttng-probe-timer.o<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.4.=
0/build/probes/lttng-probe-kmem.o<o:p></o:p></p>
<p class=3D"MsoNormal">In file included from /var/lib/dkms/lttng-modules/2.=
4.0/build/probes/../instrumentation/events/lttng-module/../../../probes/def=
ine_trace.h:148:0,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /var/lib/dkms/lttng-modul=
es/2.4.0/build/probes/../instrumentation/events/lttng-module/kmem.h:380,<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /var/lib/dkms/lttng-modul=
es/2.4.0/build/probes/lttng-probe-kmem.c:41:<o:p></o:p></p>
<p class=3D"MsoNormal">/var/lib/dkms/lttng-modules/2.4.0/build/probes/../in=
strumentation/events/lttng-module/../../../probes/lttng-events.h:151:6: err=
or: conflicting types for &#8216;trace_mm_page_alloc_extfrag&#8217;<o:p></o=
:p></p>
<p class=3D"MsoNormal">void trace_##_name(_proto);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^<o:p></o:p></p>
<p class=3D"MsoNormal">/var/lib/dkms/lttng-modules/2.4.0/build/probes/../in=
strumentation/events/lttng-module/../../../probes/lttng-events.h:47:2: note=
: in expansion of macro &#8216;DEFINE_EVENT_MAP&#8217;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; DEFINE_EVENT_MAP(map, name, map, PARAMS(proto=
), PARAMS(args))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; ^<o:p></o:p></p>
<p class=3D"MsoNormal">/var/lib/dkms/lttng-modules/2.4.0/build/probes/../in=
strumentation/events/lttng-module/../../../probes/lttng-events.h:89:2: note=
: in expansion of macro &#8216;TRACE_EVENT_MAP&#8217;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; TRACE_EVENT_MAP(name, name,&nbsp;&nbsp;&nbsp;=
 \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; ^<o:p></o:p></p>
<p class=3D"MsoNormal">/var/lib/dkms/lttng-modules/2.4.0/build/probes/../in=
strumentation/events/lttng-module/../../../probes/../instrumentation/events=
/lttng-module/kmem.h:291:1: note: in expansion of macro &#8216;TRACE_EVENT&=
#8217;<o:p></o:p></p>
<p class=3D"MsoNormal">TRACE_EVENT(mm_page_alloc_extfrag,<o:p></o:p></p>
<p class=3D"MsoNormal">^<o:p></o:p></p>
<p class=3D"MsoNormal">In file included from include/linux/module.h:18:0,<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from /var/lib/dkms/lttng-modul=
es/2.4.0/build/probes/lttng-probe-kmem.c:24:<o:p></o:p></p>
<p class=3D"MsoNormal">include/linux/tracepoint.h:168:21: note: previous de=
finition of &#8216;trace_mm_page_alloc_extfrag&#8217; was here<o:p></o:p></=
p>
<p class=3D"MsoNormal">&nbsp; static inline void trace_##name(proto)&nbsp;&=
nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^<o:p>=
</o:p></p>
<p class=3D"MsoNormal">include/linux/tracepoint.h:265:3: note: in expansion=
 of macro &#8216;__DECLARE_TRACE&#8217;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; __DECLARE_TRACE(name, PARAMS(proto), PA=
RAMS(args), 1, \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; ^<o:p></o:p></p>
<p class=3D"MsoNormal">include/linux/tracepoint.h:399:2: note: in expansion=
 of macro &#8216;DECLARE_TRACE&#8217;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; DECLARE_TRACE(name, PARAMS(proto), PARAMS(arg=
s))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; ^<o:p></o:p></p>
<p class=3D"MsoNormal">include/trace/events/kmem.h:267:1: note: in expansio=
n of macro &#8216;TRACE_EVENT&#8217;<o:p></o:p></p>
<p class=3D"MsoNormal">TRACE_EVENT(mm_page_alloc_extfrag,<o:p></o:p></p>
<p class=3D"MsoNormal">^<o:p></o:p></p>
<p class=3D"MsoNormal">make[2]: *** [/var/lib/dkms/lttng-modules/2.4.0/buil=
d/probes/lttng-probe-kmem.o] Error 1<o:p></o:p></p>
<p class=3D"MsoNormal">make[1]: *** [/var/lib/dkms/lttng-modules/2.4.0/buil=
d/probes] Error 2<o:p></o:p></p>
<p class=3D"MsoNormal">make: *** [_module_/var/lib/dkms/lttng-modules/2.4.0=
/build] Error 2<o:p></o:p></p>
<p class=3D"MsoNormal">make: Leaving directory `/usr/src/linux-headers-3.13=
.0-53-generic'<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Black" size=3D"2">CONFIDENTIALITY : This e-ma=
il and any attachments are confidential and may be privileged. If you are n=
ot a named recipient, please notify the sender immediately and do not discl=
ose the contents to another person, use
 it for any purpose or store or copy the information in any medium.<br>
</font>
</body>
</html>

--_000_92BAB684D31DCD4A8F623A7EE7FD8C06013FEEB2041DB3MPN109204_--


--===============1196860363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1196860363==--
