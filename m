From: Amit Margalit <AMITM@il.ibm.com>
Subject: Problem setting a filter during enable-event,
	when done shortly after add-context
Date: Tue, 25 Jun 2013 13:34:11 +0300
Message-ID: <OFFF997D36.2F2A5DA8-ONC2257B95.0032AE6A-C2257B95.0039FA74__21860.8574978591$1372156505$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1594315247=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UrQZv-0006CK-Ip
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 06:34:27 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 25 Jun 2013 11:29:08 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D6C631B08023
	for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2013 11:34:18 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5PAY7Ga54329586
	for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2013 10:34:07 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5PAYHK1027826
	for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2013 06:34:17 -0400
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5PAYHbU027823
	for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2013 06:34:17 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1594315247==
Content-Type: multipart/alternative; boundary="=_alternative 0039F9BFC2257B95_="

This is a multipart message in MIME format.
--=_alternative 0039F9BFC2257B95_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I seem to have a problem setting a filter during enable-event, which 
happens in a script immediately after add-context succeeds. The error is 
"Error: Invalid filter bytecode".

The sequence I am going through is in the following script excerpt:

lttng-sessiond with --no-kernel -v --verbose-consumer        >> logfile 
2>&1
lttng create samba -o /local/traces/lttng/20130625114835     >> logfile 
2>&1
lttng enable-channel channel0 -u \
                        --tracefile-size ${LTTNG_MAX_TRACE_FILE_SIZE} \
                        --tracefile-count ${LTTNG_MAX_FILES_PER_CORE} \
                        --buffers-uid \
                        --switch-timer 1000000 \
                        --num-subbuf 16 \
                        --subbuf-size 262144                 >> logfile 
2>&1
lttng add-context -u -t procname -s samba -c channel0        >> logfile 
2>&1
lttng enable-event -u -a --filter '$ctx.procname == "smbd" || 
$ctx.procname == "winbindd"'

The output is shown here (with the enable-event command-line reproduced:

Session samba created.
Traces will be written in /local/traces/lttng/20130625114835
UST channel channel0 enabled for session samba
UST context procname added to channel channel0
/usr/bin/lttng enable-event -u -a --filter '$ctx.procname=="smbd" || 
$ctx.procname=="winbindd"'
error syntax error
Parse error
Error: Invalid filter bytecode

If I try to wait after the failure for some time, I can run lttng 
disable-event -u -a, and re-run the enable-event with the filter 
successfully. But I tried to put the disable-event command in the script 
and that didn't help - i.e. the "disable-event" command worked, but the 
enable-event with filter still failed in the same way.

Suggestions?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 0039F9BFC2257B95_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I seem to have a problem setting a filter
during enable-event, which happens in a script immediately after add-context
succeeds. The error is &quot;Error: Invalid filter bytecode&quot;.</font>
<br>
<br><font size=2 face="sans-serif">The sequence I am going through is in
the following script excerpt:</font>
<br>
<br><tt><font size=2>lttng-sessiond with --no-kernel -v --verbose-consumer
&nbsp; &nbsp; &nbsp; &nbsp;&gt;&gt; logfile 2&gt;&amp;1</font></tt>
<br><tt><font size=2>lttng create samba -o /local/traces/lttng/20130625114835
&nbsp; &nbsp; &gt;&gt; logfile 2&gt;&amp;1</font></tt>
<br><tt><font size=2>lttng enable-channel channel0 -u \</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; --tracefile-size ${LTTNG_MAX_TRACE_FILE_SIZE}
\</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; --tracefile-count ${LTTNG_MAX_FILES_PER_CORE}
\</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; --buffers-uid \</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; --switch-timer 1000000 \</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; --num-subbuf 16 \</font></tt>
<br><tt><font size=2>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; --subbuf-size 262144 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &gt;&gt; logfile 2&gt;&amp;1</font></tt>
<br><tt><font size=2>lttng add-context -u -t procname -s samba -c channel0
&nbsp; &nbsp; &nbsp; &nbsp;&gt;&gt; logfile 2&gt;&amp;1</font></tt>
<br><tt><font size=2>lttng enable-event -u -a --filter '$ctx.procname ==
&quot;smbd&quot; || $ctx.procname == &quot;winbindd&quot;'</font></tt>
<br>
<br><font size=2 face="sans-serif">The output is shown here (with the enable-event
command-line reproduced:</font>
<br>
<br><tt><font size=2>Session samba created.</font></tt>
<br><tt><font size=2>Traces will be written in /local/traces/lttng/20130625114835</font></tt>
<br><tt><font size=2>UST channel channel0 enabled for session samba</font></tt>
<br><tt><font size=2>UST context procname added to channel channel0</font></tt>
<br><tt><font size=2>/usr/bin/lttng enable-event -u -a --filter '$ctx.procname==&quot;smbd&quot;
|| $ctx.procname==&quot;winbindd&quot;'</font></tt>
<br><tt><font size=2>error syntax error</font></tt>
<br><tt><font size=2>Parse error</font></tt>
<br><tt><font size=2>Error: Invalid filter bytecode</font></tt>
<br>
<br><font size=2 face="sans-serif">If I try to wait after the failure for
some time, I can run lttng disable-event -u -a, and re-run the enable-event
with the filter successfully. But I tried to put the disable-event command
in the script and that didn't help - i.e. the &quot;disable-event&quot;
command worked, but the enable-event with filter still failed in the same
way.</font>
<br>
<br><font size=2 face="sans-serif">Suggestions?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 0039F9BFC2257B95_=--



--===============1594315247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1594315247==--
