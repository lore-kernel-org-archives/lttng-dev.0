From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Lttng add-context perf commands gives me error
Date: Thu, 19 Nov 2015 17:25:45 +0000 (UTC)
Message-ID: <1171905821.121424.1447953945294.JavaMail.zimbra__30709.6750628718$1447954020$gmane$org@efficios.com>
References: <328787043.5258001.1447796792694.JavaMail.yahoo.ref@mail.yahoo.com>
 <328787043.5258001.1447796792694.JavaMail.yahoo@mail.yahoo.com>
 <824342841.114145.1447857930891.JavaMail.zimbra@efficios.com>
 <886413694.5732011.1447877960962.JavaMail.yahoo@mail.yahoo.com>
 <1043364994.6119959.1447947438952.JavaMail.yahoo@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1461290372=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZzSy6-0004O3-Vg
 for lttng-dev@lists.lttng.org; Thu, 19 Nov 2015 12:26:01 -0500
In-Reply-To: <1043364994.6119959.1447947438952.JavaMail.yahoo@mail.yahoo.com>
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

--===============1461290372==
Content-Type: multipart/alternative;
	boundary="----=_Part_121423_1370063304.1447953945293"

------=_Part_121423_1370063304.1447953945293
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

Passing raw pmc identifiers is not supported at the moment. This is a feature we 
would like to add to lttng next year. 

Thanks, 

Mathieu 

----- On Nov 19, 2015, at 10:37 AM, Hani Nemati <hani_nemati@yahoo.com> wrote: 

> Hi Mathieu ,
> LCC is last level cache and it is shared between CPU cores. Also, I was running
> several VMs in background. That's why I used sleep command.
> Based on Intel's manual r0109 is raw identifier for LCC-load-misses,
> The question is how can I fix the problem since Lttng is using perf symbolic
> name.

> Thanks,
> Hani

> On Wednesday, November 18, 2015 3:19 PM, Hani Nemati <hani_nemati@yahoo.com>
> wrote:

> There is no PERF symbolic name for LLC-load-misses but I can use raw identifier
> to find out Number of code read, data read that miss the LLC. Here is the
> command that I used.

> #perf stat -e r0109 sleep 2
> Performance counter stats for 'sleep 2':

> 117 r0109

> Do you have any idea why I don't have the symbolic name? Is there any way to
> give raw identifier instead of perf:cpu:LLC-load-misses?

> On Wednesday, November 18, 2015 9:45 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:

> ----- On Nov 17, 2015, at 4:46 PM, Hani Nemati <hani_nemati@yahoo.com> wrote:

>> Hi,
>> I am trying to count last level cache misses by using lttng add-context command.
>> I use add-context to add perf:cpu:LLC-load-misses to my channel but I see an
>> error. There is no error for other perf events. Just two perf events including
>> perf:cpu:LLC-load-misses and perf:cpu:LLC-store-misses give me the following
>> error:
>> Error: perf:cpu:LLC-load-misses: Add kernel context failed
>> Warning: Some command(s) went wrong

>> Here is result of "uname -a" on my computer:
>> Linux nemati 3.16.0-51-generic #69~14.04.1-Ubuntu SMP Wed Oct 7 15:32:41 UTC
>> 2015 x86_64 x86_64 x86_64 GNU/Linux

>> Here is the command that I used:
>> #lttng enable-channel -k test
>> #Kernel channel test enabled for session hh
>> #lttng add-context -k -t perf:cpu:LLC-load-misses -c test
>> Error: perf:cpu:LLC-load-misses: Add kernel context failed
>> Warning: Some command(s) went wrong

>> I also tried it on other machines.

> It is possible that your architecture does not expose this counter to perf.
> Did you try using this PMC with the perf tool ?

> Thanks,

> Mathieu

>> <<<<<<<
>> /-/ /\ /\/ / /\/ E /\/\ /\ T
>> / >>>>>>>>

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_121423_1370063304.1447953945293
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,</div><div><br data-mce-bogus=3D"1"></di=
v><div>Passing raw pmc identifiers is not supported at the moment. This is =
a feature we<br data-mce-bogus=3D"1"></div><div>would like to add to lttng =
next year.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></di=
v><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br></div><div><br></=
div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Nov 19, 20=
15, at 10:37 AM, Hani Nemati &lt;hani_nemati@yahoo.com&gt; wrote:<br></span=
></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-lef=
t:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight=
:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,=
sans-serif;font-size:12pt;"><div style=3D"color:#000; background-color:#fff=
; font-family:times new roman, new york, times, serif;font-size:16px"><div =
id=3D"yui_3_16_0_1_1447880899551_31232"><br><span></span></div><div dir=3D"=
ltr" id=3D"yui_3_16_0_1_1447880899551_31331"><span class=3D"" id=3D"yui_3_1=
6_0_1_1447880899551_31564">Hi </span><span id=3D"yui_3_16_0_1_1447880899551=
_31564"><span class=3D"" id=3D"yui_3_16_0_1_1447880899551_31748">Mathieu</s=
pan>, <br></span></div><div id=3D"yui_3_16_0_1_1447880899551_31394"><span i=
d=3D"yui_3_16_0_1_1447880899551_31393">LCC is last level cache and it is sh=
ared between CPU cores. Also, I was running several VMs in background. That=
's why I used sleep command.&nbsp;</span></div><div id=3D"yui_3_16_0_1_1447=
880899551_31749"><span id=3D"yui_3_16_0_1_1447880899551_31393">Based on Int=
el's manual r0109 is raw identifier for LCC-load-misses, <br></span></div><=
div dir=3D"ltr" id=3D"yui_3_16_0_1_1447880899551_31420"><span id=3D"yui_3_1=
6_0_1_1447880899551_31393">The question is how can I fix the problem since =
Lttng is using perf symbolic name. <br></span></div><div id=3D"yui_3_16_0_1=
_1447880899551_31534" dir=3D"ltr"><br><span id=3D"yui_3_16_0_1_144788089955=
1_31393"></span></div><div id=3D"yui_3_16_0_1_1447880899551_31535" dir=3D"l=
tr"><span id=3D"yui_3_16_0_1_1447880899551_31393">Thanks, <br></span></div>=
<div id=3D"yui_3_16_0_1_1447880899551_31560" dir=3D"ltr"><span id=3D"yui_3_=
16_0_1_1447880899551_31393">Hani </span></div><div id=3D"yui_3_16_0_1_14478=
80899551_31561" class=3D"qtdSeparateBR">&nbsp;<br><br></div>  <div style=3D=
"display: block;" id=3D"yui_3_16_0_1_1447880899551_31652" class=3D"yahoo_qu=
oted"> <div id=3D"yui_3_16_0_1_1447880899551_31651" style=3D"font-family: t=
imes new roman, new york, times, serif; font-size: 16px;"> <div id=3D"yui_3=
_16_0_1_1447880899551_31650" style=3D"font-family: HelveticaNeue, Helvetica=
 Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;"> <div=
 id=3D"yui_3_16_0_1_1447880899551_31649" dir=3D"ltr"><span style=3D"font-fa=
mily: Arial; font-size: small;" data-mce-style=3D"font-family: Arial; font-=
size: small;" id=3D"yui_3_16_0_1_1447880899551_31648" face=3D"Arial" size=
=3D"2"> On Wednesday, November 18, 2015 3:19 PM, Hani Nemati &lt;hani_nemat=
i@yahoo.com&gt; wrote:<br></span></div>  <br><br> <div id=3D"yui_3_16_0_1_1=
447880899551_31962" class=3D"y_msg_container"><div id=3D"yiv4671081710"><di=
v id=3D"yui_3_16_0_1_1447880899551_31961"><div id=3D"yui_3_16_0_1_144788089=
9551_31960" style=3D"color:#000;background-color:#fff;font-family:times new=
 roman, new york, times, serif;font-size:16px;">There is no PERF symbolic n=
ame for LLC-load-misses but I can use raw identifier to find out Number of =
code read, data read that miss the LLC. Here is the command that I used.<br=
 class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447797278790_3561=
3" clear=3D"none">&nbsp;<br class=3D"yiv4671081710" id=3D"yiv4671081710yui_=
3_16_0_1_1447797278790_35615" clear=3D"none">#perf stat -e r0109 sleep 2<br=
 class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447797278790_3561=
7" clear=3D"none">&nbsp;Performance counter stats for 'sleep 2':<br class=
=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447797278790_35619" cle=
ar=3D"none"><br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_144=
7797278790_35621" clear=3D"none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 117&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; r0109&nbsp; <br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1=
447797278790_35623" clear=3D"none"><br class=3D"yiv4671081710" id=3D"yiv467=
1081710yui_3_16_0_1_1447797278790_35625" clear=3D"none">Do you have any ide=
a why I don't have the symbolic name? Is there any way to give raw identifi=
er instead of perf:cpu:LLC-load-misses? <br class=3D"yiv4671081710" id=3D"y=
iv4671081710yui_3_16_0_1_1447797278790_35627" clear=3D"none"><br class=3D"y=
iv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447797278790_35629" clear=3D=
"none"><br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_14477972=
78790_35631" clear=3D"none"><br class=3D"yiv4671081710" id=3D"yiv4671081710=
yui_3_16_0_1_1447797278790_35633" clear=3D"none"><div dir=3D"ltr" id=3D"yiv=
4671081710yui_3_16_0_1_1447797278790_35843"><br clear=3D"none"></div><br cl=
ear=3D"none"><div class=3D"yiv4671081710qtdSeparateBR"><br clear=3D"none"><=
br clear=3D"none"></div><div class=3D"yiv4671081710yqt9882023943" id=3D"yiv=
4671081710yqt48910"><div class=3D"yiv4671081710yahoo_quoted" style=3D"displ=
ay:block;"> <div style=3D"font-family:times new roman, new york, times, ser=
if;font-size:16px;"> <div style=3D"font-family:HelveticaNeue, Helvetica Neu=
e, Helvetica, Arial, Lucida Grande, sans-serif;font-size:16px;"> <div dir=
=3D"ltr"> <span style=3D"font-family: Arial; font-size: small;" data-mce-st=
yle=3D"font-family: Arial; font-size: small;" face=3D"Arial" size=3D"2"> On=
 Wednesday, November 18, 2015 9:45 AM, Mathieu Desnoyers &lt;mathieu.desnoy=
ers@efficios.com&gt; wrote:<br clear=3D"none"> </span> </div>  <br clear=3D=
"none"><br clear=3D"none"> <div class=3D"yiv4671081710y_msg_container"><div=
 id=3D"yiv4671081710"><div><div style=3D"font-family:arial, helvetica, sans=
-serif;font-size:12pt;color:#000000;"><div><br clear=3D"none"></div><div><b=
r clear=3D"none"></div><span id=3D"yiv4671081710zwchr">----- On Nov 17, 201=
5, at 4:46 PM, Hani Nemati &lt;hani_nemati@yahoo.com&gt; wrote:<br clear=3D=
"none"></span><div><blockquote style=3D"border-left:2px solid #1010FF;margi=
n-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal=
;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:12=
pt;"><div style=3D"color:#000;background-color:#fff;font-family:times new r=
oman, new york, times, serif;font-size:16px;"><div dir=3D"ltr" id=3D"yiv467=
1081710yui_3_16_0_1_1447772874730_12112"><span id=3D"yiv4671081710yui_3_16_=
0_1_1447772874730_12163">Hi, <br class=3D"yiv4671081710" id=3D"yiv467108171=
0yui_3_16_0_1_1447772874730_12165" clear=3D"none">I am trying to count last=
 level cache misses by using lttng add-context command. I use add-context t=
o add perf:cpu:LLC-load-misses to my channel but I see an error. There is n=
o error for other perf events. Just two perf events including perf:cpu:LLC-=
load-misses and&nbsp; perf:cpu:LLC-store-misses give me the following error=
:<br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_=
12167" clear=3D"none">Error: perf:cpu:LLC-load-misses: Add kernel context f=
ailed<br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874=
730_12169" clear=3D"none">Warning: Some command(s) went wrong<br class=3D"y=
iv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12171" clear=3D=
"none"><br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_14477728=
74730_12173" clear=3D"none">Here is result of "uname -a" on my computer: <b=
r class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_121=
75" clear=3D"none">Linux nemati 3.16.0-51-generic #69~14.04.1-Ubuntu SMP We=
d Oct 7 15:32:41 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux <br class=3D"yiv46=
71081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12177" clear=3D"non=
e"><br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_144777287473=
0_12179" clear=3D"none"><br class=3D"yiv4671081710" id=3D"yiv4671081710yui_=
3_16_0_1_1447772874730_12181" clear=3D"none">Here is the command that I use=
d: <br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_144777287473=
0_12183" clear=3D"none">#lttng enable-channel -k test<br class=3D"yiv467108=
1710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12185" clear=3D"none">#=
Kernel channel test enabled for session hh<br class=3D"yiv4671081710" id=3D=
"yiv4671081710yui_3_16_0_1_1447772874730_12187" clear=3D"none">#lttng add-c=
ontext -k -t perf:cpu:LLC-load-misses -c test<br class=3D"yiv4671081710" id=
=3D"yiv4671081710yui_3_16_0_1_1447772874730_12189" clear=3D"none">Error: pe=
rf:cpu:LLC-load-misses: Add kernel context failed<br class=3D"yiv4671081710=
" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12191" clear=3D"none">Warni=
ng: Some command(s) went wrong<br class=3D"yiv4671081710" id=3D"yiv46710817=
10yui_3_16_0_1_1447772874730_12193" clear=3D"none"><br class=3D"yiv46710817=
10" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12195" clear=3D"none"><br=
 class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_1219=
7" clear=3D"none">I also tried it on other machines. </span></div></div></b=
lockquote><div><br clear=3D"none"></div><div>It is possible that your archi=
tecture does not expose this counter to perf.<br clear=3D"none"></div><div>=
Did you try using this PMC with the perf tool ?<br clear=3D"none"></div><di=
v><br clear=3D"none"></div><div>Thanks,<br clear=3D"none"></div><div><br cl=
ear=3D"none"></div><div>Mathieu<div class=3D"yiv4671081710yqt4842675108" id=
=3D"yiv4671081710yqtfd64414"><br clear=3D"none"></div></div><div class=3D"y=
iv4671081710yqt4842675108" id=3D"yiv4671081710yqtfd37008"><div><br clear=3D=
"none"></div></div><blockquote style=3D"border-left:2px solid #1010FF;margi=
n-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal=
;text-decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:12=
pt;"><div style=3D"color:#000;background-color:#fff;font-family:times new r=
oman, new york, times, serif;font-size:16px;"><div class=3D"yiv4671081710si=
gnature" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12155"><div id=3D"yi=
v4671081710yui_3_16_0_1_1447772874730_12154"><div class=3D"yiv4671081710yqt=
4842675108" id=3D"yiv4671081710yqtfd96110">&lt;&lt;&lt;&lt;&lt;&lt;&lt;&nbs=
p;&nbsp; </div><span style=3D"color:#ff0000;"></span><div class=3D"yiv46710=
81710yqt4842675108" id=3D"yiv4671081710yqtfd53272">&nbsp;/-/ /\ /\/ / /\/ <=
em>E</em> /\/\ /\ <em>T</em></div> /&nbsp;&nbsp;&nbsp; &gt;&gt;&gt;&gt;&gt;=
&gt;&gt;&gt;</div></div></div><br clear=3D"none">__________________________=
_____________________<br clear=3D"none">lttng-dev mailing list<br clear=3D"=
none">lttng-dev@lists.lttng.org<br clear=3D"none">http://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev<br clear=3D"none"></blockquote></div><br c=
lear=3D"none"><div>-- <br clear=3D"none"></div><div>Mathieu Desnoyers<br cl=
ear=3D"none">EfficiOS Inc.<br clear=3D"none">http://www.efficios.com</div><=
/div></div></div><br clear=3D"none"><br clear=3D"none"></div>  </div> </div=
>  </div></div></div></div></div><br><br></div>  </div> </div>  </div></div=
><br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">--=
 <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.c=
om</div></div></body></html>
------=_Part_121423_1370063304.1447953945293--


--===============1461290372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1461290372==--
