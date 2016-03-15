From: Varsha Samal <varsha.samal@tcs.com>
Subject: Reg. Questions on LTTng Application Specific Context
 variable filtering for Ericsson TRACE component
Date: Tue, 15 Mar 2016 20:21:39 +0530
Message-ID: <OF2B3ABC01.0630BE9D-ON65257F77.0050F2AD-65257F77.0051D195__36629.9790832729$1458054488$gmane$org@tcs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3082696532473119083=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from inmumg02.tcs.com (unknown [219.64.33.222])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id DA59AA0A84
 for <lttng-dev@lists.lttng.org>; Tue, 15 Mar 2016 14:52:28 +0000 (UTC)
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
Cc: Rajendra Bhupathiraju <rajendra.bhupathiraju@tcs.com>, siva.rama.raju.katari@ericsson.com, Vadlamudi Tejaswini <vadlamudi.tejaswini@tcs.com>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============3082696532473119083==
Content-Type: multipart/alternative; boundary="=_alternative 0051D16D65257F77_="

This is a multipart message in MIME format.
--=_alternative 0051D16D65257F77_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I'm working on Latest LTTng with below commit IDs for Ericsson Trace 
Project 

LTTng-UST:           2ef5e79d1f40ce7110d9ad581bb467a9109afeb5
LTTng-Tools:         b6ba0c85112e48eb1557a2b53542dbd3008e0ca0

We are facing an issue in identifying the way to use $app in LTTng filter. 
The issue is like follows-

SC-2-1:/home/test-apps # lttng create
Session auto-20160315-164851 created.
Traces will be written in /root/lttng-traces/auto-20160315-164851
SC-2-1:/home/test-apps # lttng enable-event a -j -a --filter '$ctx.vpid >= 
0 && $ctx.vpid < 40000'
Filter '$ctx.vpid >= 0 && $ctx.vpid < 40000' successfully set

Then start the java test application-

SC-2-1:/home/test-apps # lttng start
Tracing started for session auto-20160315-164851
SC-2-1:/home/test-apps # lttng stop
Waiting for data availability.
Tracing stopped for session auto-20160315-164851
SC-2-1::/home/test-apps # lttng view
[16:49:20.291293478] (+0.000087520) SC-2-1 lttng_jul:event: { cpu_id = 0 
}, { msg = "KiloPerSec : my_time = 16:49:19, OnePs = 1, TenPs = 9, 
HundredPs = 4, KiloPs = 2", logger_name = 
"com.ericsson.common.trace.testapp_thread.testthread", class_name = 
"CBF_testapp.TestThread", method_name = "run", long_millis = 
1458060560291, int_loglevel = 300, int_threadid = 15 }

We are able to see logs using $ctx as a filter parameter. 

The question is how do we use $app in place of $ctx to get the logs. We 
checked for LTTng documentation, but were unable to find something useful 
in this context. 

We used the example java file in lttng-ust location-

lttng-ust/doc/examples/java-jul/ApplicationContextExample.java

and used it in our test-app with the following variable values-

    private static final String RETRIEVER_NAME = "com_ericsson";
    private static final String CONTEXT_NAME_STRING = "pid";
    private static final String CONTEXT_NAME_SHORT = "ppid";

We have been able to see the logs (with lttng add-context)-

SC-2-1:/home/test-apps # lttng create
Session auto-20160315-165635 created.
Traces will be written in /root/lttng-traces/auto-20160315-165635
SC-2-1:/home/test-apps # lttng enable-event -j -a
All JUL events are enabled in channel channel0
SC-2-1:/home/test-apps # lttng add-context -u -t '$app.com_ericsson:pid'
UST context $app.com_ericsson:pid added to all channels
SC-2-1:/home/test-apps # lttng start
Tracing started for session auto-20160315-165635
SC-2-1:/home/test-apps # lttng stop
Waiting for data availability.
Tracing stopped for session auto-20160315-165635
SC-2-1:/home/test-apps # lttng view
[16:57:18.251115165] (+0.000046477) SC-2-1 lttng_jul:event: { cpu_id = 0 
}, { _app_com_ericsson_pid_tag = ( "_none" : container = 0 ), 
_app_com_ericsson_pid = { none = { } } }, { msg = "KiloPerSec : my_time = 
16:57:18, OnePs = 2, TenPs = 2, HundredPs = 3, KiloPs = 4", logger_name = 
"com.ericsson.common.trace.testapp_thread.testthread", class_name = 
"CBF_testapp.TestThread", method_name = "run", long_millis = 
1458061038251, int_loglevel = 300, int_threadid = 15 }

We are also able to notice loggers if we enable a session with filters 
without prefixes.

Could you please help us find out the way of making proper usage of $app 
as the prefix in lttng enable-event command with filter. 

It would be good if you could share us a Java sample test application with 
Context stuff , list of proper LTTng CLI commands and exact LTTng CTL call 
to be used for activation.

Thanks a lot. 

Best Regards,
Varsha

=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you



--=_alternative 0051D16D65257F77_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I'm working on Latest LTTng with below
commit IDs for Ericsson Trace Project </font>
<br>
<br><font size=2 face="sans-serif">LTTng-UST: &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; 2ef5e79d1f40ce7110d9ad581bb467a9109afeb5</font>
<br><font size=2 face="sans-serif">LTTng-Tools: &nbsp; &nbsp; &nbsp; &nbsp;
b6ba0c85112e48eb1557a2b53542dbd3008e0ca0</font>
<br>
<br><font size=2 face="sans-serif">We are facing an issue in identifying
the way to use $app in LTTng filter. The issue is like follows-</font>
<br>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1:/home/test-apps
# lttng create</font>
<br><font size=2 face="sans-serif">Session auto-20160315-164851 created.</font>
<br><font size=2 face="sans-serif">Traces will be written in /root/lttng-traces/auto-20160315-164851</font>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1:/home/test-apps
# lttng enable-event a -j -a --filter '$ctx.vpid &gt;= 0 &amp;&amp; $ctx.vpid
&lt; 40000'</font>
<br><font size=2 face="sans-serif">Filter '$ctx.vpid &gt;= 0 &amp;&amp;
$ctx.vpid &lt; 40000' successfully set</font>
<br>
<br><font size=2 face="sans-serif">Then start the java test application-</font>
<br>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1:/home/test-apps
# lttng start</font>
<br><font size=2 face="sans-serif">Tracing started for session auto-20160315-164851</font>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1:/home/test-apps
# lttng stop</font>
<br><font size=2 face="sans-serif">Waiting for data availability.</font>
<br><font size=2 face="sans-serif">Tracing stopped for session auto-20160315-164851</font>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1::/home/test-apps
# lttng view</font>
<br><font size=2 color=#0000a1 face="sans-serif">[16:49:20.291293478] (+0.000087520)
SC-2-1 lttng_jul:event: { cpu_id = 0 }, { msg = &quot;KiloPerSec : my_time
= 16:49:19, OnePs = 1, TenPs = 9, HundredPs = 4, KiloPs = 2&quot;, logger_name
= &quot;com.ericsson.common.trace.testapp_thread.testthread&quot;, class_name
= &quot;CBF_testapp.TestThread&quot;, method_name = &quot;run&quot;, long_millis
= 1458060560291, int_loglevel = 300, int_threadid = 15 }</font>
<br>
<br><font size=2 face="sans-serif">We are able to see logs using<b> $ctx</b>
as a filter parameter. </font>
<br>
<br><font size=2 face="sans-serif">The question is how do we use <b>$app</b>
in place of<b> $ctx</b> to get the logs. We checked for LTTng documentation,
but were unable to find something useful in this context. </font>
<br>
<br><font size=2 face="sans-serif">We used the example java file in lttng-ust
location-</font>
<br>
<br><font size=2 color=#0000e0 face="sans-serif">lttng-ust/doc/examples/java-jul/ApplicationContextExample.java</font>
<br>
<br><font size=2 face="sans-serif">and used it in our test-app with the
following variable values-</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp;</font><font size=2 color=#0000e0 face="sans-serif">
private static final String RETRIEVER_NAME = &quot;com_ericsson&quot;;</font>
<br><font size=2 color=#0000e0 face="sans-serif">&nbsp; &nbsp; private
static final String CONTEXT_NAME_STRING = &quot;pid&quot;;</font>
<br><font size=2 color=#0000e0 face="sans-serif">&nbsp; &nbsp; private
static final String CONTEXT_NAME_SHORT = &quot;ppid&quot;;</font>
<br>
<br><font size=2 face="sans-serif">We have been able to see the logs (with
lttng add-context)-</font>
<br>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1:/home/test-apps
# lttng create</font>
<br><font size=2 face="sans-serif">Session auto-20160315-165635 created.</font>
<br><font size=2 face="sans-serif">Traces will be written in /root/lttng-traces/auto-20160315-165635</font>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1:/home/test-apps
# lttng enable-event -j -a</font>
<br><font size=2 face="sans-serif">All JUL events are enabled in channel
channel0</font>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1:/home/test-apps
# lttng add-context -u -t '$app.com_ericsson:pid'</font>
<br><font size=2 face="sans-serif">UST context $app.com_ericsson:pid added
to all channels</font>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1:/home/test-apps
# lttng start</font>
<br><font size=2 face="sans-serif">Tracing started for session auto-20160315-165635</font>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1:/home/test-apps
# lttng stop</font>
<br><font size=2 face="sans-serif">Waiting for data availability.</font>
<br><font size=2 face="sans-serif">Tracing stopped for session auto-20160315-165635</font>
<br><font size=2 color=#0000e0 face="sans-serif">SC-2-1:/home/test-apps
# lttng view</font>
<br><font size=2 color=#0000a1 face="sans-serif">[16:57:18.251115165] (+0.000046477)
SC-2-1 lttng_jul:event: { cpu_id = 0 }, { _app_com_ericsson_pid_tag = (
&quot;_none&quot; : container = 0 ), _app_com_ericsson_pid = { none = {
} } }, { msg = &quot;KiloPerSec : my_time = 16:57:18, OnePs = 2, TenPs
= 2, HundredPs = 3, KiloPs = 4&quot;, logger_name = &quot;com.ericsson.common.trace.testapp_thread.testthread&quot;,
class_name = &quot;CBF_testapp.TestThread&quot;, method_name = &quot;run&quot;,
long_millis = 1458061038251, int_loglevel = 300, int_threadid = 15 }</font>
<br>
<br><font size=2 face="sans-serif">We are also able to notice loggers if
we <b>enable a session with filters without prefixes</b>.</font>
<br>
<br><font size=2 face="sans-serif">Could you please help us find out the
way of making proper usage of $app as the prefix in lttng enable-event
command with filter. </font>
<br>
<br><font size=2 face="sans-serif">It would be good if you could share
us a Java sample test application with Context stuff , list of proper LTTng
CLI commands and exact LTTng CTL call to be used for activation.</font>
<br>
<br><font size=2 face="sans-serif">Thanks a lot. </font>
<br>
<br><font size=2 face="sans-serif">Best Regards,</font>
<br><font size=2 face="sans-serif">Varsha</font>
<br>
<br><p>=====-----=====-----=====<br>
Notice: The information contained in this e-mail<br>
message and/or attachments to it may contain <br>
confidential or privileged information. If you are <br>
not the intended recipient, any dissemination, use, <br>
review, distribution, printing or copying of the <br>
information contained in this e-mail message <br>
and/or attachments to it are strictly prohibited. If <br>
you have received this communication in error, <br>
please notify us by reply e-mail or telephone and <br>
immediately and permanently delete the message <br>
and any attachments. Thank you</p>

<p></p>
--=_alternative 0051D16D65257F77_=--


--===============3082696532473119083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3082696532473119083==--
