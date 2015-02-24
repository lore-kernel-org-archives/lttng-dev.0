From: Venkata Kantimahanthi <venkata.kantimahanthi@tcs.com>
Subject: lttng live session is not started
Date: Tue, 24 Feb 2015 09:30:52 +0530
Message-ID: <OF57233469.DA109797-ON65257DF6.00152C3D-65257DF6.001612C3__33194.85393954$1424750515$gmane$org@tcs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1033100178=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from inblrg02.tcs.com ([121.242.48.116])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=490632ad1=venkata.kantimahanthi@tcs.com>)
 id 1YQ6gA-0002cx-MT
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 23:01:06 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1033100178==
Content-Type: multipart/alternative; boundary="=_alternative 001612C365257DF6_="

This is a multipart message in MIME format.
--=_alternative 001612C365257DF6_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I am trying to start a live session on a board .

Step1: On workstation, terminal1: lttng-relayd -vvv >& 
/home/ervanho/logs/lttng_startStopStart.log
Step2: On "target" lttng create testC2 --live -U net://137.58.215.77
Step3: On "target" lttng enable-event '*' --userspace --session testC2 
--loglevel INFO
Step4 : On Workstation terminal2: babeltrace -i lttng-live 
net://127.0.0.1/host/du1/testC2
Step5 : On "target" lttng start testC2
After this step streaming should have started but not happening
Step6 On "target" lttng stop testC2
Step7 On "target" lttng start testC2 

But after these two steps I could see the traces getting streamed.

Any idea why it was happening. Any configuration that I need to check for.
I am using babeltrace 1.2.4 and LTTng Trace Control 2.5.3


Thanks & Regards
Venkata Ranganadh Kantimahanthi
Tata Consultancy Services
Cell:- +919494595225
Mailto: venkata.kantimahanthi@tcs.com
Website: http://www.tcs.com
____________________________________________
Experience certainty.   IT Services
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



--=_alternative 001612C365257DF6_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I am trying to start a live session
on a board .</font>
<br>
<br><font size=2 face="sans-serif"><b>Step1</b>: On workstation, terminal1:</font><font size=2 color=#4181ff face="sans-serif">
lttng-relayd -vvv &gt;&amp; /home/ervanho/logs/lttng_startStopStart.log</font><font size=2 face="sans-serif"><br>
<b>Step2:</b> On &quot;target&quot;</font><font size=2 color=#4181ff face="sans-serif">
lttng create testC2 --live -U net://137.58.215.77</font><font size=2 face="sans-serif"><br>
<b>Step3:</b> On &quot;target&quot; </font><font size=2 color=#0062e1 face="sans-serif">lttng
enable-event '*' --userspace --session testC2 --loglevel INFO</font><font size=2 face="sans-serif"><br>
<b>Step4 :</b> On Workstation terminal2: </font><font size=2 color=#0062e1 face="sans-serif">babeltrace
-i lttng-live net://127.0.0.1/host/du1/testC2</font><font size=2 face="sans-serif"><br>
<b>Step5 :</b> On &quot;target&quot;</font><font size=2 color=#4181c0 face="sans-serif">
lttng start testC2</font>
<br><font size=2 color=red face="sans-serif">After this step streaming
should have started but not happening</font><font size=2 face="sans-serif"><br>
Step6 On &quot;target&quot;</font><font size=2 color=#0062e1 face="sans-serif">
lttng stop testC</font><font size=2 face="sans-serif">2<br>
Step7 On &quot;target&quot; l</font><font size=2 color=#0062e1 face="sans-serif">ttng
start testC2 </font>
<br>
<br><font size=2 face="sans-serif">But after these two steps I could see
the traces getting streamed.</font>
<br>
<br><font size=2 face="sans-serif">Any idea why it was happening. Any configuration
that I need to check for.</font>
<br><font size=2 face="sans-serif">I am using </font><font size=1 color=#4181ff face="Arial">babeltrace
1.2.4 and LTTng Trace Control 2.5.3</font>
<br><font size=2 face="sans-serif"><br>
<br>
Thanks &amp; Regards<br>
Venkata Ranganadh Kantimahanthi<br>
Tata Consultancy Services<br>
Cell:- +919494595225<br>
Mailto: venkata.kantimahanthi@tcs.com<br>
Website: </font><a href=http://www.tcs.com/><font size=2 face="sans-serif">http://www.tcs.com</font></a><font size=2 face="sans-serif"><br>
____________________________________________<br>
Experience certainty. &nbsp; &nbsp; &nbsp; &nbsp;IT Services<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;Business Solutions<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;Consulting<br>
____________________________________________</font><p>=====-----=====-----=====<br>
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
--=_alternative 001612C365257DF6_=--



--===============1033100178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1033100178==--
