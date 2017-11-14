From: "Robin Michielsen" <robin.michielsen.1@gmail.com>
Subject: Error: opening metadata failed (LTTng on OpenWRT)
Date: Tue, 14 Nov 2017 10:41:07 +0100
Message-ID: <01bf01d35d2c$b2f214b0$18d63e10$__27494.741351302$1510652488$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_01C0_01D35D35.14B9FF20"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com
 [IPv6:2a00:1450:400c:c09::22c])
 by lists.lttng.org (Postfix) with ESMTPS id 3ybjF34JMXztGR
 for <lttng-dev@lists.lttng.org>; Tue, 14 Nov 2017 09:41:11 +0000 (UTC)
Received: by mail-wm0-x22c.google.com with SMTP id g141so20478445wmg.2
 for <lttng-dev@lists.lttng.org>; Tue, 14 Nov 2017 01:41:11 -0800 (PST)
Received: from NLVEHVRES2NBZIG (leo-y1165.lighting.hightechcampus.com.
 [194.171.252.165])
 by smtp.gmail.com with ESMTPSA id c5sm15297200edd.38.2017.11.14.01.41.08
 for <lttng-dev@lists.lttng.org>
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 14 Nov 2017 01:41:08 -0800 (PST)
Content-Language: en-us
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

This is a multipart message in MIME format.

------=_NextPart_000_01C0_01D35D35.14B9FF20
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_01C1_01D35D35.14B9FF20"


------=_NextPart_001_01C1_01D35D35.14B9FF20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all,

 

I am trying to trace the Linux kernel (system calls) using LTTng on a
platform that is running OpenWRT. I have cross compiled the latest versions
(2.10.x) of the lttng-modules, lttng-tools and lttng-ust packages and
installed these on my OpenWRT system. Now when I start a kernel trace then
the lttng tool returns the error "LTTng transport relay-metadata not found /
Error: Opening metadata failed". Does anybody know what might cause this
error, or have a hint on what to check?

 

I have attached the captured output of 'lttng-sessiond -vvv
--verbose-consumer'. Here is some more context:

.         MIPS platform running Linux 3.18.29

.         Package versions:

o   lttng-modules-2.10.4

o   lttng-tools-2.10.1

o   lttng-ust-2.10.0

.         lsmod shows that the following modules have been loaded:

o   lttng_clock

o   lttng_lib_ring_buffer

o   lttng_ring_buffer_client_discard

o   lttng_statedump

o   lttng_tracer

.         Commands to create and start a session:

o   lttng create

o   lttng enable-event --kernel --syscall open,close

o   lttng start

 

When 'lttng start' is called then lttng-sessiond's debug output shows
"Closing metadata fd -1 (in trace_kernel_destroy_metadata() at
trace-kernel.c:569)" followed by "Sending response (size: 20, retcode:
Opening metadata failed (45)) (in thread_manage_clients() at main.c:4641)".
I assume that the error that I'm seeing is because for some reason metadata
fd is being closed.

 

Does anybody know what may cause this issue, or have a hint on to check?

 

Kind regards,

Robin

 


------=_NextPart_001_01C1_01D35D35.14B9FF20
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:264849253;
	mso-list-type:hybrid;
	mso-list-template-ids:1265279144 67698689 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi =
all,<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I am trying to trace the Linux kernel (system calls) =
using LTTng on a platform that is running OpenWRT. I have cross compiled =
the latest versions (2.10.x) of the lttng-modules, lttng-tools and =
lttng-ust packages and installed these on my OpenWRT system. Now when I =
start a kernel trace then the lttng tool returns the error &quot;LTTng =
transport relay-metadata not found / Error: Opening metadata =
failed&quot;. Does anybody know what might cause this error, or have a =
hint on what to check?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I have =
attached the captured output of &#8216;lttng-sessiond -vvv =
--verbose-consumer&#8217;. Here is some more context:<o:p></o:p></p><p =
class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span style=3D'font-family:Symbol'><span =
style=3D'mso-list:Ignore'>&middot;<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]>MIPS platform running Linux =
3.18.29<o:p></o:p></p><p class=3DMsoListParagraph =
style=3D'text-indent:-.25in;mso-list:l0 level1 lfo1'><![if =
!supportLists]><span style=3D'font-family:Symbol'><span =
style=3D'mso-list:Ignore'>&middot;<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]>Package versions:<o:p></o:p></p><p =
class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; =
</span></span></span><![endif]>lttng-modules-2.10.4<o:p></o:p></p><p =
class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; =
</span></span></span><![endif]>lttng-tools-2.10.1<o:p></o:p></p><p =
class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; =
</span></span></span><![endif]>lttng-ust-2.10.0<o:p></o:p></p><p =
class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span style=3D'font-family:Symbol'><span =
style=3D'mso-list:Ignore'>&middot;<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]>lsmod shows that the following modules =
have been loaded:<o:p></o:p></p><p class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; =
</span></span></span><![endif]>lttng_clock<o:p></o:p></p><p =
class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; =
</span></span></span><![endif]>lttng_lib_ring_buffer<o:p></o:p></p><p =
class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; =
</span></span></span><![endif]>lttng_ring_buffer_client_discard<o:p></o:p=
></p><p class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; =
</span></span></span><![endif]>lttng_statedump<o:p></o:p></p><p =
class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; =
</span></span></span><![endif]>lttng_tracer<o:p></o:p></p><p =
class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><span style=3D'font-family:Symbol'><span =
style=3D'mso-list:Ignore'>&middot;<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span></span><![endif]>Commands to create and start a =
session:<o:p></o:p></p><p class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]>lttng =
create<o:p></o:p></p><p class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]>lttng =
enable-event --kernel --syscall open,close<o:p></o:p></p><p =
class=3DMsoListParagraph =
style=3D'margin-left:1.0in;text-indent:-.25in;mso-list:l0 level2 =
lfo1'><![if !supportLists]><span style=3D'font-family:"Courier =
New"'><span style=3D'mso-list:Ignore'>o<span style=3D'font:7.0pt "Times =
New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]>lttng =
start<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>When &#8216;lttng start&#8217; is called then =
lttng-sessiond&#8217;s debug output shows &#8220;Closing metadata fd -1 =
(in trace_kernel_destroy_metadata() at trace-kernel.c:569)&#8221; =
followed by &#8220;Sending response (size: 20, retcode: Opening metadata =
failed (45)) (in thread_manage_clients() at main.c:4641)&#8221;. I =
assume that the error that I&#8217;m seeing is because for some reason =
metadata fd is being closed.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Does anybody =
know what may cause this issue, or have a hint on to =
check?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Kind regards,<o:p></o:p></p><p =
class=3DMsoNormal>Robin<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_001_01C1_01D35D35.14B9FF20--

------=_NextPart_000_01C0_01D35D35.14B9FF20
Content-Type: application/octet-stream;
	name="lttng-sessiond.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lttng-sessiond.log"

lttng --version=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
lttng (LTTng Trace Control) 2.10.1 - KeKriek=0A=
=0A=
=0A=
lttng-sessiond --version=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
2.10.1=0A=
=0A=
=0A=
lsmod | grep lttng=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
lttng_clock             1469  2 lttng_ring_buffer_client_discard=0A=
lttng_lib_ring_buffer   35584  2 lttng_ring_buffer_client_discard=0A=
lttng_ring_buffer_client_discard    8576  0=0A=
lttng_statedump         3242  1 lttng_tracer=0A=
lttng_tracer          640999  1 lttng_ring_buffer_client_discard=0A=
=0A=
=0A=
lttng-sessiond -vvv --verbose-consumer=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
DEBUG1 - 07:58:17.480830 [1435/1435]: Resetting run_as worker signal =
handlers to default (in reset_sighandler() at runas.c:536)=0A=
DEBUG1 - 07:58:17.485450 [1435/1435]: run_as signal handler set for =
SIGTERM and SIGINT (in set_worker_sighandlers() at runas.c:597)=0A=
DEBUG1 - 07:58:17.488187 [1434/1434]: Health check time delta in seconds =
set to 20 (in health_init() at health.c:73)=0A=
DEBUG3 - 07:58:17.488935 [1434/1434]: Creating LTTng run directory: =
/var/run/lttng (in create_lttng_rundir() at main.c:5365)=0A=
DEBUG2 - 07:58:17.489430 [1434/1434]: Kernel consumer err path: =
/var/run/lttng/kconsumerd/error (in main() at main.c:5789)=0A=
DEBUG2 - 07:58:17.489775 [1434/1434]: Kernel consumer cmd path: =
/var/run/lttng/kconsumerd/command (in main() at main.c:5791)=0A=
DEBUG1 - 07:58:17.490176 [1434/1434]: Client socket path =
/var/run/lttng/client-lttng-sessiond (in main() at main.c:5884)=0A=
DEBUG1 - 07:58:17.490337 [1434/1434]: Application socket path =
/var/run/lttng/lttng-ust-sock-7 (in main() at main.c:5885)=0A=
DEBUG1 - 07:58:17.490471 [1434/1434]: Application wait path =
/lttng-ust-wait-7 (in main() at main.c:5886)=0A=
DEBUG1 - 07:58:17.490603 [1434/1434]: LTTng run directory path: =
/var/run/lttng (in main() at main.c:5887)=0A=
DEBUG2 - 07:58:17.490801 [1434/1434]: UST consumer 32 bits err path: =
/var/run/lttng/ustconsumerd32/error (in main() at main.c:5906)=0A=
DEBUG2 - 07:58:17.490956 [1434/1434]: UST consumer 32 bits cmd path: =
/var/run/lttng/ustconsumerd32/command (in main() at main.c:5908)=0A=
DEBUG2 - 07:58:17.491574 [1434/1434]: UST consumer 64 bits err path: =
/var/run/lttng/ustconsumerd64/error (in main() at main.c:5939)=0A=
DEBUG2 - 07:58:17.491852 [1434/1434]: UST consumer 64 bits cmd path: =
/var/run/lttng/ustconsumerd64/command (in main() at main.c:5941)=0A=
DEBUG3 - 07:58:17.492984 [1434/1434]: Created hashtable size 4 at =
0x4d2390 of type 1 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG3 - 07:58:17.493245 [1434/1434]: Created hashtable size 4 at =
0x4d2530 of type 1 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG3 - 07:58:17.493439 [1434/1434]: Created hashtable size 4 at =
0x4d2698 of type 1 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG3 - 07:58:17.493631 [1434/1434]: Created hashtable size 4 at =
0x4d2800 of type 1 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG2 - 07:58:17.493981 [1434/1434]: Creating consumer directory: =
/var/run/lttng/kconsumerd (in set_consumer_sockets() at main.c:5407)=0A=
Warning: No tracing group detected=0A=
DEBUG1 - 07:58:17.498065 [1434/1436]: [ht-thread] startup. (in =
thread_ht_cleanup() at ht-cleanup.c:101)=0A=
DEBUG1 - 07:58:17.498506 [1434/1436]: epoll set max size is 20939 (in =
compat_epoll_set_max_size() at compat-epoll.c:337)=0A=
DEBUG3 - 07:58:17.498860 [1434/1436]: [ht-thread] Polling. (in =
thread_ht_cleanup() at ht-cleanup.c:124)=0A=
lttng-ring-buffer-client-discard is already loaded=0A=
Error: Unable to load required module lttng-ring-buffer-client-discard=0A=
DEBUG2 - 07:58:17.515491 [1434/1434]: Kernel tracer version validated =
(2.10, ABI 2.3) (in kernel_validate_version() at kernel.c:848)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.528152 [1434/1434]: Unable to load optional module =
lttng-probe-asoc; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.541258 [1434/1434]: Unable to load optional module =
lttng-probe-block; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.553958 [1434/1434]: Unable to load optional module =
lttng-probe-btrfs; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.566942 [1434/1434]: Unable to load optional module =
lttng-probe-compaction; continuing (in modprobe_lttng() at =
modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.578974 [1434/1434]: Unable to load optional module =
lttng-probe-ext3; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.591841 [1434/1434]: Unable to load optional module =
lttng-probe-ext4; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.604788 [1434/1434]: Unable to load optional module =
lttng-probe-gpio; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.617670 [1434/1434]: Unable to load optional module =
lttng-probe-i2c; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.638305 [1434/1434]: Unable to load optional module =
lttng-probe-irq; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.650958 [1434/1434]: Unable to load optional module =
lttng-probe-jbd; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.664471 [1434/1434]: Unable to load optional module =
lttng-probe-jbd2; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.677126 [1434/1434]: Unable to load optional module =
lttng-probe-kmem; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.690942 [1434/1434]: Unable to load optional module =
lttng-probe-kvm; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.703568 [1434/1434]: Unable to load optional module =
lttng-probe-kvm-x86; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.716574 [1434/1434]: Unable to load optional module =
lttng-probe-kvm-x86-mmu; continuing (in modprobe_lttng() at =
modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.727601 [1434/1434]: Unable to load optional module =
lttng-probe-lock; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.745026 [1434/1434]: Unable to load optional module =
lttng-probe-module; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.757387 [1434/1434]: Unable to load optional module =
lttng-probe-napi; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.769542 [1434/1434]: Unable to load optional module =
lttng-probe-net; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.780022 [1434/1434]: Unable to load optional module =
lttng-probe-power; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.793087 [1434/1434]: Unable to load optional module =
lttng-probe-printk; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.805901 [1434/1434]: Unable to load optional module =
lttng-probe-random; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.819479 [1434/1434]: Unable to load optional module =
lttng-probe-rcu; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.832758 [1434/1434]: Unable to load optional module =
lttng-probe-regmap; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.845500 [1434/1434]: Unable to load optional module =
lttng-probe-regulator; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.858623 [1434/1434]: Unable to load optional module =
lttng-probe-rpm; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.871796 [1434/1434]: Unable to load optional module =
lttng-probe-sched; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.886748 [1434/1434]: Unable to load optional module =
lttng-probe-scsi; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.899621 [1434/1434]: Unable to load optional module =
lttng-probe-signal; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.916513 [1434/1434]: Unable to load optional module =
lttng-probe-skb; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.929088 [1434/1434]: Unable to load optional module =
lttng-probe-sock; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.941770 [1434/1434]: Unable to load optional module =
lttng-probe-statedump; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.954229 [1434/1434]: Unable to load optional module =
lttng-probe-sunrpc; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.967212 [1434/1434]: Unable to load optional module =
lttng-probe-timer; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.980419 [1434/1434]: Unable to load optional module =
lttng-probe-udp; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:17.997440 [1434/1434]: Unable to load optional module =
lttng-probe-vmscan; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:18.903033 [1434/1434]: Unable to load optional module =
lttng-probe-v4l2; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:18.220562 [1434/1434]: Unable to load optional module =
lttng-probe-workqueue; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:18.346984 [1434/1434]: Unable to load optional module =
lttng-probe-writeback; continuing (in modprobe_lttng() at modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:18.480839 [1434/1434]: Unable to load optional module =
lttng-probe-x86-irq-vectors; continuing (in modprobe_lttng() at =
modprobe.c:341)=0A=
Usage:=0A=
        modprobe module=0A=
DEBUG1 - 07:58:18.607223 [1434/1434]: Unable to load optional module =
lttng-probe-x86-exceptions; continuing (in modprobe_lttng() at =
modprobe.c:341)=0A=
DEBUG1 - 07:58:18.609977 [1434/1434]: Kernel tracer fd 20 (in =
init_kernel_tracer() at main.c:2811)=0A=
DEBUG3 - 07:58:18.611459 [1434/1434]: Syscall init system call table (in =
syscall_init_table() at syscall.c:53)=0A=
DEBUG1 - 07:58:18.233889 [1434/1434]: Reallocating syscall table from =
256 to 4002 entries (in syscall_init_table() at syscall.c:99)=0A=
DEBUG1 - 07:58:18.241686 [1434/1434]: Reallocating syscall table from =
4002 to 8004 entries (in syscall_init_table() at syscall.c:99)=0A=
DEBUG2 - 07:58:18.283545 [1434/1434]: Creating consumer directory: =
/var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:5407)=0A=
DEBUG2 - 07:58:18.284197 [1434/1434]: Creating consumer directory: =
/var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:5407)=0A=
DEBUG3 - 07:58:18.284880 [1434/1434]: Session daemon client socket 23 =
and application socket 24 created (in init_daemon_socket() at =
main.c:5273)=0A=
DEBUG1 - 07:58:18.285821 [1434/1434]: All permissions are set (in =
set_permissions() at main.c:5353)=0A=
DEBUG3 - 07:58:18.286201 [1434/1434]: Created hashtable size 4 at =
0x4d3010 of type 2 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG3 - 07:58:18.286554 [1434/1434]: Global buffer per UID registry =
initialized (in buffer_reg_init_uid_registry() at buffer-registry.c:99)=0A=
DEBUG3 - 07:58:18.286822 [1434/1434]: Created hashtable size 4 at =
0x4d3130 of type 2 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG3 - 07:58:18.287228 [1434/1434]: Global buffer per PID registry =
initialized (in buffer_reg_init_pid_registry() at buffer-registry.c:228)=0A=
DEBUG1 - 07:58:18.287569 [1434/1434]: Command subsystem initialized (in =
cmd_init() at cmd.c:4115)=0A=
DEBUG1 - 07:58:18.288020 [1434/1434]: Pid 1434 written in file =
/var/run/lttng/lttng-sessiond.pid (in utils_create_pid_file() at =
utils.c:507)=0A=
DEBUG1 - 07:58:18.288313 [1434/1434]: Pid 5345 written in file =
/var/run/lttng/agent.port (in utils_create_pid_file() at utils.c:507)=0A=
DEBUG1 - 07:58:18.288616 [1434/1434]: TCP inet operation timeout set to =
216 sec (in lttcomm_inet_init() at inet.c:547)=0A=
DEBUG1 - 07:58:18.290758 [1434/1526]: [thread] Manage application =
registration started (in thread_registration_apps() at main.c:2180)=0A=
DEBUG1 - 07:58:18.291055 [1434/1526]: Notifying applications of session =
daemon state: 1 (in notify_ust_apps() at main.c:840)=0A=
DEBUG1 - 07:58:18.291422 [1434/1527]: [thread] Manage application =
started (in thread_manage_apps() at main.c:1621)=0A=
DEBUG1 - 07:58:18.292246 [1434/1527]: Apps thread polling (in =
thread_manage_apps() at main.c:1651)=0A=
DEBUG1 - 07:58:18.291736 [1434/1526]: Got the wait shm fd 35 (in =
get_wait_shm() at shm.c:115)=0A=
DEBUG1 - 07:58:18.292689 [1434/1526]: Futex wait update active 1 (in =
futex_wait_update() at futex.c:65)=0A=
DEBUG1 - 07:58:18.292853 [1434/1526]: Accepting application registration =
(in thread_registration_apps() at main.c:2217)=0A=
DEBUG1 - 07:58:18.291535 [1434/1531]: [load-session-thread] Load session =
(in thread_load_session() at load-session-thread.c:91)=0A=
DEBUG1 - 07:58:18.293110 [1434/1528]: [ust-thread] Manage application =
notify command (in ust_thread_manage_notify() at ust-thread.c:40)=0A=
DEBUG3 - 07:58:18.293318 [1434/1528]: [ust-thread] Manage notify polling =
(in ust_thread_manage_notify() at ust-thread.c:69)=0A=
DEBUG1 - 07:58:18.293503 [1434/1529]: [agent-thread] Manage agent =
application registration. (in agent_thread_manage_registration() at =
agent-thread.c:236)=0A=
DEBUG3 - 07:58:18.293950 [1434/1529]: URI string: tcp://localhost (in =
uri_parse() at uri.c:324)=0A=
DEBUG2 - 07:58:18.294377 [1434/1529]: IP address resolved to 127.0.0.1 =
(in set_ip_address() at uri.c:165)=0A=
DEBUG3 - 07:58:18.294536 [1434/1529]: URI dtype: 1, proto: 1, host: =
localhost, subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:538)=0A=
DEBUG1 - 07:58:18.294851 [1434/1529]: [agent-thread] Listening on TCP =
port 5345 and socket 37 (in init_tcp_socket() at agent-thread.c:119)=0A=
DEBUG3 - 07:58:18.295052 [1434/1529]: [agent-thread] Manage agent =
polling (in agent_thread_manage_registration() at agent-thread.c:263)=0A=
DEBUG1 - 07:58:18.293628 [1434/1530]: [thread] Thread manage kernel =
started (in thread_manage_kernel() at main.c:1089)=0A=
DEBUG1 - 07:58:18.295339 [1434/1530]: Updating kernel poll set (in =
update_kernel_poll() at main.c:924)=0A=
DEBUG1 - 07:58:18.295609 [1434/1530]: Thread kernel polling (in =
thread_manage_kernel() at main.c:1134)=0A=
DEBUG1 - 07:58:18.296118 [1434/1525]: [thread] Dispatch UST command =
started (in thread_dispatch_ust_registration() at main.c:1935)=0A=
DEBUG1 - 07:58:18.296286 [1434/1525]: Futex n to 1 prepare done (in =
futex_nto1_prepare() at futex.c:77)=0A=
DEBUG1 - 07:58:18.296416 [1434/1525]: Woken up but nothing in the UST =
command queue (in thread_dispatch_ust_registration() at main.c:1962)=0A=
DEBUG1 - 07:58:18.296601 [1434/1524]: [thread] Manage client started (in =
thread_manage_clients() at main.c:4447)=0A=
DEBUG1 - 07:58:18.296864 [1434/1524]: Accepting client command ... (in =
thread_manage_clients() at main.c:4494)=0A=
DEBUG1 - 07:58:18.297766 [1434/1523]: [notification-thread] Started =
notification thread (in thread_notification() at =
notification-thread.c:482)=0A=
DEBUG1 - 07:58:18.298018 [1434/1523]: [notification-thread] Creating =
notification channel UNIX socket at /var/run/lttng/sessiond-notification =
(in notification_channel_socket_create() at notification-thread.c:221)=0A=
DEBUG1 - 07:58:18.298411 [1434/1523]: [notification-thread] Notification =
channel UNIX socket created (fd =3D 40) (in =
notification_channel_socket_create() at notification-thread.c:248)=0A=
DEBUG1 - 07:58:18.298624 [1434/1523]: [notification-thread] Listening on =
notification channel socket (in init_thread_state() at =
notification-thread.c:387)=0A=
DEBUG1 - 07:58:18.298891 [1434/1523]: [notification-thread] Entering =
poll wait (in thread_notification() at notification-thread.c:507)=0A=
DEBUG1 - 07:58:18.299094 [1434/1522]: [thread] Manage health check =
started (in thread_manage_health() at main.c:4256)=0A=
DEBUG1 - 07:58:18.299520 [1434/1522]: Health check ready (in =
thread_manage_health() at main.c:4318)=0A=
=0A=
=0A=
[In other shell run 'lttng create']=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
DEBUG1 - 07:59:26.687827 [1434/1524]: Wait for client response (in =
thread_manage_clients() at main.c:4546)=0A=
DEBUG1 - 07:59:26.688889 [1434/1524]: Receiving data from client ... (in =
thread_manage_clients() at main.c:4591)=0A=
DEBUG1 - 07:59:26.689952 [1434/1524]: Nothing recv() from client... =
continuing (in thread_manage_clients() at main.c:4595)=0A=
DEBUG1 - 07:59:26.690280 [1434/1524]: Clean command context structure =
(in clean_command_ctx() at main.c:820)=0A=
DEBUG1 - 07:59:26.690427 [1434/1524]: Accepting client command ... (in =
thread_manage_clients() at main.c:4494)=0A=
DEBUG1 - 07:59:26.692301 [1434/1524]: Wait for client response (in =
thread_manage_clients() at main.c:4546)=0A=
DEBUG1 - 07:59:26.692590 [1434/1524]: Receiving data from client ... (in =
thread_manage_clients() at main.c:4591)=0A=
DEBUG1 - 07:59:26.693632 [1434/1524]: Processing client command 8 (in =
process_client_msg() at main.c:3063)=0A=
DEBUG1 - 07:59:26.693916 [1434/1524]: Waiting for 1 URIs from client ... =
(in process_client_msg() at main.c:3846)=0A=
DEBUG2 - 07:59:26.695176 [1434/1524]: Trying to find session by name =
auto-20171114-075926 (in session_find_by_name() at session.c:276)=0A=
DEBUG3 - 07:59:26.695545 [1434/1524]: Created hashtable size 4 at =
0x4d7f38 of type 1 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG1 - 07:59:26.695906 [1434/1524]: Allocating ltt_sessions_ht_by_id =
(in ltt_sessions_ht_alloc() at session.c:153)=0A=
DEBUG3 - 07:59:26.696090 [1434/1524]: Created hashtable size 4 at =
0x4d8090 of type 2 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG1 - 07:59:26.696424 [1434/1524]: Tracing session =
auto-20171114-075926 created with ID 0 by UID 0 GID 0 (in =
session_create() at session.c:420)=0A=
DEBUG2 - 07:59:26.696629 [1434/1524]: Trying to find session by name =
auto-20171114-075926 (in session_find_by_name() at session.c:276)=0A=
DEBUG3 - 07:59:26.696860 [1434/1524]: Created hashtable size 4 at =
0x4d3c98 of type 1 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG2 - 07:59:26.697059 [1434/1524]: Setting trace directory path from =
URI to /root/lttng-traces/auto-20171114-075926 (in add_uri_to_consumer() =
at cmd.c:786)=0A=
DEBUG1 - 07:59:26.697261 [1434/1524]: Sending response (size: 20, =
retcode: Success (10)) (in thread_manage_clients() at main.c:4641)=0A=
DEBUG1 - 07:59:26.697540 [1434/1524]: Clean command context structure =
(in clean_command_ctx() at main.c:820)=0A=
DEBUG1 - 07:59:26.697695 [1434/1524]: Accepting client command ... (in =
thread_manage_clients() at main.c:4494)=0A=
=0A=
=0A=
[In other shell run 'lttng list -k']=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
DEBUG1 - 07:59:41.525342 [1434/1524]: Wait for client response (in =
thread_manage_clients() at main.c:4546)=0A=
DEBUG1 - 07:59:41.525684 [1434/1524]: Receiving data from client ... (in =
thread_manage_clients() at main.c:4591)=0A=
DEBUG1 - 07:59:41.526966 [1434/1524]: Processing client command 14 (in =
process_client_msg() at main.c:3063)=0A=
DEBUG1 - 07:59:41.527532 [1434/1524]: Kernel list events done (1 events) =
(in kernel_list_events() at kernel.c:797)=0A=
DEBUG1 - 07:59:41.531880 [1434/1524]: Sending response (size: 604, =
retcode: Success (10)) (in thread_manage_clients() at main.c:4641)=0A=
DEBUG1 - 07:59:41.540716 [1434/1524]: Clean command context structure =
(in clean_command_ctx() at main.c:820)=0A=
DEBUG1 - 07:59:41.543452 [1434/1524]: Accepting client command ... (in =
thread_manage_clients() at main.c:4494)=0A=
=0A=
=0A=
[In other shell run 'lttng enable-event --kernel --syscall open,close']=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
DEBUG1 - 08:00:52.222034 [1434/1524]: Wait for client response (in =
thread_manage_clients() at main.c:4546)=0A=
DEBUG1 - 08:00:52.224978 [1434/1524]: Receiving data from client ... (in =
thread_manage_clients() at main.c:4591)=0A=
DEBUG1 - 08:00:52.235134 [1434/1524]: Processing client command 6 (in =
process_client_msg() at main.c:3063)=0A=
DEBUG1 - 08:00:52.237783 [1434/1524]: Getting session =
auto-20171114-075926 by name (in process_client_msg() at main.c:3156)=0A=
DEBUG2 - 08:00:52.239211 [1434/1524]: Trying to find session by name =
auto-20171114-075926 (in session_find_by_name() at session.c:276)=0A=
DEBUG1 - 08:00:52.240627 [1434/1524]: Creating kernel session (in =
create_kernel_session() at main.c:2979)=0A=
DEBUG3 - 08:00:52.244302 [1434/1524]: Created hashtable size 4 at =
0x4d3de0 of type 1 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG1 - 08:00:52.248977 [1434/1524]: Kernel session created (fd: 45) =
(in kernel_create_session() at kernel.c:117)=0A=
DEBUG3 - 08:00:52.250778 [1434/1524]: Copying tracing session consumer =
output in kernel session (in copy_session_consumer() at main.c:2861)=0A=
DEBUG3 - 08:00:52.253404 [1434/1524]: Created hashtable size 4 at =
0x4d3f30 of type 1 (in lttng_ht_new() at hashtable.c:145)=0A=
DEBUG3 - 08:00:52.256736 [1434/1524]: Copy session consumer subdir =
/kernel (in copy_session_consumer() at main.c:2899)=0A=
DEBUG3 - 08:00:52.258859 [1434/1524]: mkdir() recursive =
/root/lttng-traces/auto-20171114-075926 with mode 504 for uid 0 and gid =
0 (in run_as_mkdir_recursive() at runas.c:470)=0A=
DEBUG1 - 08:00:52.260952 [1434/1524]: Using run_as worker (in run_as() =
at runas.c:450)=0A=
DEBUG3 - 08:00:52.265454 [1434/1436]: [ht-thread] Returning from poll on =
2 fds. (in thread_ht_cleanup() at ht-cleanup.c:128)=0A=
DEBUG1 - 08:00:52.308737 [1434/1524]: Spawning consumerd (in =
spawn_consumerd() at main.c:2557)=0A=
DEBUG2 - 08:00:52.333496 [1434/1524]: Consumer pid 1535 (in =
start_consumerd() at main.c:2742)=0A=
DEBUG2 - 08:00:52.337386 [1434/1524]: Spawning consumer control thread =
(in start_consumerd() at main.c:2745)=0A=
DEBUG3 - 08:00:52.348620 [1535/1535]: Looking for a kernel consumer at =
these locations: (in spawn_consumerd() at main.c:2579)=0A=
DEBUG3 - 08:00:52.352759 [1535/1535]:   1)  (in spawn_consumerd() at =
main.c:2580)=0A=
DEBUG3 - 08:00:52.355359 [1535/1535]:   2) =
/usr/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at =
main.c:2581)=0A=
DEBUG3 - 08:00:52.359185 [1535/1535]:   3) =
/usr/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at =
main.c:2582)=0A=
DEBUG3 - 08:00:52.413405 [1434/1436]: [ht-thread] Polling. (in =
thread_ht_cleanup() at ht-cleanup.c:124)=0A=
DEBUG3 - 08:00:52.390930 [1535/1535]: Found location #2 (in =
spawn_consumerd() at main.c:2587)=0A=
DEBUG1 - 08:00:52.418411 [1535/1535]: Using kernel consumer at: =
/usr/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at =
main.c:2597)=0A=
DEBUG1 - 08:00:52.477869 [1434/1536]: [thread] Manage consumer started =
(in thread_manage_consumer() at main.c:1264)=0A=
DEBUG1 - 08:00:52.163232 [1535/1535]: Health check time delta in seconds =
set to 20 (in health_init() at health.c:73)=0A=
DEBUG1 - 08:00:52.169841 [1535/1535]: TCP inet operation timeout set to =
216 sec (in lttcomm_inet_init() at inet.c:547)=0A=
DEBUG1 - 08:00:52.176157 [1538/1538]: Resetting run_as worker signal =
handlers to default (in reset_sighandler() at runas.c:536)=0A=
DEBUG1 - 08:00:52.178355 [1538/1538]: run_as signal handler set for =
SIGTERM and SIGINT (in set_worker_sighandlers() at runas.c:597)=0A=
DEBUG1 - 08:00:52.179009 [1535/1535]: Connecting to error socket =
/var/run/lttng/kconsumerd/error (in main() at lttng-consumerd.c:464)=0A=
DEBUG2 - 08:00:52.180061 [1434/1536]: Receiving code from consumer =
err_sock (in thread_manage_consumer() at main.c:1362)=0A=
DEBUG1 - 08:00:52.180486 [1535/1539]: [thread] Manage health check =
started (in thread_manage_health() at health-consumerd.c:167)=0A=
Warning: No tracing group detected=0A=
DEBUG1 - 08:00:52.181799 [1535/1539]: epoll set max size is 20939 (in =
compat_epoll_set_max_size() at compat-epoll.c:337)=0A=
DEBUG1 - 08:00:52.182145 [1535/1539]: Health check ready (in =
thread_manage_health() at health-consumerd.c:240)=0A=
DEBUG1 - 08:00:52.281092 [1535/1544]: Creating command socket =
/var/run/lttng/kconsumerd/command (in consumer_thread_sessiond_poll() at =
consumer.c:3114)=0A=
DEBUG1 - 08:00:52.285795 [1535/1544]: Sending ready command to =
lttng-sessiond (in consumer_thread_sessiond_poll() at consumer.c:3127)=0A=
DEBUG1 - 08:00:52.288277 [1434/1536]: Consumer command socket ready (fd: =
48 (in thread_manage_consumer() at main.c:1402)=0A=
DEBUG1 - 08:00:52.288489 [1434/1536]: Consumer metadata socket ready =
(fd: 49) (in thread_manage_consumer() at main.c:1404)=0A=
DEBUG3 - 08:00:52.288728 [1434/1536]: Sending set_channel_monitor_pipe =
command to consumer (in consumer_send_channel_monitor_pipe() at =
consumer.c:1067)=0A=
DEBUG1 - 08:00:52.289109 [1535/1544]: Connection on client_socket (in =
consumer_thread_sessiond_poll() at consumer.c:3149)=0A=
DEBUG1 - 08:00:52.289536 [1535/1544]: Metadata connection on =
client_socket (in set_metadata_socket() at consumer.c:3075)=0A=
DEBUG1 - 08:00:52.289904 [1535/1544]: Incoming command on sock (in =
consumer_thread_sessiond_poll() at consumer.c:3195)=0A=
DEBUG3 - 08:00:52.290468 [1434/1536]: Sending channel monitoring pipe 12 =
to consumer on socket 48 (in consumer_send_channel_monitor_pipe() at =
consumer.c:1074)=0A=
DEBUG1 - 08:00:52.290828 [1535/1544]: Received channel monitor pipe (29) =
(in lttng_kconsumer_recv_cmd() at kernel-consumer.c:1062)=0A=
DEBUG1 - 08:00:52.293375 [1535/1544]: Channel monitor pipe set as =
non-blocking (in lttng_kconsumer_recv_cmd() at kernel-consumer.c:1083)=0A=
DEBUG2 - 08:00:52.293686 [1434/1536]: Channel monitoring pipe =
successfully sent (in consumer_send_channel_monitor_pipe() at =
consumer.c:1080)=0A=
DEBUG3 - 08:00:52.294463 [1434/1524]: Consumer socket created (fd: 48) =
and added to output (in consumer_create_socket() at consumer.c:301)=0A=
DEBUG1 - 08:00:52.294704 [1434/1524]: Setting relayd for session =
auto-20171114-075926 (in cmd_setup_relayd() at cmd.c:1035)=0A=
DEBUG1 - 08:00:52.294866 [1434/1524]: Enable event command for event =
'open' (in _cmd_enable_event() at cmd.c:1840)=0A=
DEBUG1 - 08:00:52.295012 [1434/1524]: Trying to find channel channel0 =
(in trace_kernel_get_channel_by_name() at trace-kernel.c:50)=0A=
DEBUG1 - 08:00:52.295202 [1434/1524]: Enabling channel  for session =
auto-20171114-075926 (in cmd_enable_channel() at cmd.c:1338)=0A=
DEBUG1 - 08:00:52.295370 [1434/1524]: Trying to find channel channel0 =
(in trace_kernel_get_channel_by_name() at trace-kernel.c:50)=0A=
DEBUG3 - 08:00:52.295565 [1434/1524]: Kernel create channel  with attr: =
0, 1048576, 4, 0, 200000, 0, 0 (in kernel_create_channel() at =
kernel.c:151)=0A=
DEBUG1 - 08:00:52.308336 [1434/1524]: Kernel channel channel0 created =
(fd: 50) (in kernel_create_channel() at kernel.c:173)=0A=
DEBUG1 - 08:00:52.308616 [1434/1524]: Kernel quiescent wait on 20 (in =
kernel_wait_quiescent() at kernel.c:576)=0A=
DEBUG1 - 08:00:52.308777 [1434/1524]: Trying to find channel channel0 =
(in trace_kernel_get_channel_by_name() at trace-kernel.c:50)=0A=
DEBUG1 - 08:00:52.308919 [1434/1524]: Found channel by name channel0 (in =
trace_kernel_get_channel_by_name() at trace-kernel.c:54)=0A=
DEBUG1 - 08:00:52.309115 [1434/1524]: Event open created (fd: 51) (in =
kernel_create_event() at kernel.c:258)=0A=
DEBUG1 - 08:00:52.309274 [1434/1524]: Kernel quiescent wait on 20 (in =
kernel_wait_quiescent() at kernel.c:576)=0A=
DEBUG1 - 08:00:52.309456 [1434/1524]: Sending response (size: 20, =
retcode: Success (10)) (in thread_manage_clients() at main.c:4641)=0A=
DEBUG1 - 08:00:52.309692 [1434/1524]: Clean command context structure =
(in clean_command_ctx() at main.c:820)=0A=
DEBUG1 - 08:00:52.309876 [1434/1524]: Accepting client command ... (in =
thread_manage_clients() at main.c:4494)=0A=
DEBUG1 - 08:00:52.310939 [1434/1524]: Wait for client response (in =
thread_manage_clients() at main.c:4546)=0A=
DEBUG1 - 08:00:52.311237 [1434/1524]: Receiving data from client ... (in =
thread_manage_clients() at main.c:4591)=0A=
DEBUG1 - 08:00:52.311532 [1434/1524]: Processing client command 6 (in =
process_client_msg() at main.c:3063)=0A=
DEBUG1 - 08:00:52.311721 [1434/1524]: Getting session =
auto-20171114-075926 by name (in process_client_msg() at main.c:3156)=0A=
DEBUG2 - 08:00:52.311863 [1434/1524]: Trying to find session by name =
auto-20171114-075926 (in session_find_by_name() at session.c:276)=0A=
DEBUG1 - 08:00:52.310134 [1434/1530]: Thread kernel return from poll on =
2 fds (in thread_manage_kernel() at main.c:1141)=0A=
DEBUG3 - 08:00:52.312055 [1434/1524]: Consumer socket created (fd: 48) =
and added to output (in consumer_create_socket() at consumer.c:301)=0A=
DEBUG1 - 08:00:52.312588 [1434/1524]: Setting relayd for session =
auto-20171114-075926 (in cmd_setup_relayd() at cmd.c:1035)=0A=
DEBUG1 - 08:00:52.312757 [1434/1524]: Enable event command for event =
'close' (in _cmd_enable_event() at cmd.c:1840)=0A=
DEBUG1 - 08:00:52.312900 [1434/1524]: Trying to find channel channel0 =
(in trace_kernel_get_channel_by_name() at trace-kernel.c:50)=0A=
DEBUG1 - 08:00:52.313040 [1434/1524]: Found channel by name channel0 (in =
trace_kernel_get_channel_by_name() at trace-kernel.c:54)=0A=
DEBUG1 - 08:00:52.313177 [1434/1524]: Trying to find channel channel0 =
(in trace_kernel_get_channel_by_name() at trace-kernel.c:50)=0A=
DEBUG1 - 08:00:52.313882 [1434/1524]: Found channel by name channel0 (in =
trace_kernel_get_channel_by_name() at trace-kernel.c:54)=0A=
DEBUG1 - 08:00:52.314100 [1434/1524]: Event close created (fd: 52) (in =
kernel_create_event() at kernel.c:258)=0A=
DEBUG1 - 08:00:52.314410 [1434/1524]: Kernel quiescent wait on 20 (in =
kernel_wait_quiescent() at kernel.c:576)=0A=
DEBUG1 - 08:00:52.314599 [1434/1524]: Sending response (size: 20, =
retcode: Success (10)) (in thread_manage_clients() at main.c:4641)=0A=
DEBUG1 - 08:00:52.314824 [1434/1524]: Clean command context structure =
(in clean_command_ctx() at main.c:820)=0A=
DEBUG1 - 08:00:52.314979 [1434/1524]: Accepting client command ... (in =
thread_manage_clients() at main.c:4494)=0A=
DEBUG1 - 08:00:52.312408 [1434/1530]: Updating kernel poll set (in =
update_kernel_poll() at main.c:924)=0A=
DEBUG1 - 08:00:52.315229 [1434/1530]: Channel fd 50 added to kernel set =
(in update_kernel_poll() at main.c:942)=0A=
DEBUG1 - 08:00:52.315389 [1434/1530]: Thread kernel polling (in =
thread_manage_kernel() at main.c:1134)=0A=
DEBUG1 - 08:00:52.315535 [1434/1530]: Thread kernel return from poll on =
3 fds (in thread_manage_kernel() at main.c:1141)=0A=
DEBUG1 - 08:00:52.315679 [1434/1530]: Updating kernel streams for =
channel fd 50 (in update_kernel_stream() at main.c:968)=0A=
DEBUG1 - 08:00:52.315818 [1434/1530]: Channel found, updating kernel =
streams (in update_kernel_stream() at main.c:987)=0A=
DEBUG1 - 08:00:52.315996 [1434/1530]: Kernel stream channel0_0 created =
(fd: 44, state: 0) (in kernel_open_channel_stream() at kernel.c:692)=0A=
DEBUG1 - 08:00:52.316166 [1434/1530]: Thread kernel polling (in =
thread_manage_kernel() at main.c:1134)=0A=
DEBUG1 - 08:00:52.317896 [1535/1544]: received command on sock (in =
consumer_thread_sessiond_poll() at consumer.c:3211)=0A=
DEBUG1 - 08:00:52.318398 [1535/1543]: Updating poll fd array (in =
update_poll_array() at consumer.c:1091)=0A=
DEBUG1 - 08:00:52.319432 [1535/1543]: polling on 2 fd (in =
consumer_thread_data_poll() at consumer.c:2535)=0A=
DEBUG1 - 08:00:52.319817 [1535/1542]: Thread metadata poll started (in =
consumer_thread_metadata_poll() at consumer.c:2253)=0A=
DEBUG1 - 08:00:52.320090 [1535/1542]: Metadata main loop started (in =
consumer_thread_metadata_poll() at consumer.c:2269)=0A=
DEBUG1 - 08:00:52.320322 [1535/1542]: Metadata poll wait (in =
consumer_thread_metadata_poll() at consumer.c:2275)=0A=
DEBUG1 - 08:00:52.321033 [1535/1541]: Thread channel poll started (in =
consumer_thread_channel_poll() at consumer.c:2846)=0A=
DEBUG1 - 08:00:52.321453 [1535/1541]: Channel main loop started (in =
consumer_thread_channel_poll() at consumer.c:2861)=0A=
DEBUG1 - 08:00:52.321691 [1535/1541]: Channel poll wait (in =
consumer_thread_channel_poll() at consumer.c:2866)=0A=
=0A=
=0A=
[In other shell run 'lttng start']=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
DEBUG1 - 08:01:19.494013 [1434/1524]: Wait for client response (in =
thread_manage_clients() at main.c:4546)=0A=
DEBUG1 - 08:01:19.494302 [1434/1524]: Receiving data from client ... (in =
thread_manage_clients() at main.c:4591)=0A=
DEBUG1 - 08:01:19.495671 [1434/1524]: Processing client command 16 (in =
process_client_msg() at main.c:3063)=0A=
DEBUG1 - 08:01:19.495935 [1434/1524]: Getting session =
auto-20171114-075926 by name (in process_client_msg() at main.c:3156)=0A=
DEBUG2 - 08:01:19.496078 [1434/1524]: Trying to find session by name =
auto-20171114-075926 (in session_find_by_name() at session.c:276)=0A=
DEBUG1 - 08:01:19.501870 [1434/1524]: [trace] Closing metadata fd -1 (in =
trace_kernel_destroy_metadata() at trace-kernel.c:569)=0A=
DEBUG1 - 08:01:19.502098 [1434/1524]: Sending response (size: 20, =
retcode: Opening metadata failed (45)) (in thread_manage_clients() at =
main.c:4641)=0A=
DEBUG1 - 08:01:19.502314 [1434/1524]: Clean command context structure =
(in clean_command_ctx() at main.c:820)=0A=
DEBUG1 - 08:01:19.502461 [1434/1524]: Accepting client command ... (in =
thread_manage_clients() at main.c:4494)=0A=

------=_NextPart_000_01C0_01D35D35.14B9FF20
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

------=_NextPart_000_01C0_01D35D35.14B9FF20--
