From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Will LTTng overwrite existing trace files after
 reboot, or continue where the previous instance left off?
Date: Thu, 13 Jun 2013 08:31:27 +0300
Message-ID: <OFD41F99E2.F0ECC690-ONC2257B89.001E02F9-C2257B89.001E4344__16199.6054965586$1371101543$gmane$org@il.ibm.com>
References: <OFBF5287EA.D7EE217E-ONC2257B88.004F3A88-C2257B88.004FF39E@il.ibm.com>
	<51B88B11.3020401@efficios.com>
	<OF8E263FF5.555C4B70-ONC2257B88.0069603B-C2257B88.006995A6@il.ibm.com>
	<51B8C9A0.9@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1271157921=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Un08Q-0004ym-5S
	for lttng-dev@lists.lttng.org; Thu, 13 Jun 2013 01:31:46 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Thu, 13 Jun 2013 06:27:59 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
	(d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id F126117D8025
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 06:32:59 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5D5VRIK54329520
	for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2013 05:31:27 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5D5VbXg002573
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 23:31:37 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5D5VbIa002565
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 23:31:37 -0600
In-Reply-To: <51B8C9A0.9@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1271157921==
Content-Type: multipart/alternative; boundary="=_alternative 001E431FC2257B89_="

This is a multipart message in MIME format.
--=_alternative 001E431FC2257B89_=
Content-Type: text/plain; charset="US-ASCII"

The answer is simple. It is due to an omission on my part. I have omitted 
a certain detail which is the reason for the overwrite...

When I created the session I used :

lttng-create foo -o /local/lttng/

And I neglected to copy-paste that part into my original message. Mea 
culpe.

Thank you,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Yannick Brosseau <yannick.brosseau@gmail.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     David Goulet <dgoulet@efficios.com>, lttng-dev@lists.lttng.org
Date:   06/12/2013 10:18 PM
Subject:        Re: [lttng-dev] Will LTTng overwrite existing trace files 
after reboot, or continue where the previous instance left off?



On 2013-06-12 15:14, Amit Margalit wrote:
Indeed the path is not different. There is no date-part in the path. I 
simply have ~/lttng-traces/ust/uid/<uid>/64-bit/ ... 
That's really strange, you should have the session name between 
"lttng-traces/" and "ust". 
That feature has been there since the beginning of the 2.x serie if I 
remember well. 

--=_alternative 001E431FC2257B89_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">The answer is simple. It is due to an omission
on my part. I have omitted a certain detail which is the reason for the
overwrite...</font>
<br>
<br><font size=2 face="sans-serif">When I created the session I used :</font>
<br>
<br><tt><font size=2>lttng-create foo -o /local/lttng/</font></tt>
<br>
<br><font size=2 face="sans-serif">And I neglected to copy-paste that part
into my original message. Mea culpe.</font>
<br>
<br><font size=2 face="sans-serif">Thank you,</font>
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
&nbsp;</font><font size=1 face="sans-serif">Yannick Brosseau &lt;yannick.brosseau@gmail.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">David Goulet &lt;dgoulet@efficios.com&gt;,
lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">06/12/2013 10:18 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Will LTTng overwrite existing trace files after reboot, or continue where
the previous instance left off?</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3>On 2013-06-12 15:14, Amit Margalit wrote:</font>
<br><font size=2 face="sans-serif">Indeed the path is <u>not</u> different.
There is no date-part in the path. I simply have ~/lttng-traces/ust/uid/&lt;uid&gt;/64-bit/
...</font><font size=3> </font>
<br><font size=3>That's really strange, you should have the session name
between &quot;lttng-traces/&quot; and &quot;ust&quot;. &nbsp;<br>
That feature has been there since the beginning of the 2.x serie if I remember
well. </font>
<br>
--=_alternative 001E431FC2257B89_=--



--===============1271157921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1271157921==--
