From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Limitations on subbuf_size / num_subbuf?
Date: Thu, 18 Apr 2013 09:11:07 +0300
Message-ID: <OFC6774750.9138DA2C-ONC2257B51.002189D3-C2257B51.0021DDB3__6119.77378507635$1366265523$gmane$org@il.ibm.com>
References: <OFC51F8E88.28285A69-ONC2257B4D.003B3B3E-C2257B4D.003B6399@il.ibm.com>
	<516C0D60.1050503@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0656307279=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1USi48-00087T-0X
	for lttng-dev@lists.lttng.org; Thu, 18 Apr 2013 02:11:28 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Thu, 18 Apr 2013 07:08:04 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id B6008219002D
	for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2013 07:13:35 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r3I6B9TE46465108
	for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2013 06:11:09 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id r3I6BI8k032005
	for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2013 00:11:18 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with
	ESMTP id r3I6BI2L031992
	for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2013 00:11:18 -0600
In-Reply-To: <516C0D60.1050503@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0656307279==
Content-Type: multipart/alternative; boundary="=_alternative 0021DCE6C2257B51_="

This is a multipart message in MIME format.
--=_alternative 0021DCE6C2257B51_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Thank for the quick response. Here is the missing data:

UST
2.6.32.12-205 (I had to make a tiny patch to make it compile)
MemTotal:       24628852 kB
lttng-ust-2.1.2
lttng-tools-2.1.1
lttng-modules-2.1.1
babeltrace-1.1.0
userspace-rcu-0.7.6

Which patch for 4MB?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Matthew Khouzam <matthew.khouzam@ericsson.com>
To:     <lttng-dev@lists.lttng.org>
Date:   04/15/2013 05:24 PM
Subject:        Re: [lttng-dev] Limitations on subbuf_size / num_subbuf?



Not at all a n00b question, but could you give some more info? what is 
your version of LTTng tools, are you using UST or kernel tracing? How much 
ram is on your system? Kernel version? 

I actually have the patched lttng that has standard subbuffer sizes of 4 
mb, so I have not personnaly seen that problem. But the first thing I 
would do is upgrade to the latest stable.

On 13-04-14 06:49 AM, Amit Margalit wrote:
Hello, 

Sorry for the noob question. I seem to be unable to define the total of 
subbuf_size * num_subbuf higher than 4MB. I am getting ~30% discarded 
tracepoint data. 

Any assistance would be greatly appreciated. 

Amit Margalit 
IBM XIV - Storage Reinvented 
XIV-NAS Development Team 
Tel. 03-689-7774 
Fax. 03-689-7230 

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 0021DCE6C2257B51_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Thank for the quick response. Here is
the missing data:</font>
<br>
<ol>
<li value=1><font size=2 face="sans-serif">UST</font>
<li value=2><font size=2 face="sans-serif">2.6.32.12-205 (I had to make
a tiny patch to make it compile)</font>
<li value=3><font size=2 face="sans-serif">MemTotal: &nbsp; &nbsp; &nbsp;
24628852 kB</font>
<li value=4><font size=2 face="sans-serif">lttng-ust-2.1.2</font>
<li value=5><font size=2 face="sans-serif">lttng-tools-2.1.1</font>
<li value=6><font size=2 face="sans-serif">lttng-modules-2.1.1</font>
<li value=7><font size=2 face="sans-serif">babeltrace-1.1.0</font>
<li value=8><font size=2 face="sans-serif">userspace-rcu-0.7.6</font></ol>
<br><font size=2 face="sans-serif">Which patch for 4MB?</font>
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
&nbsp;</font><font size=1 face="sans-serif">Matthew Khouzam &lt;matthew.khouzam@ericsson.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">&lt;lttng-dev@lists.lttng.org&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">04/15/2013 05:24 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Limitations on subbuf_size / num_subbuf?</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3>Not at all a n00b question, but could you give some more
info? what is your version of LTTng tools, are you using UST or kernel
tracing? How much ram is on your system? Kernel version? <br>
<br>
I actually have the patched lttng that has standard subbuffer sizes of
4 mb, so I have not personnaly seen that problem. But the first thing I
would do is upgrade to the latest stable.<br>
</font>
<br><font size=3>On 13-04-14 06:49 AM, Amit Margalit wrote:</font>
<br><font size=2 face="sans-serif">Hello,</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
Sorry for the noob question. I seem to be unable to define the total of
subbuf_size * num_subbuf higher than 4MB. I am getting ~30% discarded tracepoint
data.</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
Any assistance would be greatly appreciated.</font><font size=3> <br>
</font><font size=2 color=#000080 face="sans-serif"><br>
Amit Margalit</font><font size=3> </font><font size=2 color=#808000 face="sans-serif"><br>
IBM XIV </font><font size=2 face="sans-serif">- <i>Storage Reinvented</i></font><font size=3>
</font><font size=2 face="sans-serif"><br>
XIV-NAS Development Team</font><font size=3> </font><font size=2 face="sans-serif"><br>
Tel. 03</font><font size=2 face="Arial">-689-7774</font><font size=3> </font><font size=2 face="Arial"><br>
Fax. 03-689-7230</font><font size=3> <br>
</font>
<br><tt><font size=3>_______________________________________________<br>
lttng-dev mailing list<br>
</font></tt><a href="mailto:lttng-dev@lists.lttng.org"><tt><font size=3 color=blue><u>lttng-dev@lists.lttng.org</u></font></tt></a><tt><font size=3><br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=3 color=blue><u>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</u></font></tt></a><tt><font size=3><br>
</font></tt>
<br><tt><font size=2>_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
</font></tt>
<br>
--=_alternative 0021DCE6C2257B51_=--



--===============0656307279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0656307279==--
