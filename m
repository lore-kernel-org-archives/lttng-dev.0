From: MMM via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Problem in finding Jar file of LTTng for adding to
 Java project
Date: Tue, 10 Oct 2017 22:08:07 +0000 (UTC)
Message-ID: <1928584997.5360512.1507673287780__33813.421734567$1507675733$gmane$org@mail.yahoo.com>
References: <797428900.3787919.1507493725940.ref@mail.yahoo.com>
 <797428900.3787919.1507493725940@mail.yahoo.com>
 <CAB4xu_26Qmpzf-mccjY3HutmFBBLdEEDAxx5_WLdxdFARSzgNA@mail.gmail.com>
 <776772327.5312865.1507666332238@mail.yahoo.com>
 <CAB4xu_3hyJBYFoBm0yrT5mNTTgRXSNs5MmOpagL74XSY-P8RPA@mail.gmail.com>
Reply-To: MMM <e.morovati@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5442870971632604871=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic306-22.consmr.mail.ne1.yahoo.com
 (sonic306-22.consmr.mail.ne1.yahoo.com [66.163.189.84])
 by lists.lttng.org (Postfix) with ESMTP id 3yBXMj27bpztKM
 for <lttng-dev@lists.lttng.org>; Tue, 10 Oct 2017 22:48:32 +0000 (UTC)
In-Reply-To: <CAB4xu_3hyJBYFoBm0yrT5mNTTgRXSNs5MmOpagL74XSY-P8RPA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5442870971632604871==
Content-Type: multipart/alternative;
	boundary="----=_Part_5360511_523031639.1507673287778"

------=_Part_5360511_523031639.1507673287778
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Dear Philippe,
I tried with all options, while my trace result was empty yet and the error=
 message was shown again. Indeed, LTTng did not create a folder for saving =
trace result.=C2=A0
Thanks a lot for your guidance in advance.
Mehdi.
    On Wednesday, October 11, 2017, 12:28:59 AM GMT+3:30, Philippe Proulx <=
eeppeliteloop@gmail.com> wrote: =20
=20
 On Tue, Oct 10, 2017 at 4:12 PM, MMM <e.morovati@yahoo.com> wrote:
> Dear Philippe,
>
> Thanks a lot for your consideration. I solved former problem. While, I fa=
ced
> with a new problem. Indeed, when I create a LTTng session, start it and
> finally stop LTTng, I could not find trace files in mentioned folder. My
> java code is
>
> ///////////////////////////////////////
> import java.io.IOException;
> import java.util.logging.Handler;
> import java.util.logging.Logger;
>
> import org.lttng.ust.agent.LTTngAgent;
> import org.lttng.ust.agent.jul.LttngLogHandler;

It looks like you're using the java.util.logging agent...

>
> public class Hello {
> private static final int answer =3D 42;
> private static LTTngAgent lttngAgent;
>
> public static void main(String[] args) throws InterruptedException {
> Logger helloLog =3D Logger.getLogger("hello");
> lttngAgent =3D LTTngAgent.getLTTngAgent();
>
> Thread.sleep(5000);
> helloLog.info("Hello World, the answer is " + answer);
> lttngAgent.dispose();
> }
>
> }
> ///////////////////////
>
> Also, I used following LTTng commands.
>
> ////////////////////////////////
> lttng create java-test
> lttng enable-event -a -l

... and the -l/--log4j options applies to the log4j agent.

Use the -j/--jul option.

> lttng start
>
> ///Start My java Application///
>
> lttng stop
> ////////////////////////////
>
> Besides, when I used "lttng view" after stopping LTTng, I received follow=
ing
> error message
>
> [error] Cannot open any trace for reading.
> [error] opening trace "/[path]/lttng-traces/java-test10-20171010-130909" =
for
> reading.
> [error] none of the specified trace paths could be opened.

This is because your trace is empty (does not even exist).

Phil

>
> Could you please help me to resolve it.
>
> Regards,
> Mehdi.
>
>
>
>
>
>
>
>
>
> On Monday, October 9, 2017, 1:05:59 AM GMT+3:30, Philippe Proulx
> <eeppeliteloop@gmail.com> wrote:
>
>
> On Sun, Oct 8, 2017 at 4:15 PM, MMM via lttng-dev
> <lttng-dev@lists.lttng.org> wrote:
>> Dear Users,
>>
>> I am beginner in tracing using LTTng. At present, I am going to trace a
>> java
>> program in=C2=A0 Ubuntu, while I faced with a problem. When I install LT=
Tng on
>> Ubuntu, I also install
>>
>> "liblttng-ust-agent-java" by "apt-get install liblttng-ust-agent-java"
>> command in Ubuntu. But, when I want to import any libraries related to
>> LTTng
>> such as "org.lttng.ust.agent.jul.LttngLogHandlerorg.lttng.ust.LTTngAgent=
"
>> to
>> my program, it is marked as unknown package. Indeed, I could not find
>> LTTng
>> Jar file for adding it to my program libraries. Furthermore, I searched =
in
>> all files and folders, while I could not find Jar file. Could you please
>> help me to understand the cause of this problem and solve it.
>
> I'm not a Ubuntu specialist, but from
> <https://packages.ubuntu.com/zesty/all/liblttng-ust-agent-java/filelist>,
> I would say:
>
> * /usr/share/java/lttng-ust-agent-jul.jar
> * /usr/share/java/lttng-ust-agent-log4j.jar
>
> On 16.04, it's:
>
> * /usr/share/java/liblttng-ust-agent.jar
>
> Add the required JAR file to your classpath.
>
> Have a look at <http://lttng.org/docs/v2.9/#doc-java-application>.
>
> Phil
>
>
>>
>>
>> Best regards,
>>
>> Mehdi.
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>

------=_Part_5360511_523031639.1507673287778
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:courier new, courier, mo=
naco, monospace, sans-serif;font-size:13px;"><div></div>
            <div>Dear Philippe,</div><div><br></div><div>I tried with all o=
ptions, while my trace result was empty yet and the error message was shown=
 again. Indeed, LTTng did not create a folder for saving trace result.&nbsp=
;</div><div><br></div><div>Thanks a lot for your guidance in advance.</div>=
<div><br></div><div>Mehdi.</div><div><br></div>
           =20
            <div id=3D"yahoo_quoted_7882357566" class=3D"yahoo_quoted">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
                   =20
                    <div>
                        On Wednesday, October 11, 2017, 12:28:59 AM GMT+3:3=
0, Philippe Proulx &lt;eeppeliteloop@gmail.com&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D'ltr'><html><body>On Tue, Oct 10, 2017 =
at 4:12 PM, MMM &lt;<a shape=3D"rect" ymailto=3D"mailto:e.morovati@yahoo.co=
m" href=3D"mailto:e.morovati@yahoo.com">e.morovati@yahoo.com</a>&gt; wrote:=
<br clear=3D"none">&gt; Dear Philippe,<br clear=3D"none">&gt;<br clear=3D"n=
one">&gt; Thanks a lot for your consideration. I solved former problem. Whi=
le, I faced<br clear=3D"none">&gt; with a new problem. Indeed, when I creat=
e a LTTng session, start it and<br clear=3D"none">&gt; finally stop LTTng, =
I could not find trace files in mentioned folder. My<br clear=3D"none">&gt;=
 java code is<br clear=3D"none">&gt;<br clear=3D"none">&gt; ///////////////=
////////////////////////<br clear=3D"none">&gt; import java.io.IOException;=
<br clear=3D"none">&gt; import java.util.logging.Handler;<br clear=3D"none"=
>&gt; import java.util.logging.Logger;<br clear=3D"none">&gt;<br clear=3D"n=
one">&gt; import org.lttng.ust.agent.LTTngAgent;<br clear=3D"none">&gt; imp=
ort org.lttng.ust.agent.jul.LttngLogHandler;<br clear=3D"none"><br clear=3D=
"none">It looks like you&#39;re using the java.util.logging agent...<br cle=
ar=3D"none"><br clear=3D"none">&gt;<br clear=3D"none">&gt; public class Hel=
lo {<br clear=3D"none">&gt; private static final int answer =3D 42;<br clea=
r=3D"none">&gt; private static LTTngAgent lttngAgent;<br clear=3D"none">&gt=
;<br clear=3D"none">&gt; public static void main(String[] args) throws Inte=
rruptedException {<br clear=3D"none">&gt; Logger helloLog =3D Logger.getLog=
ger(&quot;hello&quot;);<br clear=3D"none">&gt; lttngAgent =3D LTTngAgent.ge=
tLTTngAgent();<br clear=3D"none">&gt;<br clear=3D"none">&gt; Thread.sleep(5=
000);<br clear=3D"none">&gt; helloLog.info(&quot;Hello World, the answer is=
 &quot; + answer);<br clear=3D"none">&gt; lttngAgent.dispose();<br clear=3D=
"none">&gt; }<br clear=3D"none">&gt;<br clear=3D"none">&gt; }<br clear=3D"n=
one">&gt; ///////////////////////<br clear=3D"none">&gt;<br clear=3D"none">=
&gt; Also, I used following LTTng commands.<br clear=3D"none">&gt;<br clear=
=3D"none">&gt; ////////////////////////////////<br clear=3D"none">&gt; lttn=
g create java-test<br clear=3D"none">&gt; lttng enable-event -a -l<br clear=
=3D"none"><br clear=3D"none">... and the -l/--log4j options applies to the =
log4j agent.<br clear=3D"none"><br clear=3D"none">Use the -j/--jul option.<=
br clear=3D"none"><br clear=3D"none">&gt; lttng start<br clear=3D"none">&gt=
;<br clear=3D"none">&gt; ///Start My java Application///<br clear=3D"none">=
&gt;<br clear=3D"none">&gt; lttng stop<br clear=3D"none">&gt; /////////////=
///////////////<br clear=3D"none">&gt;<br clear=3D"none">&gt; Besides, when=
 I used &quot;lttng view&quot; after stopping LTTng, I received following<b=
r clear=3D"none">&gt; error message<br clear=3D"none">&gt;<br clear=3D"none=
">&gt; [error] Cannot open any trace for reading.<br clear=3D"none">&gt; [e=
rror] opening trace &quot;/[path]/lttng-traces/java-test10-20171010-130909&=
quot; for<br clear=3D"none">&gt; reading.<br clear=3D"none">&gt; [error] no=
ne of the specified trace paths could be opened.<br clear=3D"none"><br clea=
r=3D"none">This is because your trace is empty (does not even exist).<div c=
lass=3D"yqt5117973980" id=3D"yqtfd64953"><br clear=3D"none"><br clear=3D"no=
ne">Phil<br clear=3D"none"><br clear=3D"none">&gt;<br clear=3D"none">&gt; C=
ould you please help me to resolve it.<br clear=3D"none">&gt;<br clear=3D"n=
one">&gt; Regards,<br clear=3D"none">&gt; Mehdi.<br clear=3D"none">&gt;<br =
clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=
=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"no=
ne">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; On Monday, October 9=
, 2017, 1:05:59 AM GMT+3:30, Philippe Proulx<br clear=3D"none">&gt; &lt;<a =
shape=3D"rect" ymailto=3D"mailto:eeppeliteloop@gmail.com" href=3D"mailto:ee=
ppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt; wrote:<br clear=3D"n=
one">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; On Sun, Oct 8, 2017=
 at 4:15 PM, MMM via lttng-dev<br clear=3D"none">&gt; &lt;<a shape=3D"rect"=
 ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@list=
s.lttng.org">lttng-dev@lists.lttng.org</a>&gt; wrote:<br clear=3D"none">&gt=
;&gt; Dear Users,<br clear=3D"none">&gt;&gt;<br clear=3D"none">&gt;&gt; I a=
m beginner in tracing using LTTng. At present, I am going to trace a<br cle=
ar=3D"none">&gt;&gt; java<br clear=3D"none">&gt;&gt; program in=C2=A0 Ubunt=
u, while I faced with a problem. When I install LTTng on<br clear=3D"none">=
&gt;&gt; Ubuntu, I also install<br clear=3D"none">&gt;&gt;<br clear=3D"none=
">&gt;&gt; &quot;liblttng-ust-agent-java&quot; by &quot;apt-get install lib=
lttng-ust-agent-java&quot;<br clear=3D"none">&gt;&gt; command in Ubuntu. Bu=
t, when I want to import any libraries related to<br clear=3D"none">&gt;&gt=
; LTTng<br clear=3D"none">&gt;&gt; such as &quot;org.lttng.ust.agent.jul.Lt=
tngLogHandlerorg.lttng.ust.LTTngAgent&quot;<br clear=3D"none">&gt;&gt; to<b=
r clear=3D"none">&gt;&gt; my program, it is marked as unknown package. Inde=
ed, I could not find<br clear=3D"none">&gt;&gt; LTTng<br clear=3D"none">&gt=
;&gt; Jar file for adding it to my program libraries. Furthermore, I search=
ed in<br clear=3D"none">&gt;&gt; all files and folders, while I could not f=
ind Jar file. Could you please<br clear=3D"none">&gt;&gt; help me to unders=
tand the cause of this problem and solve it.<br clear=3D"none">&gt;<br clea=
r=3D"none">&gt; I&#39;m not a Ubuntu specialist, but from<br clear=3D"none"=
>&gt; &lt;<a shape=3D"rect" href=3D"https://packages.ubuntu.com/zesty/all/l=
iblttng-ust-agent-java/filelist" target=3D"_blank">https://packages.ubuntu.=
com/zesty/all/liblttng-ust-agent-java/filelist</a>&gt;,<br clear=3D"none">&=
gt; I would say:<br clear=3D"none">&gt;<br clear=3D"none">&gt; * /usr/share=
/java/lttng-ust-agent-jul.jar<br clear=3D"none">&gt; * /usr/share/java/lttn=
g-ust-agent-log4j.jar<br clear=3D"none">&gt;<br clear=3D"none">&gt; On 16.0=
4, it&#39;s:<br clear=3D"none">&gt;<br clear=3D"none">&gt; * /usr/share/jav=
a/liblttng-ust-agent.jar<br clear=3D"none">&gt;<br clear=3D"none">&gt; Add =
the required JAR file to your classpath.<br clear=3D"none">&gt;<br clear=3D=
"none">&gt; Have a look at &lt;<a shape=3D"rect" href=3D"http://lttng.org/d=
ocs/v2.9/#doc-java-application" target=3D"_blank">http://lttng.org/docs/v2.=
9/#doc-java-application</a>&gt;.<br clear=3D"none">&gt;<br clear=3D"none">&=
gt; Phil<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&g=
t;&gt;<br clear=3D"none">&gt;&gt;<br clear=3D"none">&gt;&gt; Best regards,<=
br clear=3D"none">&gt;&gt;<br clear=3D"none">&gt;&gt; Mehdi.<br clear=3D"no=
ne">&gt;&gt;<br clear=3D"none">&gt;&gt;<br clear=3D"none">&gt;&gt; ________=
_______________________________________<br clear=3D"none">&gt;&gt; lttng-de=
v mailing list<br clear=3D"none">&gt;&gt; <a shape=3D"rect" ymailto=3D"mail=
to:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">ltt=
ng-dev@lists.lttng.org</a><br clear=3D"none">&gt;&gt; <a shape=3D"rect" hre=
f=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"=
_blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br c=
lear=3D"none">&gt;&gt;<br clear=3D"none"></div></body></html></div></div>
                </div>
            </div></div></body></html>
------=_Part_5360511_523031639.1507673287778--

--===============5442870971632604871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5442870971632604871==--
