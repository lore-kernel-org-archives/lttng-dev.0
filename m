From: "ChitlurSrinivasa, Venkatesh" <Venkatesh.Babu@netapp.com>
Subject: What is the cost of user-space tracepoint() ?
Date: Fri, 5 Sep 2014 18:53:51 +0000
Message-ID: <270cf1f7125a489fb6e4a3562c030944__38757.5317560278$1409943323$gmane$org@hioexcmbx04-prd.hq.netapp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0132880526=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx12.netapp.com ([216.240.18.77])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Venkatesh.Babu@netapp.com>) id 1XPye9-0002EH-NK
 for lttng-dev@lists.lttng.org; Fri, 05 Sep 2014 14:54:16 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0132880526==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_270cf1f7125a489fb6e4a3562c030944hioexcmbx04prdhqnetappc_"

--_000_270cf1f7125a489fb6e4a3562c030944hioexcmbx04prdhqnetappc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Mathieu,

I tried to send this email to lttng-dev@ but I didn't get any response. So =
I am sending this directly to you. I greatly appreciate your response.

?

We are planning to use LTTng UST as it supports lot of interesting features=
, but have some performance concerns (as compared with our in-house tracing=
 tool). Please point me to the latest benchmark tests and performance resul=
ts. On CPU Intel Xeon E5-2680 v2 @ 2.80GHz?, running Linux 3.6.11? and lttn=
g 2.4.1,  I am getting about 927 cycles (9270692144 cycles for 10000000? it=
erations). This seems to be lot higher than the documented results. In the =
paper https://lttng.org/files/papers/desnoyers.pdf  the average cost of tra=
cepoint() with older ltt-usertrace-fast tracepoint is 297 cycles. Another l=
ink http://lttng.org/files/thesis/desnoyers-thesis-defense-2009-12-e1.pdf s=
ays cache hot tracepoint() cost is 238 cycles.?

I noticed that the tracepoint is making clock_gettime() and sched_getcpu() =
system calls. With Linux kernel v3.6.11 and libc v2.13-38+deb7u3, I see tha=
t these system calls are not going through VDSO and hence costing more. I t=
ried to add wrapper functions for these system calls to call __vdso_clock_g=
ettime and __vdso_getcpu as upgrading libc was not an option. With this cha=
nge the cost of tracepoint() recording one integer dropped to 795 cycles (=
=3D 284 nsec on Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz). Still this numb=
er seems to be higher than earlier published numbers.

VBabu

--_000_270cf1f7125a489fb6e4a3562c030944hioexcmbx04prdhqnetappc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} .ms-cui-menu {background-color:#ffffff;border:1px rgb(171, 171, 1=
71) solid;font-family:'Segoe UI WPC', 'Segoe UI', Tahoma, 'Microsoft Sans S=
erif', Verdana, sans-serif;font-size:11pt;color:rgb(51, 51, 51);} .ms-cui-m=
enusection-title {display:none;} .ms-cui-ctl {vertical-align:text-top;text-=
decoration:none;color:rgb(51, 51, 51);} .ms-cui-ctl-on {background-color:rg=
b(223, 237, 250);opacity: 0.8;} .ms-cui-img-cont-float {display:inline-bloc=
k;margin-top:2px} .ms-cui-smenu-inner {padding-top:0px;} .ms-owa-paste-opti=
on-icon {margin: 2px 4px 0px 4px;vertical-align:sub;padding-bottom: 2px;dis=
play:inline-block;} .ms-rtePasteFlyout-option:hover {background-color:rgb(2=
23, 237, 250) !important;opacity:1 !important;} .ms-rtePasteFlyout-option {=
padding:8px 4px 8px 4px;outline:none;} .ms-cui-menusection {float:left; wid=
th:85px;height:24px;overflow:hidden}.wf {speak:none; font-weight:normal; fo=
nt-variant:normal; text-transform:none; -webkit-font-smoothing:antialiased;=
 vertical-align:middle; display:inline-block;}.wf-family-owa {font-family:'=
o365Icons'}@font-face {  font-family:'o365IconsIE8';  src:url('prem/15.0.91=
3.22/resources/styles/office365icons.ie8.eot?#iefix') format('embedded-open=
type'),         url('prem/15.0.913.22/resources/styles/office365icons.ie8.w=
off') format('woff'),         url('prem/15.0.913.22/resources/styles/office=
365icons.ie8.ttf') format('truetype');  font-weight:normal;  font-style:nor=
mal;}@font-face {  font-family:'o365IconsMouse';  src:url('prem/15.0.913.22=
/resources/styles/office365icons.mouse.eot?#iefix') format('embedded-openty=
pe'),         url('prem/15.0.913.22/resources/styles/office365icons.mouse.w=
off') format('woff'),         url('prem/15.0.913.22/resources/styles/office=
365icons.mouse.ttf') format('truetype');  font-weight:normal;  font-style:n=
ormal;}.wf-family-owa {font-family:'o365IconsMouse'}.ie8 .wf-family-owa {fo=
nt-family:'o365IconsIE8'}.ie8 .wf-owa-play-large:before {content:'\e254';}.=
notIE8 .wf-owa-play-large:before {content:'\e054';}.ie8 .wf-owa-play-large =
{color:#FFFFFF/*$WFWhiteColor*/;}.notIE8 .wf-owa-play-large {border-color:#=
FFFFFF/*$WFWhiteColor*/; width:1.4em; height:1.4em; border-width:.1em; bord=
er-style:solid; border-radius:.8em; text-align:center; box-sizing:border-bo=
x; -moz-box-sizing:border-box; padding:0.1em; color:#FFFFFF/*$WFWhiteColor*=
/;}.ie8 .wf-size-play-large {width:40px; height:40px; font-size:30px}.notIE=
8 .wf-size-play-large {width:40px; height:40px; font-size:30px}=0A=
<!--=0A=
p=0A=
	{margin-top:0;=0A=
	margin-bottom:0}=0A=
.ms-cui-menu=0A=
	{background-color:#ffffff;=0A=
	border:1px rgb(171,171,171) solid;=0A=
	font-family:'Segoe UI WPC','Segoe UI',Tahoma,'Microsoft Sans Serif',Verdan=
a,sans-serif;=0A=
	font-size:11pt;=0A=
	color:rgb(51,51,51)}=0A=
.ms-cui-menusection-title=0A=
	{}=0A=
.ms-cui-ctl=0A=
	{vertical-align:text-top;=0A=
	text-decoration:none;=0A=
	color:rgb(51,51,51)}=0A=
.ms-cui-ctl-on=0A=
	{background-color:rgb(223,237,250)}=0A=
.ms-cui-img-cont-float=0A=
	{display:inline-block;=0A=
	margin-top:2px}=0A=
.ms-cui-smenu-inner=0A=
	{padding-top:0px}=0A=
.ms-owa-paste-option-icon=0A=
	{margin:2px 4px 0px 4px;=0A=
	vertical-align:sub;=0A=
	padding-bottom:2px;=0A=
	display:inline-block}=0A=
.ms-rtePasteFlyout-option=0A=
	{padding:8px 4px 8px 4px;=0A=
	outline:none}=0A=
.ms-cui-menusection=0A=
	{float:left;=0A=
	width:85px;=0A=
	height:24px;=0A=
	overflow:hidden}=0A=
.wf=0A=
	{speak:none;=0A=
	font-weight:normal;=0A=
	font-variant:normal;=0A=
	text-transform:none;=0A=
	vertical-align:middle;=0A=
	display:inline-block}=0A=
.wf-family-owa=0A=
	{font-family:'o365Icons'}=0A=
@font-face=0A=
	{font-family:'o365IconsIE8';=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
@font-face=0A=
	{font-family:'o365IconsMouse';=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
.wf-family-owa=0A=
	{font-family:'o365IconsMouse'}=0A=
.ie8 .wf-family-owa=0A=
	{font-family:'o365IconsIE8'}=0A=
.notIE8 .wf-owa-play-large=0A=
	{border-color:#FFFFFF;=0A=
	width:1.4em;=0A=
	height:1.4em;=0A=
	border-width:.1em;=0A=
	border-style:solid;=0A=
	text-align:center;=0A=
	padding:0.1em;=0A=
	color:#FFFFFF}=0A=
.ie8 .wf-size-play-large=0A=
	{width:40px;=0A=
	height:40px;=0A=
	font-size:30px}=0A=
.notIE8 .wf-size-play-large=0A=
	{width:40px;=0A=
	height:40px;=0A=
	font-size:30px}=0A=
-->=0A=
--></style>
</head>
<body dir=3D"ltr">
<div style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-fa=
mily:Calibri,Arial,Helvetica,sans-serif;">
<style type=3D"text/css" style=3D"">=0A=
<!--=0A=
p=0A=
	{margin-top:0;=0A=
	margin-bottom:0}=0A=
.ms-cui-menu=0A=
	{background-color:#ffffff;=0A=
	border:1px rgb(171,171,171) solid;=0A=
	font-family:'Segoe UI WPC','Segoe UI',Tahoma,'Microsoft Sans Serif',Verdan=
a,sans-serif;=0A=
	font-size:11pt;=0A=
	color:rgb(51,51,51)}=0A=
.ms-cui-menusection-title=0A=
	{}=0A=
.ms-cui-ctl=0A=
	{vertical-align:text-top;=0A=
	text-decoration:none;=0A=
	color:rgb(51,51,51)}=0A=
.ms-cui-ctl-on=0A=
	{background-color:rgb(223,237,250)}=0A=
.ms-cui-img-cont-float=0A=
	{display:inline-block;=0A=
	margin-top:2px}=0A=
.ms-cui-smenu-inner=0A=
	{padding-top:0px}=0A=
.ms-owa-paste-option-icon=0A=
	{margin:2px 4px 0px 4px;=0A=
	vertical-align:sub;=0A=
	padding-bottom:2px;=0A=
	display:inline-block}=0A=
.ms-rtePasteFlyout-option=0A=
	{padding:8px 4px 8px 4px;=0A=
	outline:none}=0A=
.ms-cui-menusection=0A=
	{float:left;=0A=
	width:85px;=0A=
	height:24px;=0A=
	overflow:hidden}=0A=
.wf=0A=
	{speak:none;=0A=
	font-weight:normal;=0A=
	font-variant:normal;=0A=
	text-transform:none;=0A=
	vertical-align:middle;=0A=
	display:inline-block}=0A=
.wf-family-owa=0A=
	{font-family:'o365Icons'}=0A=
@font-face=0A=
	{font-family:'o365IconsIE8';=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
@font-face=0A=
	{font-family:'o365IconsMouse';=0A=
	font-weight:normal;=0A=
	font-style:normal}=0A=
.wf-family-owa=0A=
	{font-family:'o365IconsMouse'}=0A=
.ie8 .wf-family-owa=0A=
	{font-family:'o365IconsIE8'}=0A=
.notIE8 .wf-owa-play-large=0A=
	{border-color:#FFFFFF;=0A=
	width:1.4em;=0A=
	height:1.4em;=0A=
	border-width:.1em;=0A=
	border-style:solid;=0A=
	text-align:center;=0A=
	padding:0.1em;=0A=
	color:#FFFFFF}=0A=
.ie8 .wf-size-play-large=0A=
	{width:40px;=0A=
	height:40px;=0A=
	font-size:30px}=0A=
.notIE8 .wf-size-play-large=0A=
	{width:40px;=0A=
	height:40px;=0A=
	font-size:30px}=0A=
-->=0A=
</style>
<div style=3D"background-color: rgb(255, 255, 255);">
<p style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sa=
ns-serif; font-size: 12pt;">
<span style=3D"color:rgb(40,40,40); font-family:'Segoe UI WPC','Segoe UI',T=
ahoma,'Microsoft Sans Serif',Verdana,sans-serif; font-size:13px">Mathieu,</=
span></p>
<p><br>
<font color=3D"#282828" face=3D"Segoe UI WPC, Segoe UI, Tahoma, Microsoft S=
ans Serif, Verdana, sans-serif" size=3D"2">I tried to send this email to&nb=
sp;lttng-dev@&nbsp;but I didn't get any response. So I am sending this dire=
ctly to you. I greatly&nbsp;appreciate&nbsp;your response.</font></p>
<p style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sa=
ns-serif; font-size: 12pt;">
<span style=3D"color:rgb(40,40,40); font-family:'Segoe UI WPC','Segoe UI',T=
ahoma,'Microsoft Sans Serif',Verdana,sans-serif; font-size:13px">&#8203;<br=
>
</span></p>
<p style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sa=
ns-serif; font-size: 12pt;">
<span style=3D"color:rgb(40,40,40); font-family:'Segoe UI WPC','Segoe UI',T=
ahoma,'Microsoft Sans Serif',Verdana,sans-serif; font-size:13px">We are pla=
nning to use LTTng UST as it supports lot of interesting features, but have=
 some performance concerns (as compared
 with our in-house tracing tool). Please point me to the latest benchmark t=
ests and performance results.&nbsp;<span style=3D"color: rgb(40, 40, 40); f=
ont-family: 'Segoe UI WPC', 'Segoe UI', Tahoma, 'Microsoft Sans Serif', Ver=
dana, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255);">O=
n&nbsp;CPU&nbsp;Intel
 Xeon&nbsp;E5-2680 v2 @ 2.80GHz&#8203;, running Linux&nbsp;3.6.11&#8203; an=
d lttng 2.4.1, &nbsp;I am getting&nbsp;about 927 cycles (9270692144 cycles =
for&nbsp;10000000&#8203; iterations). This seems to be lot higher than the =
documented results. In the paper&nbsp;</span><a href=3D"https://lttng.org/f=
iles/papers/desnoyers.pdf" target=3D"_blank" style=3D"font-family: 'Segoe U=
I WPC', 'Segoe UI', Tahoma, 'Microsoft Sans Serif', Verdana, sans-serif; fo=
nt-size: 13px; background-color: rgb(255, 255, 255);">https://lttng.org/fil=
es/papers/desnoyers.pdf</a><span style=3D"color: rgb(40, 40, 40); font-fami=
ly: 'Segoe UI WPC', 'Segoe UI', Tahoma, 'Microsoft Sans Serif', Verdana, sa=
ns-serif; font-size: 13px; background-color: rgb(255, 255, 255);">&nbsp;&nb=
sp;the
 average&nbsp;cost of tracepoint() with older&nbsp;ltt-usertrace-fast trace=
point is 297 cycles. Another link&nbsp;</span><a href=3D"http://lttng.org/f=
iles/thesis/desnoyers-thesis-defense-2009-12-e1.pdf" target=3D"_blank" styl=
e=3D"font-family: 'Segoe UI WPC', 'Segoe UI', Tahoma, 'Microsoft Sans Serif=
', Verdana, sans-serif; font-size: 13px; background-color: rgb(255, 255, 25=
5);">http://lttng.org/files/thesis/desnoyers-thesis-defense-2009-12-e1.pdf<=
/a><span style=3D"color: rgb(40, 40, 40); font-family: 'Segoe UI WPC', 'Seg=
oe UI', Tahoma, 'Microsoft Sans Serif', Verdana, sans-serif; font-size: 13p=
x; background-color: rgb(255, 255, 255);">&nbsp;says
 cache hot tracepoint() cost is 238 cycles.</span><span style=3D"font-famil=
y: Calibri, Arial, Helvetica, sans-serif; font-size: 16px; background-color=
: rgb(255, 255, 255);">&#8203;</span></span></p>
<p style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sa=
ns-serif; font-size: 12pt;">
<br style=3D"color:rgb(40,40,40); font-family:'Segoe UI WPC','Segoe UI',Tah=
oma,'Microsoft Sans Serif',Verdana,sans-serif; font-size:13px; background-c=
olor:rgb(255,255,255)">
<span style=3D"color:rgb(40,40,40); font-family:'Segoe UI WPC','Segoe UI',T=
ahoma,'Microsoft Sans Serif',Verdana,sans-serif; font-size:13px; background=
-color:rgb(255,255,255)">I noticed that the tracepoint is making clock_gett=
ime() and sched_getcpu() system calls.
 With Linux kernel v3.6.11 and libc v2.13-38&#43;deb7u3, I see that these s=
ystem calls are not going through VDSO and hence costing more. I tried to a=
dd wrapper functions for these system calls to call __vdso_clock_gettime an=
d __vdso_getcpu as upgrading libc was
 not an option. With this change the cost of tracepoint() recording one int=
eger dropped to 795 cycles (=3D 284 nsec on Intel(R) Xeon(R) CPU E5-2680 v2=
 @ 2.80GHz). Still this number seems to be higher than earlier published nu=
mbers.&nbsp;</span></p>
<p style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica, sa=
ns-serif; font-size: 12pt;">
<br style=3D"color:rgb(40,40,40); font-family:'Segoe UI WPC','Segoe UI',Tah=
oma,'Microsoft Sans Serif',Verdana,sans-serif; font-size:13px; background-c=
olor:rgb(255,255,255)">
<span style=3D"color:rgb(40,40,40); font-family:'Segoe UI WPC','Segoe UI',T=
ahoma,'Microsoft Sans Serif',Verdana,sans-serif; font-size:13px; background=
-color:rgb(255,255,255)">VBabu</span><br>
</p>
</div>
</div>
</body>
</html>

--_000_270cf1f7125a489fb6e4a3562c030944hioexcmbx04prdhqnetappc_--


--===============0132880526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0132880526==--
