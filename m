From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Lttng add-context perf commands gives me error
Date: Wed, 18 Nov 2015 14:45:30 +0000 (UTC)
Message-ID: <824342841.114145.1447857930891.JavaMail.zimbra__49050.4939495169$1447858002$gmane$org@efficios.com>
References: <328787043.5258001.1447796792694.JavaMail.yahoo.ref@mail.yahoo.com>
 <328787043.5258001.1447796792694.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1717520608=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Zz3zU-0004fa-Kl
 for lttng-dev@lists.lttng.org; Wed, 18 Nov 2015 09:45:45 -0500
In-Reply-To: <328787043.5258001.1447796792694.JavaMail.yahoo@mail.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hani Nemati <hani_nemati@yahoo.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1717520608==
Content-Type: multipart/alternative;
	boundary="----=_Part_114144_1630748348.1447857930891"

------=_Part_114144_1630748348.1447857930891
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 17, 2015, at 4:46 PM, Hani Nemati <hani_nemati@yahoo.com> wrote: 

> Hi,
> I am trying to count last level cache misses by using lttng add-context command.
> I use add-context to add perf:cpu:LLC-load-misses to my channel but I see an
> error. There is no error for other perf events. Just two perf events including
> perf:cpu:LLC-load-misses and perf:cpu:LLC-store-misses give me the following
> error:
> Error: perf:cpu:LLC-load-misses: Add kernel context failed
> Warning: Some command(s) went wrong

> Here is result of "uname -a" on my computer:
> Linux nemati 3.16.0-51-generic #69~14.04.1-Ubuntu SMP Wed Oct 7 15:32:41 UTC
> 2015 x86_64 x86_64 x86_64 GNU/Linux

> Here is the command that I used:
> #lttng enable-channel -k test
> #Kernel channel test enabled for session hh
> #lttng add-context -k -t perf:cpu:LLC-load-misses -c test
> Error: perf:cpu:LLC-load-misses: Add kernel context failed
> Warning: Some command(s) went wrong

> I also tried it on other machines.

It is possible that your architecture does not expose this counter to perf. 
Did you try using this PMC with the perf tool ? 

Thanks, 

Mathieu 

> <<<<<<< /-/ /\ /\/ / /\/ E /\/\ /\ T / >>>>>>>>

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_114144_1630748348.1447857930891
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Nov 17, 2015, at 4:46 PM, Hani Nemati=
 &lt;hani_nemati@yahoo.com&gt; wrote:<br></span><div data-marker=3D"__QUOTE=
D_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5p=
x;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-dec=
oration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div s=
tyle=3D"color:#000; background-color:#fff; font-family:times new roman, new=
 york, times, serif;font-size:16px"><div dir=3D"ltr" id=3D"yui_3_16_0_1_144=
7772874730_12112"><span id=3D"yui_3_16_0_1_1447772874730_12163">Hi, <br cla=
ss=3D"" id=3D"yui_3_16_0_1_1447772874730_12165">I am trying to count last l=
evel cache misses by using lttng add-context command. I use add-context to =
add perf:cpu:LLC-load-misses to my channel but I see an error. There is no =
error for other perf events. Just two perf events including perf:cpu:LLC-lo=
ad-misses and&nbsp; perf:cpu:LLC-store-misses give me the following error:<=
br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12167">Error: perf:cpu:LLC-l=
oad-misses: Add kernel context failed<br class=3D"" id=3D"yui_3_16_0_1_1447=
772874730_12169">Warning: Some command(s) went wrong<br class=3D"" id=3D"yu=
i_3_16_0_1_1447772874730_12171"><br class=3D"" id=3D"yui_3_16_0_1_144777287=
4730_12173">Here is result of "uname -a" on my computer: <br class=3D"" id=
=3D"yui_3_16_0_1_1447772874730_12175">Linux nemati 3.16.0-51-generic #69~14=
.04.1-Ubuntu SMP Wed Oct 7 15:32:41 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux=
 <br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12177"><br class=3D"" id=
=3D"yui_3_16_0_1_1447772874730_12179"><br class=3D"" id=3D"yui_3_16_0_1_144=
7772874730_12181">Here is the command that I used: <br class=3D"" id=3D"yui=
_3_16_0_1_1447772874730_12183">#lttng enable-channel -k test<br class=3D"" =
id=3D"yui_3_16_0_1_1447772874730_12185">#Kernel channel test enabled for se=
ssion hh<br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12187">#lttng add-c=
ontext -k -t perf:cpu:LLC-load-misses -c test<br class=3D"" id=3D"yui_3_16_=
0_1_1447772874730_12189">Error: perf:cpu:LLC-load-misses: Add kernel contex=
t failed<br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12191">Warning: Som=
e command(s) went wrong<br class=3D"" id=3D"yui_3_16_0_1_1447772874730_1219=
3"><br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12195"><br class=3D"" id=
=3D"yui_3_16_0_1_1447772874730_12197">I also tried it on other machines. </=
span></div></div></blockquote><div><br></div><div>It is possible that your =
architecture does not expose this counter to perf.<br data-mce-bogus=3D"1">=
</div><div>Did you try using this PMC with the perf tool ?<br data-mce-bogu=
s=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-=
bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"color:#000; backgro=
und-color:#fff; font-family:times new roman, new york, times, serif;font-si=
ze:16px"><div id=3D"yui_3_16_0_1_1447772874730_12155" class=3D"signature"><=
div id=3D"yui_3_16_0_1_1447772874730_12154">&lt;&lt;&lt;&lt;&lt;&lt;&lt;&nb=
sp;&nbsp; <span style=3D"color: #ff0000;" data-mce-style=3D"color: #ff0000;=
" color=3D"#ff0000">&nbsp;/-/ /\ /\/ / /\/ <em>E</em> /\/\ /\ <em>T</em> /<=
/span>&nbsp;&nbsp;&nbsp; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div></div></div>=
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote></div><br><div data-marker=3D"__SIG_POST_=
_">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effic=
ios.com</div></div></body></html>
------=_Part_114144_1630748348.1447857930891--


--===============1717520608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1717520608==--
