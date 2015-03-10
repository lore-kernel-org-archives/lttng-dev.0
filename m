From: Venkata Kantimahanthi <venkata.kantimahanthi@tcs.com>
Subject: Regarding lttng enable-event using filter option
Date: Tue, 10 Mar 2015 10:58:23 +0530
Message-ID: <OF2679224C.7D5F648E-ON65257E04.001D6D14-65257E04.001E1BBD__39607.8503960327$1425965373$gmane$org@tcs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0380296363=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from inblrg02.tcs.com ([121.242.48.116])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=5045a7649=venkata.kantimahanthi@tcs.com>)
 id 1YVCiW-0002xx-GJ
 for lttng-dev@lists.lttng.org; Tue, 10 Mar 2015 01:28:34 -0400
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
--===============0380296363==
Content-Type: multipart/alternative; boundary="=_alternative 001E1BBD65257E04_="

This is a multipart message in MIME format.
--=_alternative 001E1BBD65257E04_=
Content-Type: text/plain; charset="US-ASCII"

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



--=_alternative 001E1BBD65257E04_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi ,</font>
<br>
<br><font size=2 face="sans-serif">I am trying to filter the following
trace using lttng command but it was not filter out . Can any one help
me?</font>
<br>
<br><font size=2 face="sans-serif">[1970-01-01 00:04:58.386338797] (+0.000003280)
oamhost com_ericsson_trithread:TRACE_UTS: { cpu_id = 19 }, { sec = 333,
usec = 2222, process = &quot;test111&quot;, fileAndLine = &quot;demo_legacy.c:123&quot;,
msg = &quot;This is a TRACE_UTS from test3&quot;, _dataUts_length = 0,
dataUts = [ ] }</font>
<br><font size=2 face="sans-serif">lttng enable-event -s sessionname -c
ch1 -u -filter 'strfield =! &quot;TRACE_UTS&quot;' com_ericsson_tri*</font>
<br>
<br><font size=2 face="sans-serif">o/p</font>
<br><font size=2 face="sans-serif">Event com_ericsson_tri*: Filter 'strfield
== &quot;TRACE_UTS&quot;' successfully set</font>
<br>
<br><font size=2 face="sans-serif">So , If I have enabled above event with
filter , the traces which have string field with TRACE_UTS as data should
not be logged. This is as per my understanding. Is is correct ?</font>
<br>
<br><font size=2 face="sans-serif">Because the traces were not filtered.<br>
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
--=_alternative 001E1BBD65257E04_=--



--===============0380296363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0380296363==--
