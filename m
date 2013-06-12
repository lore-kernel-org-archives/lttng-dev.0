From: Amit Margalit <AMITM@il.ibm.com>
Subject: Will LTTng overwrite existing trace files after reboot,
 or continue where the previous instance left off?
Date: Wed, 12 Jun 2013 17:34:11 +0300
Message-ID: <OFBF5287EA.D7EE217E-ONC2257B88.004F3A88-C2257B88.004FF39E__29164.9424740628$1371047712$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0182044643=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1Umm86-0000ka-Qi
	for lttng-dev@lists.lttng.org; Wed, 12 Jun 2013 10:34:31 -0400
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 12 Jun 2013 15:29:27 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 359312190019
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 15:37:43 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5CEYBuK52232234
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 14:34:11 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5CEYLoN010195
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 08:34:22 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5CEYL6F010189
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 08:34:21 -0600
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
--===============0182044643==
Content-Type: multipart/alternative; boundary="=_alternative 004FF353C2257B88_="

This is a multipart message in MIME format.
--=_alternative 004FF353C2257B88_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

My situation is this:

lttng-sessiond --no-kernel
lttng-create foo
lttng enable-channel channel0 -u --tracefile-size 67108864 
--tracefile-count 13 --buffers-uid --switch-timer 1000000 --num-subbuf 32
lttng enable-event -u -a
lttng start foo

Now this runs for a while collecting traces. I've run du -s on the trace 
directory, and saw that lttng-traces/ takes 2376KB.

The system was reboot, and upon startup, the exact same scenario as above 
is reproduced.

When I ran du to see the size of the lttng-traces/ directory, it was 
1740KB.

Can you please help explain this? Is LTTng overwriting the existing trace 
files?

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 004FF353C2257B88_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">My situation is this:</font>
<br>
<br><font size=2 face="sans-serif">lttng-sessiond --no-kernel</font>
<br><font size=2 face="sans-serif">lttng-create foo</font>
<br><font size=2 face="sans-serif">lttng enable-channel channel0 -u --tracefile-size
67108864 --tracefile-count 13 --buffers-uid --switch-timer 1000000 --num-subbuf
32</font>
<br><font size=2 face="sans-serif">lttng enable-event -u -a</font>
<br><font size=2 face="sans-serif">lttng start foo</font>
<br>
<br><font size=2 face="sans-serif">Now this runs for a while collecting
traces. I've run du -s on the trace directory, and saw that lttng-traces/
takes 2376KB.</font>
<br>
<br><font size=2 face="sans-serif">The system was reboot, and upon startup,
the exact same scenario as above is reproduced.</font>
<br>
<br><font size=2 face="sans-serif">When I ran du to see the size of the
lttng-traces/ directory, it was 1740KB.</font>
<br>
<br><font size=2 face="sans-serif">Can you please help explain this? Is
LTTng overwriting the existing trace files?</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 004FF353C2257B88_=--



--===============0182044643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0182044643==--
