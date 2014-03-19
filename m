From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Performance impact using the "filter" option
Date: Wed, 19 Mar 2014 15:14:44 +0200
Message-ID: <OF6F0C7C97.315DE372-ONC2257CA0.00489386-C2257CA0.0048D132__10435.7359734879$1395234975$gmane$org@il.ibm.com>
References: <CANRvXTPktqrjRDa8WvRV=UoJi97mQT6bXVZr8==Ta8DjkkuiCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0582839858=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1WQGKm-0004v0-He
	for lttng-dev@lists.lttng.org; Wed, 19 Mar 2014 09:15:10 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 19 Mar 2014 13:14:58 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id E62491B0804B
	for <lttng-dev@lists.lttng.org>; Wed, 19 Mar 2014 13:14:46 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id s2JDEjLX30867618
	for <lttng-dev@lists.lttng.org>; Wed, 19 Mar 2014 13:14:45 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id s2JDEuVH001421
	for <lttng-dev@lists.lttng.org>; Wed, 19 Mar 2014 09:14:56 -0400
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id s2JDEuIh001416
	for <lttng-dev@lists.lttng.org>; Wed, 19 Mar 2014 09:14:56 -0400
In-Reply-To: <CANRvXTPktqrjRDa8WvRV=UoJi97mQT6bXVZr8==Ta8DjkkuiCQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ilya Mirsky <ilya.mirsky@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0582839858==
Content-Type: multipart/alternative; boundary="=_alternative 0048D0F8C2257CA0_="

This is a multipart message in MIME format.
--=_alternative 0048D0F8C2257CA0_=
Content-Type: text/plain; charset="US-ASCII"

If I understand correctly, filtering is done at the client application 
side.

This means that filtering could theoretically lower the performance of the 
running application which has to check, for each event, whether it should 
be sent to the daemon or not.

Naturally, if you filter some events, the chances of losing events due to 
congestion at the daemon are lower.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Ilya Mirsky <ilya.mirsky@gmail.com>
To:     lttng-dev@lists.lttng.org
Date:   03/19/2014 02:47 PM
Subject:        [lttng-dev] Performance impact using the "filter" option



Hi all,

It's a simple question, but I couldn't find the answer in the 
documentation.
Figured out I'll ask here before looking this in the code.

Should I expect LTTng's overhead to be lower when filtering some of the 
trace points,
or is the main overhead is due to the trace point call and not the 
recording itself?
In practice I see no noticeable difference in performance, 
while I was hoping to get at least some improvement...

Thanks,
Ilya



_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 0048D0F8C2257CA0_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">If I understand correctly, filtering is
done at the client application side.</font>
<br>
<br><font size=2 face="sans-serif">This means that filtering could theoretically
lower the performance of the running application which has to check, for
each event, whether it should be sent to the daemon or not.</font>
<br>
<br><font size=2 face="sans-serif">Naturally, if you filter some events,
the chances of losing events due to congestion at the daemon are lower.</font>
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
&nbsp;</font><font size=1 face="sans-serif">Ilya Mirsky &lt;ilya.mirsky@gmail.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">03/19/2014 02:47 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">[lttng-dev]
Performance impact using the &quot;filter&quot; option</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3>Hi all,</font>
<br>
<br><font size=3>It's a simple question, but I couldn't find the answer
in the documentation.</font>
<br><font size=3>Figured out I'll ask here before looking this in the code.</font>
<br>
<br><font size=3>Should I expect LTTng's overhead to be lower when filtering
some of the trace points,</font>
<br><font size=3>or is the main overhead is due to the trace point call
and not the recording itself?</font>
<br><font size=3>In practice I see no noticeable difference in performance,&nbsp;</font>
<br><font size=3>while I was hoping to get at least some improvement...</font>
<br>
<br><font size=3>Thanks,</font>
<br><font size=3>Ilya</font>
<br>
<br>
<br>
<br><tt><font size=2>_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
</font></tt>
<br>
--=_alternative 0048D0F8C2257CA0_=--



--===============0582839858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0582839858==--
