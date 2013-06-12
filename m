From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Will LTTng overwrite existing trace files after
 reboot, or continue where the previous instance left off?
Date: Wed, 12 Jun 2013 22:14:10 +0300
Message-ID: <OF8E263FF5.555C4B70-ONC2257B88.0069603B-C2257B88.006995A6__7985.67374372414$1371064509$gmane$org@il.ibm.com>
References: <OFBF5287EA.D7EE217E-ONC2257B88.004F3A88-C2257B88.004FF39E@il.ibm.com>
	<51B88B11.3020401@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1432834638=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UmqV4-0002zJ-A7
	for lttng-dev@lists.lttng.org; Wed, 12 Jun 2013 15:14:30 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 12 Jun 2013 20:10:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
	(d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B006A17D801A
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 20:15:43 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r5CJEB3M54198524
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 19:14:11 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r5CJELGZ013973
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 13:14:21 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r5CJELZT013969
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 13:14:21 -0600
In-Reply-To: <51B88B11.3020401@efficios.com>
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
--===============1432834638==
Content-Type: multipart/alternative; boundary="=_alternative 00699518C2257B88_="

This is a multipart message in MIME format.
--=_alternative 00699518C2257B88_=
Content-Type: text/plain; charset="US-ASCII"

Indeed the path is not different. There is no date-part in the path. I 
simply have ~/lttng-traces/ust/uid/<uid>/64-bit/ ...

Please remember that I use 2.2.0rc2 and not the latest master. 
Unfortunately, I must retain some level of stability, so if the addition 
of the date part in the path for per-uid buffers is later than 2.2.0rc2 - 
that would be the cause of the difference.

Amit

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   David Goulet <dgoulet@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   06/12/2013 05:51 PM
Subject:        Re: [lttng-dev] Will LTTng overwrite existing trace files 
after reboot, or continue where the previous instance left off?



It's possible yes if the session path is exactly the same but this is why 
we add
the date and time to the session directory so we don't end up overwriting 
old
traces with the same session name.

Can you tell me what is the full path of the session directory. It should 
look
something like (with some variations).

~/lttng-traces/fo-20130612-104743/ust/uid/1000/64-bit

Upon reboot, can you confirm that the path is different ?

Thanks!
David

Amit Margalit:
> Hi,
> 
> My situation is this:
> 
> lttng-sessiond --no-kernel
> lttng-create foo
> lttng enable-channel channel0 -u --tracefile-size 67108864 
--tracefile-count 13
> --buffers-uid --switch-timer 1000000 --num-subbuf 32
> lttng enable-event -u -a
> lttng start foo
> 
> Now this runs for a while collecting traces. I've run du -s on the trace
> directory, and saw that lttng-traces/ takes 2376KB.
> 
> The system was reboot, and upon startup, the exact same scenario as 
above is
> reproduced.
> 
> When I ran du to see the size of the lttng-traces/ directory, it was 
1740KB.
> 
> Can you please help explain this? Is LTTng overwriting the existing 
trace files?
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



--=_alternative 00699518C2257B88_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Indeed the path is <u>not</u> different.
There is no date-part in the path. I simply have ~/lttng-traces/ust/uid/&lt;uid&gt;/64-bit/
...</font>
<br>
<br><font size=2 face="sans-serif">Please remember that I use 2.2.0rc2
and not the latest master. Unfortunately, I must retain some level of stability,
so if the addition of the date part in the path for per-uid buffers is
later than 2.2.0rc2 - that would be the cause of the difference.</font>
<br>
<br><font size=2 face="sans-serif">Amit</font>
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
&nbsp;</font><font size=1 face="sans-serif">06/12/2013 05:51 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Will LTTng overwrite existing trace files after reboot, or continue where
the previous instance left off?</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>It's possible yes if the session path is exactly the
same but this is why we add<br>
the date and time to the session directory so we don't end up overwriting
old<br>
traces with the same session name.<br>
<br>
Can you tell me what is the full path of the session directory. It should
look<br>
something like (with some variations).<br>
<br>
~/lttng-traces/fo-20130612-104743/ust/uid/1000/64-bit<br>
<br>
Upon reboot, can you confirm that the path is different ?<br>
<br>
Thanks!<br>
David<br>
<br>
Amit Margalit:<br>
&gt; Hi,<br>
&gt; <br>
&gt; My situation is this:<br>
&gt; <br>
&gt; lttng-sessiond --no-kernel<br>
&gt; lttng-create foo<br>
&gt; lttng enable-channel channel0 -u --tracefile-size 67108864 --tracefile-count
13<br>
&gt; --buffers-uid --switch-timer 1000000 --num-subbuf 32<br>
&gt; lttng enable-event -u -a<br>
&gt; lttng start foo<br>
&gt; <br>
&gt; Now this runs for a while collecting traces. I've run du -s on the
trace<br>
&gt; directory, and saw that lttng-traces/ takes 2376KB.<br>
&gt; <br>
&gt; The system was reboot, and upon startup, the exact same scenario as
above is<br>
&gt; reproduced.<br>
&gt; <br>
&gt; When I ran du to see the size of the lttng-traces/ directory, it was
1740KB.<br>
&gt; <br>
&gt; Can you please help explain this? Is LTTng overwriting the existing
trace files?<br>
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
--=_alternative 00699518C2257B88_=--



--===============1432834638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1432834638==--
