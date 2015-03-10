From: Venkata Kantimahanthi <venkata.kantimahanthi@tcs.com>
Subject: Re: Regarding lttng enable-event using filter option
Date: Tue, 10 Mar 2015 16:20:30 +0530
Message-ID: <OFF484EE00.DF40F096-ON65257E04.00374D7D-65257E04.003B9995__45092.2125521631$1425984698$gmane$org@tcs.com>
References: <OF2679224C.7D5F648E-ON65257E04.001D6D14-65257E04.001E1BBD@tcs.com>
 <CAJaGzgtjOTmNBJy05eQCW_q8jQpv2H0ABc-CMGnVRCNXYPGESg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0474648433=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from inblrg02.tcs.com ([121.242.48.116])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=5045a7649=venkata.kantimahanthi@tcs.com>)
 id 1YVHkF-0004lM-A1
 for lttng-dev@lists.lttng.org; Tue, 10 Mar 2015 06:50:43 -0400
In-Reply-To: <CAJaGzgtjOTmNBJy05eQCW_q8jQpv2H0ABc-CMGnVRCNXYPGESg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Glen Keane <glenkeane.94@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0474648433==
Content-Type: multipart/alternative; boundary="=_alternative 003B999465257E04_="

This is a multipart message in MIME format.
--=_alternative 003B999465257E04_=
Content-Type: text/plain; charset="US-ASCII"

Hi ,

I haven't correctly formatted my previous mail. Actually I tried like that 
yet I see that trace logged . You have any idea ?
See, my requirement is that I have to filter the traces through message 
(data) written in the trace.
More over is there any filtering that can be done using bit values in a 
integer data supported in lttng ?

Thanks & Regards
Venkata Ranganadh Kantimahanthi




From:   Glen Keane <glenkeane.94@gmail.com>
To:     Venkata Kantimahanthi <venkata.kantimahanthi@tcs.com>
Date:   03/10/2015 03:17 PM
Subject:        Re: [lttng-dev] Regarding lttng enable-event using filter 
option



Hey,

I believe you have it wrong, with that filter, only the messages 
with strfield == "TRACE_UTS" will be logged.

Try strfield != "TRACE_UTS"

I use a filter to filter traces based on process using the pid, and so to 
filter trace processes by their pid, I use the following:
$ctx.vpid == XYZ, where XYZ is the pid of the process I want to trace. 

I hope this helps,
Glen Keane.

On Tue, Mar 10, 2015 at 5:28 AM, Venkata Kantimahanthi <
venkata.kantimahanthi@tcs.com> wrote:
Hi , 

I am trying to filter the following trace using lttng command but it was 
not filter out . Can any one help me? 

[1970-01-01 00:04:58.386338797] (+0.000003280) oamhost 
com_ericsson_trithread:TRACE_UTS: { cpu_id = 19 }, { sec = 333, usec = 
2222, process = "test111", fileAndLine = "demo_legacy.c:123", msg = "This 
is a TRACE_UTS from test3", _dataUts_length = 0, dataUts = [ ] } 
lttng enable-event -s sessionname -c ch1 -u -filter 'strfield =! 
"TRACE_UTS"' com_ericsson_tri* 

o/p 
Event com_ericsson_tri*: Filter 'strfield == "TRACE_UTS"' successfully set 


So , If I have enabled above event with filter , the traces which have 
string field with TRACE_UTS as data should not be logged. This is as per 
my understanding. Is is correct ? 

Because the traces were not filtered.

Thanks & Regards
Venkata Ranganadh Kantimahanthi
Tata Consultancy Services
Cell:- +919494595225
Mailto: venkata.kantimahanthi@tcs.com
Website: http://www.tcs.com
____________________________________________
Experience certainty.        IT Services
                       Business Solutions
                       Consulting
____________________________________________
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

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--=_alternative 003B999465257E04_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi ,</font>
<br>
<br><font size=2 face="sans-serif">I haven't correctly formatted my previous
mail. Actually I tried like that yet I see that trace logged . You have
any idea ?</font>
<br><font size=2 face="sans-serif">See, my requirement is that I have to
filter the traces through message (data) written in the trace.</font>
<br><font size=2 face="sans-serif">More over is there any filtering that
can be done using bit values in a integer data supported in lttng ?</font>
<br><font size=2 face="sans-serif"><br>
Thanks &amp; Regards<br>
Venkata Ranganadh Kantimahanthi<br>
</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Glen Keane &lt;glenkeane.94@gmail.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Venkata Kantimahanthi
&lt;venkata.kantimahanthi@tcs.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">03/10/2015 03:17 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Regarding lttng enable-event using filter option</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3>Hey,<br>
<br>
I believe you have it wrong, with that filter, only the messages with&nbsp;strfield
== &quot;TRACE_UTS&quot; will be logged.<br>
<br>
Try strfield != &quot;</font><font size=3 face="sans-serif">TRACE_UTS&quot;</font><font size=3><br>
</font><font size=3 face="sans-serif"><br>
I use a filter to filter traces based on process using the pid, and so
to filter trace processes by their pid, I use the following:<br>
$ctx.vpid == XYZ, where XYZ is the pid of the process I want to trace.&nbsp;</font><font size=3><br>
</font><font size=3 face="sans-serif"><br>
I hope this helps,<br>
Glen Keane.</font>
<br>
<br><font size=3>On Tue, Mar 10, 2015 at 5:28 AM, Venkata Kantimahanthi
&lt;</font><a href=mailto:venkata.kantimahanthi@tcs.com target=_blank><font size=3 color=blue><u>venkata.kantimahanthi@tcs.com</u></font></a><font size=3>&gt;
wrote:</font>
<br><font size=3 face="sans-serif">Hi ,</font><font size=3> <br>
</font><font size=3 face="sans-serif"><br>
I am trying to filter the following trace using lttng command but it was
not filter out . Can any one help me?</font><font size=3> <br>
</font><font size=3 face="sans-serif"><br>
[1970-01-01 00:04:58.386338797] (+0.000003280) oamhost com_ericsson_trithread:TRACE_UTS:
{ cpu_id = 19 }, { sec = 333, usec = 2222, process = &quot;test111&quot;,
fileAndLine = &quot;demo_legacy.c:123&quot;, msg = &quot;This is a TRACE_UTS
from test3&quot;, _dataUts_length = 0, dataUts = [ ] }</font><font size=3>
</font><font size=3 face="sans-serif"><br>
lttng enable-event -s sessionname -c ch1 -u -filter 'strfield =! &quot;TRACE_UTS&quot;'
com_ericsson_tri*</font><font size=3> <br>
</font><font size=3 face="sans-serif"><br>
o/p</font><font size=3> </font><font size=3 face="sans-serif"><br>
Event com_ericsson_tri*: Filter 'strfield == &quot;TRACE_UTS&quot;' successfully
set</font><font size=3> <br>
</font><font size=3 face="sans-serif"><br>
So , If I have enabled above event with filter , the traces which have
string field with TRACE_UTS as data should not be logged. This is as per
my understanding. Is is correct ?</font><font size=3> <br>
</font><font size=3 face="sans-serif"><br>
Because the traces were not filtered.<br>
<br>
Thanks &amp; Regards<br>
Venkata Ranganadh Kantimahanthi<br>
Tata Consultancy Services<br>
Cell:- </font><a href=tel:%2B919494595225 target=_blank><font size=3 color=blue face="sans-serif"><u>+919494595225</u></font></a><font size=3 face="sans-serif"><br>
Mailto: </font><a href=mailto:venkata.kantimahanthi@tcs.com target=_blank><font size=3 color=blue face="sans-serif"><u>venkata.kantimahanthi@tcs.com</u></font></a><font size=3 face="sans-serif"><br>
Website: </font><a href=http://www.tcs.com/ target=_blank><font size=3 color=blue face="sans-serif"><u>http://www.tcs.com</u></font></a><font size=3 face="sans-serif"><br>
____________________________________________<br>
Experience certainty. &nbsp; &nbsp; &nbsp; &nbsp;IT Services<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;Business Solutions<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;Consulting<br>
____________________________________________</font>
<br><font size=3>=====-----=====-----=====<br>
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
and any attachments. Thank you</font>
<br><font size=3><br>
_______________________________________________<br>
lttng-dev mailing list</font><font size=3 color=blue><u><br>
</u></font><a href="mailto:lttng-dev@lists.lttng.org"><font size=3 color=blue><u>lttng-dev@lists.lttng.org</u></font></a><font size=3 color=blue><u><br>
</u></font><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=_blank><font size=3 color=blue><u>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</u></font></a><font size=3><br>
</font>
<br>
<br>
--=_alternative 003B999465257E04_=--


--===============0474648433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0474648433==--
