From: Lichuanbao <lichuanbao@hisilicon.com>
Subject: lttng trace kernel on arm64
Date: Fri, 8 Apr 2016 06:28:08 +0000
Message-ID: <BECE94944F67D640AA66E9BA499F7CE853A12931__37697.6099833429$1460247547$gmane$org@SZXEMA509-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1167125715659360222=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from szxga03-in.huawei.com (unknown [119.145.14.66])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3FF2CA2E10
 for <lttng-dev@lists.lttng.org>; Fri,  8 Apr 2016 06:28:18 +0000 (UTC)
Content-Language: zh-CN
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1167125715659360222==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_BECE94944F67D640AA66E9BA499F7CE853A12931SZXEMA509MBXchi_"

--_000_BECE94944F67D640AA66E9BA499F7CE853A12931SZXEMA509MBXchi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
   I want to use lttng trace kernel event,I installed lttng-tools 2.7.1 ltt=
ng-ust 2.7.2 lttng-modules 2.7.2 on my arm64 board,
And then I create my session like sub command as root,but there is nothing =
result to view.

    # lttng create
    # lttng enable-event --kernel --all
    # lttng start
    # sleep 10               # let the system generate some activity
    # lttng stop
    # lttng view
# lttng destroy

-bash-4.3# lttng view
Trace directory: /root/lttng-traces/auto-20160407-211248

[error] Cannot open any trace for reading.

[error] opening trace "/root/lttng-traces/auto-20160407-211248" for reading=
.

[error] none of the specified trace paths could be opened.

Get thes session daemon log as follow:

bash-4.3# lttng-sessiond -vvv
DEBUG1 - 21:52:15.396991 [5621/5621]: run_as signal handler set for SIGTERM=
 and SIGINT (in set_worker_sighandlers() at runas.c:600)
DEBUG1 - 21:52:15.397410 [5620/5620]: Health check time delta in seconds se=
t to 20 (in health_init() at health.c:74)
DEBUG1 - 21:52:15.397661 [5620/5620]: epoll set max size is 27037798 (in co=
mpat_epoll_set_max_size() at compat-epoll.c:290)
DEBUG3 - 21:52:15.397838 [5620/5620]: Creating LTTng run directory: /var/ru=
n/lttng (in create_lttng_rundir() at main.c:5156)
DEBUG1 - 21:52:15.397852 [5620/5622]: [ht-thread] startup. (in thread_ht_cl=
eanup() at ht-cleanup.c:37)
DEBUG2 - 21:52:15.397986 [5620/5620]: Kernel consumer err path: /var/run/lt=
tng/kconsumerd/error (in main() at main.c:5601)
DEBUG2 - 21:52:15.398070 [5620/5620]: Kernel consumer cmd path: /var/run/lt=
tng/kconsumerd/command (in main() at main.c:5603)
DEBUG3 - 21:52:15.398034 [5620/5622]: [ht-thread] Polling. (in thread_ht_cl=
eanup() at ht-cleanup.c:67)
Error: Could not get lock file /var/run/lttng/lttng-sessiond.lck, another i=
nstance is running.
DEBUG1 - 21:52:15.398240 [5620/5620]: Cleanup sessiond (in sessiond_cleanup=
() at main.c:622)
DEBUG1 - 21:52:15.398294 [5620/5620]: Removing sessiond and consumerd conte=
nt of directory /var/run/lttng (in sessiond_cleanup() at main.c:641)
DEBUG1 - 21:52:15.398321 [5620/5620]: Removing /var/run/lttng/lttng-session=
d.pid (in sessiond_cleanup() at main.c:647)
DEBUG1 - 21:52:15.398372 [5620/5620]: Removing /var/run/lttng/agent.port (i=
n sessiond_cleanup() at main.c:652)
DEBUG1 - 21:52:15.398420 [5620/5620]: Removing /var/run/lttng/kconsumerd/er=
ror (in sessiond_cleanup() at main.c:659)
DEBUG1 - 21:52:15.398472 [5620/5620]: Removing directory /var/run/lttng/kco=
nsumerd (in sessiond_cleanup() at main.c:665)
DEBUG1 - 21:52:15.398526 [5620/5620]: Removing /var/run/lttng/ustconsumerd3=
2/error (in sessiond_cleanup() at main.c:672)
DEBUG1 - 21:52:15.398579 [5620/5620]: Removing directory /var/run/lttng/ust=
consumerd32 (in sessiond_cleanup() at main.c:678)
DEBUG1 - 21:52:15.398620 [5620/5620]: Removing /var/run/lttng/ustconsumerd6=
4/error (in sessiond_cleanup() at main.c:685)
DEBUG1 - 21:52:15.398673 [5620/5620]: Removing directory /var/run/lttng/ust=
consumerd64 (in sessiond_cleanup() at main.c:691)
DEBUG1 - 21:52:15.398734 [5620/5620]: Cleaning up all sessions (in sessiond=
_cleanup() at main.c:694)
DEBUG1 - 21:52:15.398765 [5620/5620]: Cleaning up all agent apps (in sessio=
nd_cleanup() at main.c:711)
DEBUG1 - 21:52:15.398789 [5620/5620]: Closing all UST sockets (in sessiond_=
cleanup() at main.c:714)
DEBUG2 - 21:52:15.398813 [5620/5620]: UST app cleaning registered apps hash=
 table (in ust_app_clean_list() at ust-app.c:3702)
DEBUG3 - 21:52:15.398837 [5620/5620]: Buffer registry destroy all registry =
(in buffer_reg_destroy_registries() at buffer-registry.c:716)
DEBUG2 - 21:52:15.398861 [5620/5620]: Closing kernel fd (in sessiond_cleanu=
p() at main.c:719)
DEBUG1 - 21:52:15.398884 [5620/5620]: Unloading kernel modules (in sessiond=
_cleanup() at main.c:726)
DEBUG1 - 21:52:15.403580 [5620/5620]: Modprobe removal successful lttng-kre=
tprobes (in modprobe_remove_lttng() at modprobe.c:126)
DEBUG1 - 21:52:15.407855 [5620/5620]: Modprobe removal successful lttng-kpr=
obes (in modprobe_remove_lttng() at modprobe.c:126)
DEBUG1 - 21:52:15.412073 [5620/5620]: Modprobe removal successful lttng-ftr=
ace (in modprobe_remove_lttng() at modprobe.c:126)
DEBUG1 - 21:52:15.416256 [5620/5620]: Modprobe removal successful lttng-typ=
es (in modprobe_remove_lttng() at modprobe.c:126)
DEBUG1 - 21:52:15.420593 [5620/5620]: Modprobe removal successful lttng-rin=
g-buffer-metadata-mmap-client (in modprobe_remove_lttng() at modprobe.c:126=
)
DEBUG1 - 21:52:15.425108 [5620/5620]: Modprobe removal successful lttng-rin=
g-buffer-client-mmap-overwrite (in modprobe_remove_lttng() at modprobe.c:12=
6)
DEBUG1 - 21:52:15.429745 [5620/5620]: Modprobe removal successful lttng-rin=
g-buffer-client-mmap-discard (in modprobe_remove_lttng() at modprobe.c:126)
Error: Unable to remove module lttng-ring-buffer-metadata-client
DEBUG1 - 21:52:15.438779 [5620/5620]: Modprobe removal successful lttng-rin=
g-buffer-client-overwrite (in modprobe_remove_lttng() at modprobe.c:126)
Error: Unable to remove module lttng-ring-buffer-client-discard
Error: Unable to remove module lttng-lib-ring-buffer
Error: Unable to remove module lttng-tracer
DEBUG3 - 21:52:15.452135 [5620/5622]: [ht-thread] Returning from poll on 2 =
fds. (in thread_ht_cleanup() at ht-cleanup.c:74)
DEBUG1 - 21:52:15.452186 [5620/5622]: [ht-cleanup] quit. (in thread_ht_clea=
nup() at ht-cleanup.c:153)
DEBUG1 - 21:52:15.452225 [5620/5622]: [ht-cleanup] Thread terminates. (in t=
hread_ht_cleanup() at ht-cleanup.c:164)
DEBUG1 - 21:52:15.452333 [5620/5620]: Cleaning up options (in sessiond_clea=
nup_options() at main.c:773)
DEBUG1 - 21:52:15.453308 [5620/5620]: lttng-runas terminated with status co=
de 0 (in run_as_destroy_worker() at runas.c:737)
DEBUG1 - 21:52:15.453349 [5620/5620]: *** assert failed :-) *** =3D=3D> Mat=
thew, BEET driven development works! (in sessiond_cleanup_options() at main=
.c:805)


can anybody help me ?

thanks very much.

lichuanbao

ShenZhen in China



--_000_BECE94944F67D640AA66E9BA499F7CE853A12931SZXEMA509MBXchi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"\7EAF\6587\672C Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.Char
	{mso-style-name:"\7EAF\6587\672C Char";
	mso-style-priority:99;
	mso-style-link:\7EAF\6587\672C;
	font-family:"Calibri","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; I want to use lttn=
g trace kernel event,I installed lttng-tools 2.7.1 lttng-ust 2.7.2 lttng-mo=
dules 2.7.2 on my arm64 board,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">And then I create my session li=
ke sub command as root,but there is nothing result to view.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; # lttng crea=
te<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; # lttng enab=
le-event --kernel --all<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; # lttng star=
t<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; # sleep 10&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; # let the system generate some activity<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; # lttng stop=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; # lttng view=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US"># =
lttng destroy<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-bash-4.3# lttng view<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Trace directory: /root/lttng-tr=
aces/auto-20160407-211248<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[error] Cannot open any trace f=
or reading.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[error] opening trace &quot;/ro=
ot/lttng-traces/auto-20160407-211248&quot; for reading.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">[error] none of the specified t=
race paths could be opened.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Get thes session daemon log as =
follow:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">bash-4.3# lttng-sessiond -vvv&n=
bsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.396991 [5621/=
5621]: run_as signal handler set for SIGTERM and SIGINT (in set_worker_sigh=
andlers() at runas.c:600)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.397410 [5620/=
5620]: Health check time delta in seconds set to 20 (in health_init() at he=
alth.c:74)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.397661 [5620/=
5620]: epoll set max size is 27037798 (in compat_epoll_set_max_size() at co=
mpat-epoll.c:290)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 - 21:52:15.397838 [5620/=
5620]: Creating LTTng run directory: /var/run/lttng (in create_lttng_rundir=
() at main.c:5156)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.397852 [5620/=
5622]: [ht-thread] startup. (in thread_ht_cleanup() at ht-cleanup.c:37)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG2 - 21:52:15.397986 [5620/=
5620]: Kernel consumer err path: /var/run/lttng/kconsumerd/error (in main()=
 at main.c:5601)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG2 - 21:52:15.398070 [5620/=
5620]: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command (in main=
() at main.c:5603)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 - 21:52:15.398034 [5620/=
5622]: [ht-thread] Polling. (in thread_ht_cleanup() at ht-cleanup.c:67)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Error: Could not get lock file =
/var/run/lttng/lttng-sessiond.lck, another instance is running.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398240 [5620/=
5620]: Cleanup sessiond (in sessiond_cleanup() at main.c:622)<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398294 [5620/=
5620]: Removing sessiond and consumerd content of directory /var/run/lttng =
(in sessiond_cleanup() at main.c:641)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398321 [5620/=
5620]: Removing /var/run/lttng/lttng-sessiond.pid (in sessiond_cleanup() at=
 main.c:647)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398372 [5620/=
5620]: Removing /var/run/lttng/agent.port (in sessiond_cleanup() at main.c:=
652)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398420 [5620/=
5620]: Removing /var/run/lttng/kconsumerd/error (in sessiond_cleanup() at m=
ain.c:659)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398472 [5620/=
5620]: Removing directory /var/run/lttng/kconsumerd (in sessiond_cleanup() =
at main.c:665)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398526 [5620/=
5620]: Removing /var/run/lttng/ustconsumerd32/error (in sessiond_cleanup() =
at main.c:672)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398579 [5620/=
5620]: Removing directory /var/run/lttng/ustconsumerd32 (in sessiond_cleanu=
p() at main.c:678)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398620 [5620/=
5620]: Removing /var/run/lttng/ustconsumerd64/error (in sessiond_cleanup() =
at main.c:685)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398673 [5620/=
5620]: Removing directory /var/run/lttng/ustconsumerd64 (in sessiond_cleanu=
p() at main.c:691)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398734 [5620/=
5620]: Cleaning up all sessions (in sessiond_cleanup() at main.c:694)<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398765 [5620/=
5620]: Cleaning up all agent apps (in sessiond_cleanup() at main.c:711)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398789 [5620/=
5620]: Closing all UST sockets (in sessiond_cleanup() at main.c:714)<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG2 - 21:52:15.398813 [5620/=
5620]: UST app cleaning registered apps hash table (in ust_app_clean_list()=
 at ust-app.c:3702)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 - 21:52:15.398837 [5620/=
5620]: Buffer registry destroy all registry (in buffer_reg_destroy_registri=
es() at buffer-registry.c:716)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG2 - 21:52:15.398861 [5620/=
5620]: Closing kernel fd (in sessiond_cleanup() at main.c:719)<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.398884 [5620/=
5620]: Unloading kernel modules (in sessiond_cleanup() at main.c:726)<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.403580 [5620/=
5620]: Modprobe removal successful lttng-kretprobes (in modprobe_remove_ltt=
ng() at modprobe.c:126)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.407855 [5620/=
5620]: Modprobe removal successful lttng-kprobes (in modprobe_remove_lttng(=
) at modprobe.c:126)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.412073 [5620/=
5620]: Modprobe removal successful lttng-ftrace (in modprobe_remove_lttng()=
 at modprobe.c:126)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.416256 [5620/=
5620]: Modprobe removal successful lttng-types (in modprobe_remove_lttng() =
at modprobe.c:126)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.420593 [5620/=
5620]: Modprobe removal successful lttng-ring-buffer-metadata-mmap-client (=
in modprobe_remove_lttng() at modprobe.c:126)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.425108 [5620/=
5620]: Modprobe removal successful lttng-ring-buffer-client-mmap-overwrite =
(in modprobe_remove_lttng() at modprobe.c:126)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.429745 [5620/=
5620]: Modprobe removal successful lttng-ring-buffer-client-mmap-discard (i=
n modprobe_remove_lttng() at modprobe.c:126)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Error: Unable to remove module =
lttng-ring-buffer-metadata-client<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.438779 [5620/=
5620]: Modprobe removal successful lttng-ring-buffer-client-overwrite (in m=
odprobe_remove_lttng() at modprobe.c:126)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Error: Unable to remove module =
lttng-ring-buffer-client-discard<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Error: Unable to remove module =
lttng-lib-ring-buffer<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Error: Unable to remove module =
lttng-tracer<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 - 21:52:15.452135 [5620/=
5622]: [ht-thread] Returning from poll on 2 fds. (in thread_ht_cleanup() at=
 ht-cleanup.c:74)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.452186 [5620/=
5622]: [ht-cleanup] quit. (in thread_ht_cleanup() at ht-cleanup.c:153)<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.452225 [5620/=
5622]: [ht-cleanup] Thread terminates. (in thread_ht_cleanup() at ht-cleanu=
p.c:164)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.452333 [5620/=
5620]: Cleaning up options (in sessiond_cleanup_options() at main.c:773)<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.453308 [5620/=
5620]: lttng-runas terminated with status code 0 (in run_as_destroy_worker(=
) at runas.c:737)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 21:52:15.453349 [5620/=
5620]: *** assert failed :-) *** =3D=3D&gt; Matthew, BEET driven developmen=
t works! (in sessiond_cleanup_options() at main.c:805)<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">can anybody help me ?<o:p></=
o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">thanks very much.<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">lichuanbao<o:p></o:p></span>=
</p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">ShenZhen in China<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_BECE94944F67D640AA66E9BA499F7CE853A12931SZXEMA509MBXchi_--


--===============1167125715659360222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1167125715659360222==--
