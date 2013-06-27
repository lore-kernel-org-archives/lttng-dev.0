From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Problem setting a filter during enable-event,
 when done shortly after add-context
Date: Thu, 27 Jun 2013 08:53:09 +0300
Message-ID: <OFD09A7A6C.FC50AD47-ONC2257B97.002031D8-C2257B97.00203FBA__9751.25843328915$1372312442$gmane$org@il.ibm.com>
References: <OFFF997D36.2F2A5DA8-ONC2257B95.0032AE6A-C2257B95.0039FA74@il.ibm.com>
	<51C9A45C.8000706@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0272869534=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Us591-0005wT-DJ
	for lttng-dev@lists.lttng.org; Thu, 27 Jun 2013 01:53:23 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Thu, 27 Jun 2013 06:50:51 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 56B0417D801A
	for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2013 06:54:43 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5R5r4BB48037950
	for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2013 05:53:04 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5R5rEUd005883
	for <lttng-dev@lists.lttng.org>; Wed, 26 Jun 2013 23:53:14 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5R5rElf005879
	for <lttng-dev@lists.lttng.org>; Wed, 26 Jun 2013 23:53:14 -0600
In-Reply-To: <51C9A45C.8000706@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0272869534==
Content-Type: multipart/alternative; boundary="=_alternative 00203EE5C2257B97_="

This is a multipart message in MIME format.
--=_alternative 00203EE5C2257B97_=
Content-Type: text/plain; charset="US-ASCII"

Per your suggestion I created the following bug report:
https://bugs.lttng.org/issues/579

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   David Goulet <dgoulet@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   06/25/2013 05:08 PM
Subject:        Re: [lttng-dev] Problem setting a filter during 
enable-event, when done shortly after add-context



Hi Amit,

Can you please open an issue at bugs.lttng.org so we can have a trace of 
the
issue somewhere along with the fix ?

Thanks!
David

Amit Margalit:
> Hi,
> 
> I seem to have a problem setting a filter during enable-event, which 
happens in
> a script immediately after add-context succeeds. The error is "Error: 
Invalid
> filter bytecode".
> 
> The sequence I am going through is in the following script excerpt:
> 
> lttng-sessiond with --no-kernel -v --verbose-consumer        >> logfile 
2>&1
> lttng create samba -o /local/traces/lttng/20130625114835     >> logfile 
2>&1
> lttng enable-channel channel0 -u \
>                         --tracefile-size ${LTTNG_MAX_TRACE_FILE_SIZE} \
>                         --tracefile-count ${LTTNG_MAX_FILES_PER_CORE} \
>                         --buffers-uid \
>                         --switch-timer 1000000 \
>                         --num-subbuf 16 \
>                         --subbuf-size 262144                 >> logfile 
2>&1
> lttng add-context -u -t procname -s samba -c channel0        >> logfile 
2>&1
> lttng enable-event -u -a --filter '$ctx.procname == "smbd" || 
$ctx.procname ==
> "winbindd"'
> 
> The output is shown here (with the enable-event command-line reproduced:
> 
> Session samba created.
> Traces will be written in /local/traces/lttng/20130625114835
> UST channel channel0 enabled for session samba
> UST context procname added to channel channel0
> /usr/bin/lttng enable-event -u -a --filter '$ctx.procname=="smbd" ||
> $ctx.procname=="winbindd"'
> error syntax error
> Parse error
> Error: Invalid filter bytecode
> 
> If I try to wait after the failure for some time, I can run lttng 
disable-event
> -u -a, and re-run the enable-event with the filter successfully. But I 
tried to
> put the disable-event command in the script and that didn't help - i.e. 
the
> "disable-event" command worked, but the enable-event with filter still 
failed in
> the same way.
> 
> Suggestions?
> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> This body part will be downloaded on demand.



--=_alternative 00203EE5C2257B97_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Per your suggestion I created the following
bug report:</font>
<br><a href=https://bugs.lttng.org/issues/579><font size=2 color=blue face="sans-serif">https://bugs.lttng.org/issues/579</font></a>
<br>
<br><font size=2 color=#000080 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">David Goulet &lt;dgoulet@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">06/25/2013 05:08 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Problem setting a filter during enable-event, when done shortly after add-context</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Hi Amit,<br>
<br>
Can you please open an issue at bugs.lttng.org so we can have a trace of
the<br>
issue somewhere along with the fix ?<br>
<br>
Thanks!<br>
David<br>
<br>
Amit Margalit:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I seem to have a problem setting a filter during enable-event, which
happens in<br>
&gt; a script immediately after add-context succeeds. The error is &quot;Error:
Invalid<br>
&gt; filter bytecode&quot;.<br>
&gt; <br>
&gt; The sequence I am going through is in the following script excerpt:<br>
&gt; <br>
&gt; lttng-sessiond with --no-kernel -v --verbose-consumer &nbsp; &nbsp;
&nbsp; &nbsp;&gt;&gt; logfile 2&gt;&amp;1<br>
&gt; lttng create samba -o /local/traces/lttng/20130625114835 &nbsp; &nbsp;
&gt;&gt; logfile 2&gt;&amp;1<br>
&gt; lttng enable-channel channel0 -u \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; --tracefile-size ${LTTNG_MAX_TRACE_FILE_SIZE} \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; --tracefile-count ${LTTNG_MAX_FILES_PER_CORE} \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; --buffers-uid \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; --switch-timer 1000000 \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; --num-subbuf 16 \<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; --subbuf-size 262144 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &gt;&gt; logfile 2&gt;&amp;1<br>
&gt; lttng add-context -u -t procname -s samba -c channel0 &nbsp; &nbsp;
&nbsp; &nbsp;&gt;&gt; logfile 2&gt;&amp;1<br>
&gt; lttng enable-event -u -a --filter '$ctx.procname == &quot;smbd&quot;
|| $ctx.procname ==<br>
&gt; &quot;winbindd&quot;'<br>
&gt; <br>
&gt; The output is shown here (with the enable-event command-line reproduced:<br>
&gt; <br>
&gt; Session samba created.<br>
&gt; Traces will be written in /local/traces/lttng/20130625114835<br>
&gt; UST channel channel0 enabled for session samba<br>
&gt; UST context procname added to channel channel0<br>
&gt; /usr/bin/lttng enable-event -u -a --filter '$ctx.procname==&quot;smbd&quot;
||<br>
&gt; $ctx.procname==&quot;winbindd&quot;'<br>
&gt; error syntax error<br>
&gt; Parse error<br>
&gt; Error: Invalid filter bytecode<br>
&gt; <br>
&gt; If I try to wait after the failure for some time, I can run lttng
disable-event<br>
&gt; -u -a, and re-run the enable-event with the filter successfully. But
I tried to<br>
&gt; put the disable-event command in the script and that didn't help -
i.e. the<br>
&gt; &quot;disable-event&quot; command worked, but the enable-event with
filter still failed in<br>
&gt; the same way.<br>
&gt; <br>
&gt; Suggestions?<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Amit Margalit<br>
&gt; IBM XIV - /Storage Reinvented/<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; <br>
&gt; <br>
&gt; This body part will be downloaded on demand.<br>
<br>
</font></tt>
<br>
--=_alternative 00203EE5C2257B97_=--



--===============0272869534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0272869534==--
