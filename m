From: "ChitlurSrinivasa, Venkatesh" <Venkatesh.Babu@netapp.com>
Subject: Cost of user space tracepoint()
Date: Wed, 20 Aug 2014 18:58:09 +0000
Message-ID: <07c761f718a347db965a708bc462913c__30650.2555533827$1408562181$gmane$org@hioexcmbx04-prd.hq.netapp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2006638789=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx12.netapp.com ([216.240.18.77])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Venkatesh.Babu@netapp.com>) id 1XKB6N-0004g5-Hg
 for lttng-dev@lists.lttng.org; Wed, 20 Aug 2014 14:59:25 -0400
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

--===============2006638789==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_07c761f718a347db965a708bc462913chioexcmbx04prdhqnetappc_"

--_000_07c761f718a347db965a708bc462913chioexcmbx04prdhqnetappc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am sure you guys will do regular performance runs on different versions o=
f LTTng, but I couldn't find any links to the latest results. I was trying =
to find the cost of a tracepoint() recording one integer. On CPU Intel Xeon=
 E5-2680 v2 @ 2.80GHz?, running Linux 3.6.11? and lttng 2.4.1,  I am gettin=
g about 927 cycles (9270692144 cycles for 10000000? iterations). This seems=
 to be lot higher than the documented results . In the paper https://lttng.=
org/files/papers/desnoyers.pdf  the average cost of tracepoint() with older=
 ltt-usertrace-fast tracepoint is 297 cycles. Another link <http://lttng.or=
g/files/thesis/desnoyers-thesis-defense-2009-12-e1.pdf> http://lttng.org/fi=
les/thesis/desnoyers-thesis-defense-2009-12-e1.pdf says cache hot tracepoin=
t() cost is 238 cycles.


It appears that in spite of better cpu, and newer version of lttng and kern=
el I am seeing higher cost. Am I missing something here? Do I need to enabl=
e certain features of kernel/cpu ?


VBabu

--_000_07c761f718a347db965a708bc462913chioexcmbx04prdhqnetappc_
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
th:85px;height:24px;overflow:hidden}--></style>
</head>
<body>
<div style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-fa=
mily:Calibri,Arial,Helvetica,sans-serif;">
<p>I am sure you guys will do&nbsp;regular performance runs on different ve=
rsions of LTTng, but I couldn't find any links to the latest results.&nbsp;=
I was trying to find the cost of a tracepoint() recording one integer. On&n=
bsp;<span style=3D"font-size: 12pt;">CPU&nbsp;Intel Xeon&nbsp;E5-2680
 v2 @ 2.80GHz</span><span style=3D"font-size: 12pt;">&#8203;, running Linux=
&nbsp;</span><span style=3D"font-size: 12pt;">3.6.11</span><span style=3D"f=
ont-size: 12pt;">&#8203; and lttng 2.4.1, &nbsp;I am getting about 927 cycl=
es (</span><span style=3D"font-size: 12pt;">9270692144 cycles
 for&nbsp;10000000</span><span style=3D"font-size: 12pt;">&#8203; iteration=
s</span><span style=3D"font-size: 12pt;">)</span><span style=3D"font-size: =
12pt;">. This seems to be lot higher than
</span><span style=3D"font-size: 12pt;">the documented results&nbsp;</span>=
<span style=3D"font-size: 12pt;">. In the paper&nbsp;</span><a href=3D"http=
s://lttng.org/files/papers/desnoyers.pdf" style=3D"font-size: 12pt;">https:=
//lttng.org/files/papers/desnoyers.pdf</a><span style=3D"font-size: 12pt;">
 &nbsp;the av</span><span style=3D"font-size: 12pt;">erage&nbsp;</span><spa=
n style=3D"font-size: 12pt;">cost of tracepoin</span><span style=3D"font-si=
ze: 12pt;">t()</span><span style=3D"font-size: 12pt;"> w</span><span style=
=3D"font-size: 12pt;">ith older&nbsp;</span><span style=3D"font-size: 12pt;=
">ltt-usertrace-fast
 tracepoint is 297 cycles. Another link&nbsp;</span><a href=3D"http://lttng=
.org/files/thesis/desnoyers-thesis-defense-2009-12-e1.pdf" style=3D"font-si=
ze: 12pt;"></a><a href=3D"http://lttng.org/files/thesis/desnoyers-thesis-de=
fense-2009-12-e1.pdf" style=3D"font-size: 12pt;">http://lttng.org/files/the=
sis/desnoyers-thesis-defense-2009-12-e1.pdf</a><span style=3D"font-size: 12=
pt;">
 says cache hot tracepoint()</span><span style=3D"font-size: 12pt;"> cost i=
s 238 cycles.</span></p>
<p><span style=3D"font-size: 12pt;"><br>
</span></p>
<p><span style=3D"font-size: 12pt;">It appears that in&nbsp;spite of&nbsp;b=
etter cpu, and newer version of lttng and kernel I am seeing higher cost.&n=
bsp;Am I missing something here? Do I need to enable certain features of ke=
rnel/cpu ?</span></p>
<p><span style=3D"font-size: 12pt;"><br>
</span></p>
<p><span style=3D"font-size: 12pt;">VBabu</span></p>
</div>
</body>
</html>

--_000_07c761f718a347db965a708bc462913chioexcmbx04prdhqnetappc_--


--===============2006638789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2006638789==--
